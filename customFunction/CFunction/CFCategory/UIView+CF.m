//
//  UIView+CF.m
//  customFunction
//
//  Created by jing on 2019/1/10.
//  Copyright © 2019 jing. All rights reserved.
//

#import "UIView+CF.h"
#import <objc/runtime.h>

@implementation UIView (CF)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getInstanceMethod(self, @selector(init));
        Method swizzledMethod = class_getInstanceMethod(self, @selector(jc_init));
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}
- (instancetype)jc_init{
    UIView *obj = [self jc_init];
    [obj jc_backViewInit];
    return obj;
}

- (void)jc_backViewInit{
#ifdef DEBUG
    NSLog(@"%@-jc_backViewInit",NSStringFromClass([self class]));
#else
#endif
}
@end
