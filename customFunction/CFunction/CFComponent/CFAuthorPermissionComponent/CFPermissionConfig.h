//
//  CFPermissionConfig.h
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
# pragma mark 配置文件

@interface CFPermissionConfig : NSObject
+ (NSString *)cameraTitle;
+ (NSString *)micTitle;
+ (NSString *)photoTitle;
+ (NSString *)adressTitle;
+ (NSString *)locationTitle;


+ (void)alertShowWithTitle:(NSString *)title BySetingBlock:(void(^)(void))block;

@end
