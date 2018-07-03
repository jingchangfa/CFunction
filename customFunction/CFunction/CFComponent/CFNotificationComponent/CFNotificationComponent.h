//
//  CFNotificationComponent.h
//  customFunction
//
//  Created by jing on 2018/7/3.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFNotificationComponent<__covariant ObjectType> : NSObject
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

// 发送通知
+ (void)sendNotificationWithNotiName:(NSString *)name AndValue:(ObjectType)value;
// 接收通知
- (instancetype)initWithNotiName:(NSString *)name;
- (void)callbackWithBlcok:(void(^)(ObjectType model))block;
@end
