//
//  CFNavButtonBuilder.h
//  customFunction
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CFNavButtonBuilder : NSObject
+ (UIBarButtonItem *)TitleButtonByTitle:(NSString *)title
                          AndTitleColor:(UIColor *)titleColor
                               AndBlock:(void(^)(UIButton *button))block;

+ (UIBarButtonItem *)ImageButtonByImageName:(NSString *)imageName
                                   AndBlock:(void(^)(UIButton *button))block;
@end
