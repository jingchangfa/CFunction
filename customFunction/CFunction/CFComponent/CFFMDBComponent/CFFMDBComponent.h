//
//  CFFMDBComponent.h
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CFFMDBManager.h"

@interface CFFMDBComponent : NSObject
#pragma mark 数据操作
// 更新单个
+ (BOOL)CFFMDBUpdataModelByType:(MODEL_MANAGER_TYPE)type
                      WithModel:(NSObject <CFFMDBModelProtocol>*)model;

// 批量更新
+ (void)CFFMDBUpdateModelsByType:(MODEL_MANAGER_TYPE)type
                      WithModels:(NSArray <NSObject <CFFMDBModelProtocol>*> *)models
                  AndFinishBlock:(CFResultBlock)block;

// 条件查找
+ (NSArray *)CFFMDBSearchModelsByModelClass:(Class)modelClass AndSearchPropertyDictionary:(NSDictionary *)propertyDictionary;

// 退出登录(重新根据标示符前往数据库,比如更换用户的时候)
+ (void)CFFMDBLogOut;
@end
