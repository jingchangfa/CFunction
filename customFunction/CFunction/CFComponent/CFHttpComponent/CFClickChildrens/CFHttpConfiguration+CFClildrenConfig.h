//
//  CFHttpConfiguration+CFClildrenConfig.h
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFHttpConfiguration.h"

@interface CFHttpConfiguration (CFClildrenConfig)
#pragma mark  配置
+ (NSString *)ConfigHost;// host
- (NSDictionary *)publicWordBreaks;// 返回共有字段
+ (BOOL)isRightResultByResult:(id)resultObject;
+ (NSInteger)resultErrorCodeByResult:(id)resultObject;
+ (NSString *)resultErrorMsgByResult:(id)resultObject;


#pragma mark API列表 (自己添加)
- (NSString *)login;
- (NSString *)registeres;
- (NSString *)list;
- (NSString *)create;
@end
