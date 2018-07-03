//
//  CFNotificationComponent.m
//  customFunction
//
//  Created by jing on 2018/7/3.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFNotificationComponent.h"
@interface CFNotificationComponent()
@property(nonatomic,strong) NSMutableDictionary *callbackDic;

@end
@implementation CFNotificationComponent
#pragma mark 公开
+ (void)sendNotificationWithNotiName:(NSString *)name AndValue:(id)value{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:value];
}

// 接收通知
- (void)addCallbackWithBlcok:(void(^)(id model))block AndName:(NSString *)name{
    self.callbackDic[name] = block;
    [self addNotification:name];
}
- (instancetype)init{
    self = [super init];
    if (self) {
        self.callbackDic = @{}.mutableCopy;
    }
    return self;
}

#pragma mark 私有
- (void)dealloc{
    [self removeNotification];
}

- (void)notificationAction:(NSNotification *)notification{
    void(^block)(id model) = self.callbackDic[notification.name];
    if (block) {
        id model = [notification object];
        block(model);
    }
}

#pragma mark noti
- (void)addNotification:(NSString *)name{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:name object:nil];
}
- (void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
