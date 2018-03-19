//
//  CFHttpClickBase+CFClickBaseErrorConfig.h
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFHttpClickBase.h"

@interface CFHttpClickBase (CFClickBaseErrorConfig)
// 网络错误发生的时候，统一处理的步骤
+ (void)NetworkErrorConfigByErrorCode:(NSInteger)code AndMes:(NSString *)msg;

// 数据错误的时候，统一处理的步骤
+ (void)ServerErrorConfigByErrorCode:(NSInteger)code AndMes:(NSString *)msg;
@end
