//
//  UIButton+BlocksKit.m
//  Wolverine
//
//  Created by jing on 2019/4/9.
//  Copyright © 2019 jing. All rights reserved.
//

#import "UIButton+BlocksKit.h"
#import <objc/runtime.h>
@implementation UIButton (BlocksKit)
//------- 添加属性 -------//
static void *bk_buttonEventsBlockKey = &bk_buttonEventsBlockKey;
/**
 给按钮绑定事件回调block
 
 @param block 回调的block
 @param controlEvents 回调block的事件
 */
- (void)bk_addEventHandler:(void (^)(UIButton *button))block forControlEvents:(UIControlEvents)controlEvents{
    objc_setAssociatedObject(self, &bk_buttonEventsBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(bk_blcokButtonClicked:) forControlEvents:controlEvents];
}

// 按钮点击
- (void)bk_blcokButtonClicked:(UIButton *)button {
    void (^block)(UIButton *button)  = (void (^)(UIButton *button))objc_getAssociatedObject(self, &bk_buttonEventsBlockKey);
    if (block) {
        block(button);
    }
}

@end
