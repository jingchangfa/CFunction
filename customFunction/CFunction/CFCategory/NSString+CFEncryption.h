//
//  NSString+CFEncryption.h
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 加密 **/
@interface NSString (CFEncryption)
+ (NSString*) sha1: (NSString *)srcString;
+ (NSString*) sha512:(NSString*)srcString;
@end
