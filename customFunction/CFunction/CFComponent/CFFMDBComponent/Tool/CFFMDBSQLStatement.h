//
//  CFFMDBSQLStatement.h
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CFFMDBConfiguration.h"
#import "CFFMDBBlockHeader.h"
@interface CFFMDBSQLStatement : NSObject
//sql 关键字
#define PrimaryKey  @"primary key"
- (instancetype)initWithModelPropertyDictionary:(NSDictionary *)modelDictionary;
@property (nonatomic,readonly)NSDictionary *modelDictionary;
@property (nonatomic,readonly)NSString *classNameString;//table name
@property (nonatomic,readonly)NSString *mainKeyString;
@property (nonatomic,readonly)id mainKeyValue;
@property (nonatomic,readonly)NSArray *propertyArray;
#pragma mark 创建
/**
 * CreatedSQLLibStringByName 建库语句
 * createSQLTable 建表语句
 * isHaveTableSQLString 判断表存在的sql语句
 * tableNeedAddNewColumnByTableAllColunm 检测列是否增加
 */
+ (NSString *)CreatedSQLLibStringByName:(NSString *)nameString;
- (NSString *)createSQLTable;
- (void)isHaveTableSQLStringWith:(void(^)(NSString *sqlString,NSString *tableName))block;
- (void)tableNeedAddNewColumnByTableAllColunm:(NSArray *)allColumn
                                  AndSQLBlock:(CFAddPropertyBlcok)block;

#pragma mark 增删改查
/**
 * 增加操作
 * 此方法生成sql语句，以及与sql匹配的value数组
 */
- (void)addSQLStringWithResult:(CFSQLAddModelBlock)block;
/**
 * 修改（根据主键更新）
 * 此方法生成sql语句，以及与sql匹配的value数组
 */
- (void)updateSQLStringWithResult:(CFSQLAddModelBlock)block;
/**
 * 删除操作 （通过主键删除）
 * 此方法生成sql语句，以及与sql匹配的value数组
 */
- (void)remSQLStringWithResult:(CFSQLAddModelBlock)block;
/**
 * 查(通过条件查找)
 * infoDictionary = nil 查找表内全部数据
 * 更多的查询，自己扩展吧～
 */
+ (NSString *)searchSQLStringByModelClass:(Class)modelClass WithInfoDictionary:(NSDictionary *)infoDictionary;
@end
