//
//  CFFMDBModelToSQL.m
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFFMDBModelToSQL.h"
#import "CFFMDBRunTimeModelInterface.h"
#import "CFFMDBTypeChange.h"
#import "CFFMDBConfiguration.h"

@implementation CFFMDBModelToSQL
@synthesize propertyDictionaryArray = _propertyDictionaryArray;
@synthesize mineModelDictionary = _mineModelDictionary;
- (instancetype)initWithModel:(NSObject<CFFMDBModelProtocol> *)model{
    if (self = [super init]) {
        _model = model;
    }
    return self;
}
- (NSArray<NSDictionary *> *)propertyDictionaryArray{
    if (!_propertyDictionaryArray) {
        [self analysisModel];
    }
    return _propertyDictionaryArray;
}
- (NSDictionary *)mineModelDictionary{
    if (!_mineModelDictionary) {
        [self analysisModel];
    }
    return _mineModelDictionary;
}
- (void)analysisModel{
    _propertyDictionaryArray = [self modelAnalysisByModel:_model];
}
#pragma mark 此方法只负责处理一层，无需处理嵌套关系，将model转化为特定格式的Dictionry
/**
 一个model实际可能是若干个sql语句(model 嵌套的原因) 递归～
 * 先处理嵌套的model
 * 最后把基础数据拼接进去
 */
- (NSArray *)modelAnalysisByModel:(NSObject<CFFMDBModelProtocol> *)model{
    NSArray *modelRecursiveArray = [self modelRecursiveWithModel:model];
    
    NSMutableArray *propertyDictionaryArray = [NSMutableArray array];
    for (NSDictionary *oneModelRecursiveDictionary in modelRecursiveArray) {
        NSMutableArray *oneModelPropertyDictionaryArray = [NSMutableArray array];
        CFFMDBRunTimeModelInterface *modelInterface = oneModelRecursiveDictionary[PropertyClassInterface];
        NSObject<CFFMDBModelProtocol> *oneModel = oneModelRecursiveDictionary[PropertyValue];
        
        for (NSString *modelPropertyNameString in modelInterface.modelPropertyNameAndTypeDictionary.allKeys){
            NSString *propertyType = modelInterface.modelPropertyNameAndTypeDictionary[modelPropertyNameString];
            NSString *sqlType = [CFFMDBTypeChange sqlTypeStringByPropertyTypeString:propertyType];
            id value = [oneModel valueForKey:modelPropertyNameString];
            // 字典数组转化json串
            NSString *jsonString = [self modelArrayOrDictionaryPropertyTojson:value];
            if (jsonString) {
                value = jsonString;
            }
            //下面俩if 将model转化为model的主键
            if ([modelInterface.modelArrayPropertyNameArray containsObject:modelPropertyNameString]) {//内嵌modelArray
                NSInteger index = [modelInterface.modelArrayPropertyNameArray indexOfObject:modelPropertyNameString];
                NSDictionary *propertyDic = modelInterface.modelArrayPropertyArray[index];
                NSString *className = propertyDic[PropertyType];
                CFFMDBRunTimeModelInterface *propertyClassInterface = [CFFMDBRunTimeModelInterface ModelInterfaceCacheByModelClassName:className];
                
                NSMutableArray *modelMainKeyValue = [NSMutableArray array];
                NSArray *modelsArray = value;
                for (NSObject<CFFMDBModelProtocol> *arrayModel in modelsArray) {
                    id MainKey = [arrayModel valueForKey:propertyClassInterface.mainKeyPropertyName];
                    [modelMainKeyValue addObject:MainKey];
                }
                value = [CFFMDBConfiguration arrayToJSONString:modelMainKeyValue];
            }
            if ([modelInterface.modelPropertyNameArray containsObject:modelPropertyNameString]) {//内嵌model
                NSInteger index = [modelInterface.modelPropertyNameArray indexOfObject:modelPropertyNameString];
                NSDictionary *propertyDic = modelInterface.modelPropertyArray[index];
                NSString *className = propertyDic[PropertyType];
                CFFMDBRunTimeModelInterface *propertyClassInterface = [CFFMDBRunTimeModelInterface ModelInterfaceCacheByModelClassName:className];
                value = [value valueForKey:propertyClassInterface.mainKeyPropertyName];
            }
            if (!value) {
                value = [NSNull null];
            }
            [oneModelPropertyDictionaryArray addObject:@{PropertyName:modelPropertyNameString,
                                                         PropertyType:propertyType,
                                                         SQLType:sqlType,
                                                         PropertyValue:value}];
        }
        // 生成解析数据，并存储
        NSDictionary *oneModelDictionary = @{PropertyType:modelInterface.className,
                                             PropertyModelMainKey:modelInterface.mainKeyPropertyName,
                                             PropertyMainValue:[oneModel valueForKey:modelInterface.mainKeyPropertyName],
                                             PropertyValue:oneModelPropertyDictionaryArray};
        if (oneModelRecursiveDictionary[PropertyName] == PropertyModelThis) {
            _mineModelDictionary = oneModelDictionary;
        }
        [propertyDictionaryArray addObject:oneModelDictionary];
    }
    return  propertyDictionaryArray;
}

#pragma mark 下面三个方法的作用递归解析model,纵向关系变为横向关系
/**
 递归
 * modelRecursiveWithModel 要解析的主体model
 * modelArrayRecursiveWithArray 递归讲纵向关系变为横向关系
 */
- (NSArray *)modelRecursiveWithModel:(NSObject<CFFMDBModelProtocol> *)model{
    NSMutableArray *allModelsArray = [NSMutableArray array];
    CFFMDBRunTimeModelInterface *modelInterface = [CFFMDBRunTimeModelInterface ModelInterfaceCacheByModelClassName:NSStringFromClass(model.class)];
    NSArray *modelArray = @[@{
                                PropertyValue:model,
                                PropertyName:PropertyModelThis,
                                PropertyClassInterface:modelInterface
                                }];
    [self modelArrayRecursiveWithArray:modelArray AndSaveMutableArray:allModelsArray];
    return allModelsArray;
}
- (void)modelArrayRecursiveWithArray:(NSArray *)modelDictionaryArray AndSaveMutableArray:(NSMutableArray *)saveArray{
    if (modelDictionaryArray.count == 0) {
        return ;
    }
    //    static int tag = 0;
    //    NSLog(@"总计执行次数+%d",tag++);
    [saveArray addObjectsFromArray:modelDictionaryArray];
    for (NSDictionary *modelDictionary in modelDictionaryArray) {
        NSObject<CFFMDBModelProtocol> *model = modelDictionary[PropertyValue];
        modelDictionaryArray = [self modelVerticalDependenceToHorizontalDependence:model];
        [self modelArrayRecursiveWithArray:modelDictionaryArray AndSaveMutableArray:saveArray];
    }
}
// 一个model为单位找到其嵌套的子model
- (NSArray *)modelVerticalDependenceToHorizontalDependence:(NSObject<CFFMDBModelProtocol> *)model{
    NSMutableArray *modelHorizontalDependenceArray = [NSMutableArray array];
    CFFMDBRunTimeModelInterface *modelInterface = [CFFMDBRunTimeModelInterface ModelInterfaceCacheByModelClassName:NSStringFromClass(model.class)];
    //有嵌套model数组
    if (modelInterface.haveModelArrayProperty) {
        for (NSDictionary *dic in modelInterface.modelArrayPropertyArray) {
            NSString *propertyName = dic[PropertyName];
            NSString *propertyType = dic[PropertyType];
            NSArray *value = [model valueForKey:propertyName];
            if (!value) {
                continue;
            }
            CFFMDBRunTimeModelInterface *childrenInterface = [CFFMDBRunTimeModelInterface ModelInterfaceCacheByModelClassName:propertyType];
            
            for (NSObject<CFFMDBModelProtocol> *obj in value) {
                [modelHorizontalDependenceArray addObject:@{
                                                            PropertyValue:obj,
                                                            PropertyName:propertyName,
                                                            PropertyClassInterface:childrenInterface
                                                            }];
            }
        }
    }
    //嵌套model
    if (modelInterface.haveModelProperty) {
        for (NSDictionary *dic in modelInterface.modelPropertyArray) {
            NSString *propertyName = dic[PropertyName];
            NSString *propertyType = dic[PropertyType];
            NSObject<CFFMDBModelProtocol> *value = [model valueForKey:propertyName];
            if (!value) {
                continue;
            }
            CFFMDBRunTimeModelInterface *childrenInterface = [CFFMDBRunTimeModelInterface ModelInterfaceCacheByModelClassName:propertyType];
            [modelHorizontalDependenceArray addObject:@{
                                                        PropertyValue:value,
                                                        PropertyName:propertyName,
                                                        PropertyClassInterface:childrenInterface
                                                        }];
        }
    }
    return modelHorizontalDependenceArray;
}
#pragma mark 字典 数组转化为json
- (NSString *)modelArrayOrDictionaryPropertyTojson:(id)value{
    NSString *jsonString = nil;
    jsonString = [CFFMDBConfiguration toJson:value];
    if (jsonString) {
        NSLog(@"一个jsonObj%@转化为jsonstring->%@",value,jsonString);
    }
    return jsonString;
}
@end
