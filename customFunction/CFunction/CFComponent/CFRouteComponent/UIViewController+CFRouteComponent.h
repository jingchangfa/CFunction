//
//  UIViewController+CFRouteComponent.h
//  New_Maya
//
//  Created by jing on 2018/3/21.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFRouteComponent.h"

@interface UIViewController (CFRouteComponent)
- (CFRouteComponent *)cf_registerPushByControllerName:(NSString *)controllerName;
- (UIViewController *)cf_registerController;

- (NSDictionary *)cf_paramValue;
- (NSObject<CFFMDBModelProtocol> *)cf_modelValue;
- (NSNumber *)cf_IDValue;
- (NSString *)cf_titleValue;
- (void(^)(NSDictionary *param))cf_blockValue;
@end
