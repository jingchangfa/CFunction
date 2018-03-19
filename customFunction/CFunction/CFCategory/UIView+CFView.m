//
//  UIView+CFView.m
//  New_Maya
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "UIView+CFView.h"
#import <objc/runtime.h>

@implementation UIView (CFView)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self coderInit];
        [self frameInit];
        [self otherInit];
    });
}
+ (void)coderInit{
    SEL originalSelector = @selector(initWithCoder:);
    SEL swizzledSelector = @selector(CFInitWithCoder:);
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
- (instancetype)CFInitWithCoder:(NSCoder *)aDecoder{
    UIView *view = [self CFInitWithCoder:aDecoder];
    [view backViewInitUseing];
    return view;
}
+ (void)frameInit{
    SEL originalSelector = @selector(initWithFrame:);
    SEL swizzledSelector = @selector(CFInitWithFrame:);
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
- (instancetype)CFInitWithFrame:(CGRect)frame{
    UIView *view = [self CFInitWithFrame:frame];
    [view backViewInitUseing];
    return view;
}
+ (void)otherInit{
    SEL originalSelector = @selector(init);
    SEL swizzledSelector = @selector(CFInit);
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
- (instancetype)CFInit{
    UIView *view = [self CFInit];
    [view backViewInitUseing];
    return view;
}



- (void)backViewInitUseing{
    SEL selectorColtro =  NSSelectorFromString(@"backViewInit");
    if ([self respondsToSelector:selectorColtro]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        IMP imp = [self methodForSelector:selectorColtro];
        void (*function)(id, SEL) = (__typeof__(function))imp;
        function(self, selectorColtro);
    }
}
@end
