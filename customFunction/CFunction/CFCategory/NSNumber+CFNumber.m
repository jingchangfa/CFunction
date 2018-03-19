//
//  NSNumber+CFNumber.m
//  customFunction
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "NSNumber+CFNumber.h"

@implementation NSNumber (CFNumber)
- (NSString *)toShowTime{
    return [self toShowTimeByDateComponents:@"yyyy.MM.dd  HH:mm"];
}

- (NSString *)toShowTimeByDateComponents:(NSString *)dateComponents{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self longValue]];
    NSDateFormatter *dateformat = [NSNumber createdDateFormatterByDateComponents:dateComponents];
    return [dateformat stringFromDate:date];
}

+ (NSDateFormatter *)createdDateFormatterByDateComponents:(NSString *)dateComponents{
    NSString *dateFormatString = [NSDateFormatter dateFormatFromTemplate:dateComponents options:0 locale:[NSLocale currentLocale]];
    NSDateFormatter *dateformat = [[NSDateFormatter alloc]init];
    [dateformat setDateStyle:NSDateFormatterNoStyle];
    [dateformat setTimeStyle:NSDateFormatterNoStyle];
    [dateformat setDateFormat:dateComponents];
    return dateformat;
}
@end
