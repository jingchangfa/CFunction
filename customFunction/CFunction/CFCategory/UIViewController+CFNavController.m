//
//  UIViewController+CFNavController.m
//  New_Maya
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "UIViewController+CFNavController.h"
#import "CFNavButtonBuilder.h"
#import "CFDefindHeader.h"
#import <objc/runtime.h>


@implementation UIViewController (CFNavController)
- (void)setBackgroundColor:(UIColor *)backgroundColor{
    self.view.backgroundColor = backgroundColor;
}
- (void)setNavBackgroundColor:(UIColor *)backgroundColor{
    self.navigationController.navigationBar.barTintColor = backgroundColor;
}
- (void)setNavTitleColor:(UIColor *)titleColor{
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor}];
}
- (void)setNavTranslucent:(BOOL)translucent{
    self.navigationController.navigationBar.translucent = translucent;
}
- (void)setNavShadowLine:(BOOL)shadow{
    if (!shadow) {
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    }else{
        self.navigationController.navigationBar.backgroundColor = nil;
        self.navigationController.navigationBar.shadowImage = nil;
    }
}
- (void)setNavTitle:(NSString *)title{
    self.navigationItem.title = title;
}
- (AppDelegate *)appDelegate{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

// 导航条按钮
- (void)onBackButtonClicked{
    if (self.navigationController && self.navigationController.viewControllers.count > 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (UIBarButtonItem *)addNavBackButtonByImageName:(NSString *)imageName AndClickBlock:(void(^)(UIButton *button))block{
    @WeakObj(self);
    UIBarButtonItem *buttonItem = [CFNavButtonBuilder ImageButtonByImageName:imageName AndBlock:^(UIButton *button) {
        if (!block) {
            [selfWeak onBackButtonClicked];
            return ;
        }
        block(button);
    }];
    self.navigationItem.backBarButtonItem = buttonItem;
    return buttonItem;
}
- (UIBarButtonItem *)addNavBackButtonByTitle:(NSString *)title AndTitleColor:(UIColor *)color AndClickBlock:(void(^)(UIButton *button))block{
    @WeakObj(self);
    UIBarButtonItem *buttonItem = [CFNavButtonBuilder TitleButtonByTitle:title AndTitleColor:color AndBlock:^(UIButton *button) {
        if (!block) {
            [selfWeak onBackButtonClicked];
            return ;
        }
        block(button);
    }];
    self.navigationItem.backBarButtonItem = buttonItem;
    return buttonItem;
}

- (UIBarButtonItem *)addNavLeftButtonByImageName:(NSString *)imageName AndClickBlock:(void(^)(UIButton *button))block{
    UIBarButtonItem *buttonItem = [CFNavButtonBuilder ImageButtonByImageName:imageName AndBlock:block];
    self.navigationItem.leftBarButtonItem = buttonItem;
    return buttonItem;
    
}
- (UIBarButtonItem *)addNavLeftButtonByTitle:(NSString *)title AndTitleColor:(UIColor *)color AndClickBlock:(void(^)(UIButton *button))block{
    UIBarButtonItem *buttonItem = [CFNavButtonBuilder TitleButtonByTitle:title AndTitleColor:color AndBlock:block];
    self.navigationItem.leftBarButtonItem = buttonItem;
    return buttonItem;
}

- (UIBarButtonItem *)addNavRightButtonByImageName:(NSString *)imageName AndClickBlock:(void(^)(UIButton *button))block{
    UIBarButtonItem *buttonItem = [CFNavButtonBuilder ImageButtonByImageName:imageName AndBlock:block];
    self.navigationItem.rightBarButtonItem = buttonItem;
    return buttonItem;
}
- (UIBarButtonItem *)addNavRightButtonByTitle:(NSString *)title AndTitleColor:(UIColor *)color AndClickBlock:(void(^)(UIButton *button))block{
    UIBarButtonItem *buttonItem = [CFNavButtonBuilder TitleButtonByTitle:title AndTitleColor:color AndBlock:block];
    self.navigationItem.rightBarButtonItem = buttonItem;
    return buttonItem;
}


+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self replaceViewDidLoadMethod];
        [self replaceViewWillAppearMethod];
        [self replaceViewWillDisappearMethod];
        [self replaceDeallocMethod];
    });
}
#pragma mark 替换delloc
- (void)CFDealloc{
    [self CFDealloc];
    NSLog(@"%@-----delloc",NSStringFromClass(self.class));
}
+ (void)replaceDeallocMethod{
    SEL originalSelector = NSSelectorFromString(@"dealloc");
    SEL swizzledSelector = @selector(CFDealloc);
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
#pragma mark 替换viewWillDisappear
- (void)CFViewWillDisappear{
    [self CFViewWillDisappear];
    [self.view endEditing:YES];
}
+ (void)replaceViewWillDisappearMethod{
    SEL originalSelector = @selector(viewWillDisappear:);
    SEL swizzledSelector = @selector(CFViewWillDisappear);
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
#pragma mark 替换viewwillapp
- (void)CFViewWillAppear:(BOOL)animated{
    [self CFViewWillAppear:animated];
    SEL selector =  NSSelectorFromString(@"relayoutSubViewContent");
    if ([self respondsToSelector:selector]) {
        IMP imp = [self methodForSelector:selector];
        void (*function)(id, SEL) = (__typeof__(function))imp;
        function(self, selector);
    }
}
+ (void)replaceViewWillAppearMethod{
    SEL originalSelector = @selector(viewWillAppear:);
    SEL swizzledSelector = @selector(CFViewWillAppear:);
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
#pragma mark 替换didload
- (void)CFViewDidLoad{
    [self CFViewDidLoad];
    SEL selectorColtro =  NSSelectorFromString(@"setColtro");
    if ([self respondsToSelector:selectorColtro]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        IMP imp = [self methodForSelector:selectorColtro];
        void (*function)(id, SEL) = (__typeof__(function))imp;
        function(self, selectorColtro);
    }
    
    SEL selectorView =  NSSelectorFromString(@"bankViewInit");
    if ([self respondsToSelector:selectorView]) {
        IMP imp = [self methodForSelector:selectorView];
        void (*function)(id, SEL) = (__typeof__(function))imp;
        function(self, selectorView);
    }
    
    SEL selectorModel =  NSSelectorFromString(@"getModel");
    if ([self respondsToSelector:selectorModel]) {
        IMP imp = [self methodForSelector:selectorModel];
        void (*function)(id, SEL) = (__typeof__(function))imp;
        function(self, selectorModel);
    }
}
+ (void)replaceViewDidLoadMethod{
    SEL originalSelector = @selector(viewDidLoad);
    SEL swizzledSelector = @selector(CFViewDidLoad);
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
//// 规范格式
//- (void)setColtro{
//
//}// 设置控制器导航栏
//- (void)getModel{
//
//}// 网络请求以及MV绑定
//- (void)bankViewInit{
//
//}// V设置初始化
//- (void)relayoutSubViewContent{
//
//}// V 布局
@end

