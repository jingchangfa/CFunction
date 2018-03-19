//
//  NSNumber+CFNumber.h
//  customFunction
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (CFNumber)
// 时间转化为字符串
- (NSString *)toShowTime;
- (NSString *)toShowTimeByDateComponents:(NSString *)dateComponents;
@end
