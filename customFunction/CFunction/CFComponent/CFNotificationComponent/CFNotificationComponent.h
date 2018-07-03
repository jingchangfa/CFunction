//
//  CFNotificationComponent.h
//  customFunction
//
//  Created by jing on 2018/7/3.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFNotificationComponent<__covariant ObjectType> : NSObject
+ (instancetype)new NS_UNAVAILABLE;
// 发送通知
+ (void)sendNotificationWithNotiName:(NSString *)name AndValue:(id)value;
// 接收通知
- (void)addCallbackWithBlcok:(void(^)(id model))block AndName:(NSString *)name;
@end
