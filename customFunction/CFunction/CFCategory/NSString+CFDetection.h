//
//  NSString+CFDetection.h
//  customFunction
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CFDetection)
// 字符串为空
+ (BOOL)isBlankString:(NSString *)string;
// 手机号可用
+ (BOOL)isNumberString:(NSString *)numberString;
// 邮箱可用
+ (BOOL)isEmailString:(NSString *)emailString;
@end
