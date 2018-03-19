//
//  NSString+CFJSONConversion.m
//  customFunction
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "NSString+CFJSONConversion.h"

@implementation NSString (CFJSONConversion)
+ (NSString *)dictionaryToJSONString:(NSDictionary *)dictionary{
    return [self toJson:dictionary];
}
+ (NSString *)arrayToJSONString:(NSArray *)array{
    return [self toJson:array];
}
+ (NSString *)toJson:(id)obj{
    NSError *err = nil;
    NSData *stringData =
    [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&err];
    if (err) {
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    return jsonString;
}
- (NSDictionary *)jsonStringToDictionary{
    return [NSString jsonToObj:self];
}
- (NSArray *)jsonStringToArray{
    return [NSString jsonToObj:self];
}
+ (id)jsonToObj:(NSString *)jsonString{
    NSError *err;
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    id obj;
    if (jsonData) {
        obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    }
    if (err) {
        return nil;
    }
    return obj;
}
@end
