//
//  UIViewController+CFRouteComponent.m
//  New_Maya
//
//  Created by jing on 2018/3/21.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "UIViewController+CFRouteComponent.h"
#import "CFDefindHeader.h"
#import <objc/runtime.h>

@interface UIViewController ()
@property (nonatomic,strong) UIViewController *createController;
@property (nonatomic,strong) CFRouteComponent *route;
@end
@implementation UIViewController (CFRouteComponent)


- (CFRouteComponent *)cf_registerPushByControllerName:(NSString *)controllerName{
    Class controllerClass = NSClassFromString(controllerName);
    UIViewController *controller = [[controllerClass alloc] init];
    if (![controller isKindOfClass:[UIViewController class]]) {
        NSString *strErr = [NSString stringWithFormat:@"--%@--不是一个controller名",controllerName];
        CF_Exception(controllerName, strErr);
    }
    CFRouteComponent *route = [[CFRouteComponent alloc] init];
    controller.route = route;
    self.createController = controller;
    return route;
}
- (UIViewController *)cf_registerController{
    return self.createController;
}

- (NSDictionary *)cf_paramValue{
    return [self.route valueForKey:@"param"];
}
- (NSObject<CFFMDBModelProtocol> *)cf_modelValue{
    return [self.route valueForKey:@"model"];
}
- (NSNumber *)cf_IDValue{
    return [self.route valueForKey:@"ID"];
}
- (NSString *)cf_titleValue{
    return [self.route valueForKey:@"title"];
}
- (void(^)(NSDictionary *param))cf_blockValue{
    return [self.route valueForKey:@"block"];
}

#pragma mark 添加属性
static NSString *routeKey = @"routeKey";
- (void)setRoute:(CFRouteComponent *)route{
    objc_setAssociatedObject(self, &routeKey, route, OBJC_ASSOCIATION_RETAIN);
}
- (CFRouteComponent *)route{
    return objc_getAssociatedObject(self, &routeKey);
}

static NSString *createControllerKey = @"createControllerKey";
- (void)setCreateController:(UIViewController *)createController{
    objc_setAssociatedObject(self, &createControllerKey, createController, OBJC_ASSOCIATION_RETAIN);
}
- (UIViewController *)createController{
    return objc_getAssociatedObject(self, &createControllerKey);
}
@end
