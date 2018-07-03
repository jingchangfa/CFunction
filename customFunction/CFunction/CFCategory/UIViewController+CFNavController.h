//
//  UIViewController+CFNavController.h
//  New_Maya
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CFNotificationComponent.h"// 通知封装

@interface UIViewController (CFNavController)
// 颜色
- (void)setBackgroundColor:(UIColor *)backgroundColor;
- (void)setNavBackgroundColor:(UIColor *)backgroundColor;
- (void)setNavTitleColor:(UIColor *)titleColor;
// 透明度
- (void)setNavTranslucent:(BOOL)translucent;
- (void)setNavShadowLine:(BOOL)shadow;// 导航栏下面的黑线
- (void)setNavTitle:(NSString *)title;
// AppDelegate
- (AppDelegate *)appDelegate;
// 通知调用对象
@property (nonatomic, strong)CFNotificationComponent *notificationComponent;
// 导航条按钮
- (void)onBackButtonClicked;// 返回按钮的点击事件

- (UIBarButtonItem *)addNavBackButtonByImageName:(NSString *)imageName AndClickBlock:(void(^)(UIButton *button))block;
- (UIBarButtonItem *)addNavLeftButtonByImageName:(NSString *)imageName AndClickBlock:(void(^)(UIButton *button))block;
- (UIBarButtonItem *)addNavRightButtonByImageName:(NSString *)imageName AndClickBlock:(void(^)(UIButton *button))block;


- (UIBarButtonItem *)addNavBackButtonByTitle:(NSString *)title AndTitleColor:(UIColor *)color AndClickBlock:(void(^)(UIButton *button))block;
- (UIBarButtonItem *)addNavLeftButtonByTitle:(NSString *)title AndTitleColor:(UIColor *)color AndClickBlock:(void(^)(UIButton *button))block;
- (UIBarButtonItem *)addNavRightButtonByTitle:(NSString *)title AndTitleColor:(UIColor *)color AndClickBlock:(void(^)(UIButton *button))block;

// 规范格式
- (void)setColtro;// 设置控制器导航栏
- (void)getModel;// 网络请求以及MV绑定
- (void)bankViewInit;// V设置初始化
- (void)notificationCallbackSetting;// 通知回调设置
- (void)relayoutSubViewContent;// V 布局
@end
