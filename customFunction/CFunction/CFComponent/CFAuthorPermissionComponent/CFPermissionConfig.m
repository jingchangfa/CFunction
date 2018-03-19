//
//  CFPermissionConfig.m
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFPermissionConfig.h"

@implementation CFPermissionConfig
+ (NSString *)cameraTitle{
    return @"允许访问相机";
}
+ (NSString *)micTitle{
    return @"允许访问麦克风";
}
+ (NSString *)photoTitle{
    return @"允许访问相册";
}
+ (NSString *)adressTitle{
    return @"允许访问通讯录";
}
+ (NSString *)locationTitle{
    return @"允许访问位置";
}
+ (NSString *)setingTitle{
    return @"去设置";
}
+ (NSString *)cacleTitle{
    return @"取消";
}

+ (void)alertShowWithTitle:(NSString *)title BySetingBlock:(void(^)(void))block{
    // 出现提示的alert
}
@end
