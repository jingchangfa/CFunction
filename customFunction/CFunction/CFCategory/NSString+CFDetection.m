//
//  NSString+CFDetection.m
//  customFunction
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "NSString+CFDetection.h"

@implementation NSString (CFDetection)
+ (BOOL)isBlankString:(NSString *)string{
    if (!string) return YES;
    if ([string isKindOfClass:[NSNull class]]) return YES;
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) return YES;
    return NO;
}
// 手机号
+ (BOOL)isNumberString:(NSString *)numberString{
    NSString *regexStr = @"^1[3,8]\\d{9}|14[5,7,9]\\d{8}|15[^4]\\d{8}|17[^2,4,9]\\d{8}$";
    NSError *error;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
    if (error) return NO;
    NSInteger count = [regular numberOfMatchesInString:numberString options:NSMatchingReportCompletion range:NSMakeRange(0, numberString.length)];
    return (count > 0);
}
// 邮箱可用
+ (BOOL)isEmailString:(NSString *)emailString{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:emailString];
}
@end
