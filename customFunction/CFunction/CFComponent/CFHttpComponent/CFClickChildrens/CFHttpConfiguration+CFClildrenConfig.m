//
//  CFHttpConfiguration+CFClildrenConfig.m
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFHttpConfiguration+CFClildrenConfig.h"

@implementation CFHttpConfiguration (CFClildrenConfig)
#pragma mark 配置
+ (NSString *)ConfigHost{
    return @"http://10.99.1.102:3000";
}
- (NSDictionary *)publicWordBreaks{
    UserAccount *current = [UserAccount loadActiveUserAccount];
    NSDictionary *dic = @{@"token":current.userToken};
//    NSAssert(!dic, @"必须配置此字段，如果含有存储到本地的验证消息的话");
    return dic;
}
+ (BOOL)isRightResultByResult:(id)resultObject{
    return [resultObject[@"success"] boolValue];
}
+ (NSInteger)resultErrorCodeByResult:(id)resultObject{
    return [resultObject[@"errcode"] integerValue];
}
+ (NSString *)resultErrorMsgByResult:(id)resultObject{
    return resultObject[@"msg"];
}

#pragma mark API配置
- (NSString *)login{
    NSString *str = @"api/auth/login";
    return [self complateURLWithAPIString:str];
}
- (NSString *)registeres{
    NSString *str = @"api/auth/register";
    return [self complateURLWithAPIString:str];
}
- (NSString *)list{
    NSString *str = @"api/article/list";
    return [self complateURLWithAPIString:str];
}
- (NSString *)create{
    NSString *str = @"api/article/create";
    return [self complateURLWithAPIString:str];
}

@end

