//
//  CFHttpConfiguration.m
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFHttpConfiguration.h"
#import "CFHttpConfiguration+CFClildrenConfig.h" 
@interface CFHttpConfiguration ()
//eg: 共有字断
@property (nonatomic,strong) NSString *hostString;
@end
@implementation CFHttpConfiguration
+ (CFHttpConfiguration *)defaultConfiguration{
    static CFHttpConfiguration *defaultConfiguration = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultConfiguration = [[CFHttpConfiguration alloc] initWithHostString:[self ConfigHost]];
    });
    return defaultConfiguration;
}
- (CFHttpConfiguration *)initWithHostString:(NSString *)hostString{
    self = [super init];
    if (self)
    {
        _hostString = hostString;
    }
    return self;
}

#pragma mark 辅助方法
- (NSString *)complateURLWithAPIString:(NSString *)apiString{
    return [NSString stringWithFormat:@"%@/%@",self.hostString,apiString];
}
@end
