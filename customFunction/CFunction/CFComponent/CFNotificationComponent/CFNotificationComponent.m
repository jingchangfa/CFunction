//
//  CFNotificationComponent.m
//  customFunction
//
//  Created by jing on 2018/7/3.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFNotificationComponent.h"
@interface CFNotificationComponent()
@property(nonatomic,strong) NSString *name;
@property(nonatomic,copy) void(^block)(id model);
@end
@implementation CFNotificationComponent
#pragma mark 公开
+ (void)sendNotificationWithNotiName:(NSString *)name AndValue:(id)value{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:value];
}

- (instancetype)initWithNotiName:(NSString *)name{
    self = [super init];
    if (self) {
        self.name = name;
        [self addNotification];
    }
    return self;
}
- (void)callbackWithBlcok:(void(^)(id model))block{
    self.block = block;
}

#pragma mark 私有
- (void)dealloc{
    [self removeNotification];
}

- (void)notificationAction:(NSNotification *)notification{
    if (self.block) {
        id model = [notification object];
        self.block(model);
    }
}

#pragma mark noti
- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:self.name object:nil];
}
- (void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:self.name object:nil];
}
@end
