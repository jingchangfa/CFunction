//
//  CFFMDBRunTimeModelInterface.m
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFFMDBRunTimeModelInterface.h"
#import <objc/runtime.h>
#import "CFFMDBModelProtocol.h"
#import "CFDefindHeader.h"


@implementation CFFMDBRunTimeModelInterface
+ (CFFMDBRunTimeModelInterface *)ModelInterfaceCacheByModelClassName:(NSString *)className{
    static NSMutableDictionary *ClassCacheDictionary = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ClassCacheDictionary = [NSMutableDictionary dictionary];
    });
    CFFMDBRunTimeModelInterface *model = ClassCacheDictionary[className];
    if (model) {
        return model;
    }
    model = [[CFFMDBRunTimeModelInterface alloc] initWithModelClassName:className];
    ClassCacheDictionary[className] = model;
    return model;
}

- (instancetype)initWithModelClassName:(NSString *)className{
    if (self = [super init]) {
        _className = className;
        _modelClass = NSClassFromString(className);
    }
    return self;
}

- (NSString *)mainKeyPropertyName{
    if ([_modelClass respondsToSelector:@selector(mainKey)]) {//相应类方法
        return [_modelClass mainKey];
    }
    if ([_modelClass instancesRespondToSelector:@selector(mainKey)]) {
        return [[[_modelClass alloc] init] mainKey];
    }
    return @"ID";
}

- (NSString *)mainKeyPropertyType{
    return self.modelPropertyNameAndTypeDictionary[self.mainKeyPropertyName];
}
- (BOOL)haveModelProperty{
    return self.modelPropertyArray.count != 0;
}

- (BOOL)haveModelArrayProperty{
    return self.modelArrayPropertyArray.count != 0;
}
- (NSArray *)modelPropertyNameArray{
    if (!_modelPropertyNameArray) {
        [self modelPropertySet];
    }
    return _modelPropertyNameArray;
}
- (NSArray<NSDictionary<NSString *,NSString *> *> *)modelPropertyArray{
    if (!_modelPropertyArray) {
        [self modelPropertySet];
    }
    return _modelPropertyArray;
}
- (void)modelPropertySet{
    NSMutableArray *modelPropertyNameArray = [NSMutableArray array];
    NSMutableArray *modelPropertyArray = [NSMutableArray array];
    for (NSString *propertyNameString in self.modelPropertyNameAndTypeDictionary.allKeys) {
        NSString *selectorString = [NSString stringWithFormat:@"%@CFModel",propertyNameString];
        SEL selector =  NSSelectorFromString(selectorString);
        if ([_modelClass respondsToSelector:selector]) {
            Class class = [self propertyClassBy:selector];
            NSString *className = NSStringFromClass(class);
            [modelPropertyNameArray addObject:propertyNameString];
            [modelPropertyArray addObject:@{PropertyName:propertyNameString,
                                            PropertyType:className}];
        }
    }
    _modelPropertyNameArray = modelPropertyNameArray.copy;
    _modelPropertyArray = modelPropertyArray.copy;
}
- (NSArray *)modelArrayPropertyNameArray{
    if (!_modelArrayPropertyNameArray) {
        [self modelArrayPropertyArraySet];
    }
    return _modelArrayPropertyNameArray;
}
- (NSArray<NSDictionary<NSString *,NSString *> *> *)modelArrayPropertyArray{
    if (!_modelArrayPropertyArray) {
        [self modelArrayPropertyArraySet];
    }
    return _modelArrayPropertyArray;
}
- (void)modelArrayPropertyArraySet{
    NSMutableArray *modelArrayPropertyNameArray = [NSMutableArray array];
    NSMutableArray *modelArrayPropertyArray = [NSMutableArray array];
    for (NSString *propertyNameString in self.modelPropertyNameAndTypeDictionary.allKeys) {
        NSString *selectorString = [NSString stringWithFormat:@"%@CFModelArray",propertyNameString];
        SEL selector =  NSSelectorFromString(selectorString);
        if ([_modelClass respondsToSelector:selector]) {
            Class class = [self propertyClassBy:selector];
            NSString *className = NSStringFromClass(class);
            [modelArrayPropertyNameArray addObject:propertyNameString];
            [modelArrayPropertyArray addObject:@{PropertyName:propertyNameString,
                                                 PropertyType:className}];
        }
    }
    _modelArrayPropertyNameArray = modelArrayPropertyNameArray.copy;
    _modelArrayPropertyArray = modelArrayPropertyArray.copy;
}
- (NSDictionary *)modelPropertyNameAndTypeDictionary{
    if (!_modelPropertyNameAndTypeDictionary) {
        _modelPropertyNameAndTypeDictionary = [self superPropertyAndSelfPropertyByClass:_modelClass];
    }
    return _modelPropertyNameAndTypeDictionary;
}
#pragma mark 递归获取 至父类的属性
- (NSDictionary *)superPropertyAndSelfPropertyByClass:(Class)class{
    NSMutableDictionary *propertysMuDic = [NSMutableDictionary dictionary];
    Class baseClass = [NSObject class];
    if ([class respondsToSelector:@selector(modelBaseClass)]) {//相应类方法
        baseClass = [class modelBaseClass];
    }
    NSArray *pubTransArray = @[@"debugDescription",@"description",@"hash",@"superclass"];
    do {
        NSMutableArray *transientsArray = pubTransArray.mutableCopy;
        if ([class respondsToSelector:@selector(transients)]) {//相应类方法
            NSArray *transientClassArray = [class transients];
            if (transientClassArray) [transientsArray addObjectsFromArray:transientClassArray];
        }
        NSDictionary *oneClassDic = [self getPropertyNameAndTypeByClass:class AndTransients:transientsArray];
        [propertysMuDic setValuesForKeysWithDictionary:oneClassDic];//添加
        class = class_getSuperclass(class);
    } while (class != baseClass);
    return propertysMuDic;
}
#pragma mark 调用imp
- (Class)propertyClassBy:(SEL)selector{
    // 下面这段代码抄自Mantle 方法实现的调用～
    IMP imp = [_modelClass methodForSelector:selector];
    Class (*function)(id, SEL) = (__typeof__(function))imp;
    Class class = function(_modelClass, selector);
    //    objc_msgSend(_modelClass,selector,nil);
    return class;
}
#pragma mark 获取属性名 及其 对应的类型
- (NSDictionary *)getPropertyNameAndTypeByClass:(Class)class AndTransients:(NSArray *)transientsArray{
    NSMutableDictionary *modelPropertyNameAndTypeDictionary = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *propertys = class_copyPropertyList(class, &count);
    for (int i = 0; i<count; i++) {
        objc_property_t pro = propertys[i];
        //获取属性名
        NSString *proprttyNameString = [NSString stringWithCString:property_getName(pro) encoding:NSUTF8StringEncoding];
        if (transientsArray&&[transientsArray containsObject:proprttyNameString]) {
            continue;
        }
        //获取属性类型
        NSString *propertyType = [NSString stringWithCString: property_getAttributes(pro) encoding:NSUTF8StringEncoding];
        modelPropertyNameAndTypeDictionary[proprttyNameString] = propertyType;
    }
    free(propertys);
    return modelPropertyNameAndTypeDictionary.copy;
}
@end
