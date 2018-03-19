//
//  CFFMDBComponent.m
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFFMDBComponent.h"
#import "CFFMDBConfig.h"

@interface CFFMDBComponent ()
@property (nonatomic,strong)CFFMDBManager *modelManager;
@end
@implementation CFFMDBComponent
static CFFMDBComponent *manager = nil;
+ (CFFMDBComponent *)CFFMDBComponentClick{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CFFMDBComponent alloc] init];
    });
    return manager;
}
//get
-(CFFMDBManager *)modelManager{
    if (!_modelManager) {
        NSString *identifier = [CFFMDBConfig userDataBaseIdentifier];
        _modelManager = [[CFFMDBManager alloc] initWithDataBaseName:identifier];
    }
    return _modelManager;
}

#pragma mark 对外公开方法
// 更新单个
+ (BOOL)CFFMDBUpdataModelByType:(MODEL_MANAGER_TYPE)type
                      WithModel:(NSObject <CFFMDBModelProtocol>*)model{
    return [[self CFFMDBComponentClick].modelManager updataModelByType:type WithModel:model];
}
// 批量更新
+ (void)CFFMDBUpdateModelsByType:(MODEL_MANAGER_TYPE)type
                      WithModels:(NSArray <NSObject <CFFMDBModelProtocol>*> *)models
                  AndFinishBlock:(CFResultBlock)block{
    [[self CFFMDBComponentClick].modelManager updateModelsByType:type WithModels:models AndFinishBlock:block];

}
// 条件查找
+ (NSArray *)CFFMDBSearchModelsByModelClass:(Class)modelClass AndSearchPropertyDictionary:(NSDictionary *)propertyDictionary{
    return [[self CFFMDBComponentClick].modelManager searchModelsByModelClass:modelClass AndSearchPropertyDictionary:propertyDictionary];

}
// 退出登录(重新根据标示符前往数据库,比如更换用户的时候)
+ (void)CFFMDBLogOut{
    [self CFFMDBComponentClick].modelManager = nil;
}
@end
