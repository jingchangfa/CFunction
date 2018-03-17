//
//  CFFMDBSQLToModel.m
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFFMDBSQLToModel.h"
#import "CFFMDBRunTimeModelInterface.h"
#import "CFFMDBTypeChange.h"

@implementation CFFMDBSQLToModel
- (instancetype)initWithModelClass:(Class)modelClass{
    if (self = [super init]) {
        _modelClass = modelClass;
    }
    return self;
}
+ (NSDictionary *)infoDictionaryByValue:(id)value AndClass:(Class)modelClass{
    CFFMDBRunTimeModelInterface *modelInterface = [CFFMDBRunTimeModelInterface ModelInterfaceCacheByModelClassName:NSStringFromClass(modelClass)];
    return @{modelInterface.mainKeyPropertyName:value};
}
- (void)enumPropertyWithEnumBlcok:(CFGetModelValueBlock)block{
    if (!block) return;
    
    CFFMDBRunTimeModelInterface *modelInterface = [CFFMDBRunTimeModelInterface ModelInterfaceCacheByModelClassName:NSStringFromClass(self.modelClass)];
    for (NSString *modelPropertyNameString in modelInterface.modelPropertyNameAndTypeDictionary.allKeys){
        NSString *propertyType = modelInterface.modelPropertyNameAndTypeDictionary[modelPropertyNameString];
        NSString *sqlType = [CFFMDBTypeChange sqlTypeStringByPropertyTypeString:propertyType];
        SQL_DATA_TYPE type = [self SQLDataTypeEnumBysqlTypeString:sqlType];
        block(modelPropertyNameString,type);
    }
}
- (SQL_DATA_TYPE)SQLDataTypeEnumBysqlTypeString:(NSString *)sqlTypeString{
    NSArray *sqlTypeArray = @[SQLTEXT,SQLINTEGER,SQLREAL,SQLBLOB,SQLNULL];
    return [sqlTypeArray indexOfObject:sqlTypeString];
}
- (void)enumModelArrayPropertyEnumBlock:(CFGetPropertyModelBlock)block{
    if (!block) return;
    CFFMDBRunTimeModelInterface *modelInterface = [CFFMDBRunTimeModelInterface ModelInterfaceCacheByModelClassName:NSStringFromClass(self.modelClass)];
    if (modelInterface.haveModelArrayProperty) {
        for (NSDictionary *propertyDictionary in modelInterface.modelArrayPropertyArray) {
            NSString *propertyName = propertyDictionary[PropertyName];
            NSString *classNameString = propertyDictionary[PropertyType];
            CFFMDBRunTimeModelInterface *childrenInterface = [CFFMDBRunTimeModelInterface ModelInterfaceCacheByModelClassName:classNameString];
            NSString *sqlType = [CFFMDBTypeChange sqlTypeStringByPropertyTypeString:childrenInterface.mainKeyPropertyType];
            SQL_DATA_TYPE type = [self SQLDataTypeEnumBysqlTypeString:sqlType];
            block(propertyName,NSClassFromString(classNameString),type);
        }
    }
}
- (void)enumModelPropertyEnumBlock:(CFGetPropertyModelBlock)block{
    if (!block) return;
    CFFMDBRunTimeModelInterface *modelInterface = [CFFMDBRunTimeModelInterface ModelInterfaceCacheByModelClassName:NSStringFromClass(self.modelClass)];
    if (modelInterface.haveModelProperty) {
        for (NSDictionary *propertyDictionary in modelInterface.modelPropertyArray) {
            NSString *propertyName = propertyDictionary[PropertyName];
            NSString *classNameString = propertyDictionary[PropertyType];
            CFFMDBRunTimeModelInterface *childrenInterface = [CFFMDBRunTimeModelInterface ModelInterfaceCacheByModelClassName:classNameString];
            NSString *sqlType = [CFFMDBTypeChange sqlTypeStringByPropertyTypeString:childrenInterface.mainKeyPropertyType];
            SQL_DATA_TYPE type = [self SQLDataTypeEnumBysqlTypeString:sqlType];
            block(propertyName,NSClassFromString(classNameString),type);
        }
    }
}
@end
