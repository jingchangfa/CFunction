//
//  CFFMDBManager.m
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFFMDBManager.h"
#import <FMDB/FMDB.h>//fmdb
#import "CFFMDBConfiguration.h"//配置文件
#import "CFFMDBModelToSQL.h"//解析model实例对象
#import "CFFMDBSQLToModel.h"//转化为model实例对象

#import "CFFMDBSQLStatement.h"//将解析结果转化为sql语句

@interface CFFMDBManager ()
@property (nonatomic,strong)FMDatabaseQueue *dbQueue;
@property (nonatomic,strong)NSString *name;
//用来存储class的数组(保证程序运行过程中，只会走一次创建表)
@property (nonatomic,strong)NSMutableArray *classNameArray;
@end

@implementation CFFMDBManager
-(instancetype)initWithDataBaseName:(NSString *)name{
    self = [super init];
    if (self) {
        self.name = name;//数据库名称的一部分，忘记就会丢库～～
    }
    return self;
}
/**
 * 建表
 * 创建CFFMDBSQLStatement
 * 1. 判断表是否存在，存在则继续执行第二步,（不存在不需要执行第二步）
 * 2. 判断是否属性有增，增加新列
 */
- (CFFMDBSQLStatement *)createTableActionWithModelDictionary:(NSDictionary *)modelDictionary AndDB:(FMDatabase *)db AndRollback:(BOOL *)rollback{
    // 创建sql语句生产者
    CFFMDBSQLStatement *statement = [[CFFMDBSQLStatement alloc] initWithModelPropertyDictionary:modelDictionary];
    NSString *tableName = statement.classNameString;
    if ([self.classNameArray containsObject:tableName]) {//没个类只会走一次
        return statement;
    }
    __block BOOL res = YES;
    __block FMResultSet *rs = nil;
    [statement isHaveTableSQLStringWith:^(NSString *sqlString, NSString *tableName) {
        rs = [db executeQuery:sqlString,tableName];
    }];
    BOOL isCreate = NO;
    while ([rs next]) {
        NSInteger count = [rs intForColumn:@"count"];
        if (count != 0) isCreate = YES;
    }
    if (isCreate) {//已经创建：添加tab的 新列
        NSArray *columns = [self dataBaseProertyByFMDatabase:db AndTableName:tableName];
        [statement tableNeedAddNewColumnByTableAllColunm:columns AndSQLBlock:^(NSString *sqlString) {
            if (![db executeUpdate:sqlString]) {
                res = NO;
                *rollback = YES;
            }
        }];
    }else{ //未被创建：创建tab
        NSString *tableCreateSQLString = [statement createSQLTable];
        if (![db executeUpdate:tableCreateSQLString]) {
            res = NO;
            *rollback = YES;
        };
        NSLog(@"创建一个table - %@ -%@ -%@",tableName,res?@"成功":@"失败",tableCreateSQLString);
    }
    //成功的话存储一下class
    if (res) {
        [self.classNameArray addObject:tableName];
    }
    return statement;
}
/**
 * 获取表的列
 */
- (NSArray *)dataBaseProertyByFMDatabase:(FMDatabase *)db AndTableName:(NSString *)tableName{
    NSMutableArray *columns = [NSMutableArray array];
    FMResultSet *resultSet = [db getTableSchema:tableName];
    while ([resultSet next]) {
        NSString *column = [resultSet stringForColumn:@"name"];
        [columns addObject:column];
    }
    return columns;
}
#pragma mark 单个___增删改
- (BOOL)updataModelByType:(MODEL_MANAGER_TYPE)type
                WithModel:(NSObject <CFFMDBModelProtocol>*)model{
    __block BOOL res = NO;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        CFFMDBModelToSQL *helping = [[CFFMDBModelToSQL alloc] initWithModel:model];
        res = [self updataModel:db AndRollback:rollback AndAction:type WithodelToSQL:helping];
    }];
    return res;
}
#pragma mark 批量___增删改
- (void)updateModelsByType:(MODEL_MANAGER_TYPE)type
                WithModels:(NSArray <NSObject <CFFMDBModelProtocol>*> *)models
            AndFinishBlock:(CFResultBlock)block{
    NSMutableArray *fairModelArray = [NSMutableArray array];
    __block BOOL res = NO;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (NSObject<CFFMDBModelProtocol> *model in models) {
            CFFMDBModelToSQL *helping = [[CFFMDBModelToSQL alloc] initWithModel:model];
            res = [self updataModel:db AndRollback:rollback AndAction:type WithodelToSQL:helping];
            if (!res) [fairModelArray addObject:model];
        }
    }];
    if (fairModelArray.count == 0){
        block(YES,nil);
    }else{
        NSLog(@"批量处理数据失败了%d个",(int)fairModelArray.count);
        block(NO,fairModelArray);
    }
}
#pragma mark 增删改处理方法
- (BOOL)updataModel:(FMDatabase *)db
        AndRollback:(BOOL *)rollback
          AndAction:(MODEL_MANAGER_TYPE)type
      WithodelToSQL:(CFFMDBModelToSQL*)helping{
    BOOL res = NO;
    if (type == MODEL_MANAGER_TYPE_REM) {
        NSDictionary *modelThisModel = helping.mineModelDictionary;
        CFFMDBSQLStatement *statement = [self createTableActionWithModelDictionary:modelThisModel AndDB:db AndRollback:rollback];
        res = [self removeAction:db WithSQLStatement:statement];
        if (!res) NSLog(@"删除失败一个数据%@",modelThisModel);
        return res;
    }
    for (NSDictionary *modelDictionary in helping.propertyDictionaryArray) {
        CFFMDBSQLStatement *statement = [self createTableActionWithModelDictionary:modelDictionary AndDB:db AndRollback:rollback];
        res = [self addAction:db WithSQLStatement:statement];
        if (!res) res = [self updateAction:db WithSQLStatement:statement];
        if (!res) NSLog(@"更新失败一个数据%@",modelDictionary);
    }
    return res;
}
#pragma mark 条件查找
- (NSArray *)searchModelsByModelClass:(Class)modelClass AndSearchPropertyDictionary:(NSDictionary *)infoDictionary{
    __block NSArray *models = nil;
    //无需 建表或更新列 直接查找 拼接
    // 1. 先查modelThisModel 然后解析modelThisModel
    // 2. 查属性model
    // 3. 查找结束拼接起来
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        models = [self searchAction:db WithModelClass:modelClass AndInfoDictionary:infoDictionary];
    }];
    return models;
}
/**
 addModel 增
 */
- (BOOL)addAction:(FMDatabase *)db
 WithSQLStatement:(CFFMDBSQLStatement *)statement{
    __block BOOL res = NO;
    [statement addSQLStringWithResult:^(NSString *sqlString, NSArray *valueArray) {
        res = [db executeUpdate:sqlString withArgumentsInArray:valueArray];
        //        NSLog(@"%@,%@",res?@"成功":@"失败",sqlString);
    }];
    return res;
}
/**
 addModel 改
 */
- (BOOL)updateAction:(FMDatabase *)db
    WithSQLStatement:(CFFMDBSQLStatement *)statement{
    __block BOOL res = NO;
    [statement updateSQLStringWithResult:^(NSString *sqlString, NSArray *valueArray) {
        res = [db executeUpdate:sqlString withArgumentsInArray:valueArray];
        if(!res)NSLog(@"更新失败一个数据%@,%@",sqlString,valueArray);
    }];
    return res;
}
/**
 addModel 删
 */
- (BOOL)removeAction:(FMDatabase *)db
    WithSQLStatement:(CFFMDBSQLStatement *)statement{
    __block BOOL res = NO;
    [statement remSQLStringWithResult:^(NSString *sqlString, NSArray *valueArray) {
        res = [db executeUpdate:sqlString withArgumentsInArray:valueArray];
        if(!res)NSLog(@"删除失败一个数据%@,%@",sqlString,valueArray);
    }];
    return res;
}
/**
 searchAction 查
 */
- (NSArray *)searchAction:(FMDatabase *)db WithModelClass:(Class)modelClass AndInfoDictionary:(NSDictionary *)infoDictionary{
    NSMutableArray *models = [NSMutableArray array];
    NSString *sqlString = [CFFMDBSQLStatement searchSQLStringByModelClass:modelClass WithInfoDictionary:infoDictionary];
    CFFMDBSQLToModel *helping = [[CFFMDBSQLToModel alloc] initWithModelClass:modelClass];
    FMResultSet *resultSet = [db executeQuery:sqlString];
    while ([resultSet next]) {
        NSObject <CFFMDBModelProtocol> *model = [[modelClass alloc] init];
        [helping enumPropertyWithEnumBlcok:^void(NSString *propertyNameString, SQL_DATA_TYPE type) {
            id value = [self valueByType:type AndResult:resultSet AndPropertyName:propertyNameString];
            [model setValue:value forKey:propertyNameString];
        }];
        [helping enumModelPropertyEnumBlock:^(NSString *propertyNameString, __unsafe_unretained Class modelClass, SQL_DATA_TYPE type) {
            // type 是propertyNameString对应的class对应的model的主键的type
            // 获取主键的value
            id value = [self valueByType:type AndResult:resultSet AndPropertyName:propertyNameString];
            // 查找model
            NSObject <CFFMDBModelProtocol> *children = [self modelByDb:db AndClass:modelClass AndValue:value];
            [model setValue:children forKey:propertyNameString];
        }];
        [helping enumModelArrayPropertyEnumBlock:^(NSString *propertyNameString, __unsafe_unretained Class modelClass, SQL_DATA_TYPE type) {
            // type 是propertyNameString对应的class对应的model的主键的type
            // 获取主键的value
            NSArray *jsonArray = [self valueByType:SQL_DATA_TYPE_TEXT AndResult:resultSet AndPropertyName:propertyNameString];
            NSMutableArray *modelsArray = [NSMutableArray array];
            for (id value in jsonArray) {
                // 查找model
                NSObject <CFFMDBModelProtocol> *children = [self modelByDb:db AndClass:modelClass AndValue:value];
                if (children) {
                    [modelsArray addObject:children];
                }
            }
            [model setValue:modelsArray forKey:propertyNameString];
        }];
        [models addObject:model];
        FMDBRelease(model);
    }
    return models;
}
// 获取model
- (NSObject <CFFMDBModelProtocol> *)modelByDb:(FMDatabase *)db AndClass:(Class)modelClass AndValue:value{
    if (!value) return nil;
    
    // value创建info
    NSDictionary *infoDictionary = [CFFMDBSQLToModel infoDictionaryByValue:value AndClass:modelClass];
    // 查找嵌套model
    NSArray *childrens = [self searchAction:db WithModelClass:modelClass AndInfoDictionary:infoDictionary];
    if (childrens.count != 0) {
        return childrens.firstObject;
    }
    return nil;
}

// 获取value
// 若为数组和字典转化则自动转化为数组和字典
- (id)valueByType:(SQL_DATA_TYPE)type AndResult:(FMResultSet *)resultSet AndPropertyName:(NSString *)propertyNameString{
    id value = nil;
    if([resultSet columnIsNull:propertyNameString])return value;
    
    if (type == SQL_DATA_TYPE_TEXT) {
        value = [resultSet stringForColumn:propertyNameString];
        id obj = [CFFMDBConfiguration jsonToObj:value];
        if (obj){
            //            NSLog(@"jsonString%@转化为->%@",value,obj);
            value = obj;
        }
    }else if (type == SQL_DATA_TYPE_BLOB){
        value = [resultSet dataForColumn:propertyNameString];
    }else{
        value = @([resultSet longLongIntForColumn:propertyNameString]);
    }
    return value;
}

#pragma mark get 方法
-(FMDatabaseQueue *)dbQueue{
    if (!_dbQueue) {
        _dbQueue = [[FMDatabaseQueue alloc] initWithPath:[CFFMDBSQLStatement CreatedSQLLibStringByName:self.name]];
    }
    return _dbQueue;
}
-(NSMutableArray *)classNameArray{
    if (!_classNameArray) {
        _classNameArray = [NSMutableArray array];
    }
    return _classNameArray;
}
@end
