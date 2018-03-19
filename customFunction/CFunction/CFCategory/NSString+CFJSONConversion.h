//
//  NSString+CFJSONConversion.h
//  customFunction
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CFJSONConversion)
+ (NSString *)dictionaryToJSONString:(NSDictionary *)dictionary;
+ (NSString *)arrayToJSONString:(NSArray *)array;
- (NSDictionary *)jsonStringToDictionary;
- (NSArray *)jsonStringToArray;
@end
