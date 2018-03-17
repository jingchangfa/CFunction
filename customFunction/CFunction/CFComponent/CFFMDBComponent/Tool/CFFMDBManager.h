//
//  CFFMDBManager.h
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CFFMDBBlockHeader.h"
#import "CFFMDBModelProtocol.h"

@interface CFFMDBManager : NSObject
#pragma mark 创建根据唯一标识符,设计上一个用户一个数据库
-(instancetype)initWithDataBaseName:(NSString *)name;

#pragma mark 单个___增删改
- (BOOL)updataModelByType:(MODEL_MANAGER_TYPE)type
                WithModel:(NSObject <CFFMDBModelProtocol>*)model;

#pragma mark 批量___增删改
- (void)updateModelsByType:(MODEL_MANAGER_TYPE)type
                WithModels:(NSArray <NSObject <CFFMDBModelProtocol>*> *)models
            AndFinishBlock:(CFResultBlock)block;

#pragma mark 条件查找
/**
 查找
 * 1. nil 查找所有的
 * 2. @{@"主键" : @"主键值"}
 * 3. 复杂查询没弄～
 */
- (NSArray *)searchModelsByModelClass:(Class)modelClass AndSearchPropertyDictionary:(NSDictionary *)infoDictionary;
@end
