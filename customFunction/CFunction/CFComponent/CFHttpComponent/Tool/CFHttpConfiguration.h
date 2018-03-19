//
//  CFHttpConfiguration.h
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFHttpConfiguration : NSObject
- (instancetype)init NS_UNAVAILABLE;
+ (CFHttpConfiguration *)defaultConfiguration;
- (NSString *)complateURLWithAPIString:(NSString *)apiString;
@end
