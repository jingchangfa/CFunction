//
//  CFHttpLogInClick.h
//  customFunction
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFHttpClickBase.h"
#pragma mark 例子
@interface CFHttpLogInClick : CFHttpClickBase
/**
 用户登录
 
 @param numberString 手机号
 @param passwordString 密码
 @param success 成功
 @param failure 失败
 */
- (void)loginWithMobileString:(NSString *)numberString
                  AndPassWord:(NSString *)passwordString
                  withSuccess:(void(^)(NSNumber *userID,NSString *token,NSDictionary *herd))success
                   andFailure:(defaultFailureBlock)failure;
@end
