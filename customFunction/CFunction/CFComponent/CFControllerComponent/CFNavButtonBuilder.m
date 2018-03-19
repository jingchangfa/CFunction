//
//  CFNavButtonBuilder.m
//  customFunction
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFNavButtonBuilder.h"
#import "CFNavCustomButton.h"

@implementation CFNavButtonBuilder
+ (UIBarButtonItem *)TitleButtonByTitle:(NSString *)title
                          AndTitleColor:(UIColor *)titleColor
                               AndBlock:(void(^)(UIButton *button))block{
    CFNavCustomButton *customButton = [[CFNavCustomButton alloc] initWithTitle:title AndDidBlock:block];
    [customButton setTitleColor:titleColor forState:UIControlStateNormal];
    [customButton setTitleColor:titleColor forState:UIControlStateHighlighted];
    UIBarButtonItem *barIteam = [[UIBarButtonItem alloc] initWithCustomView:customButton];
    return barIteam;
}

+ (UIBarButtonItem *)ImageButtonByImageName:(NSString *)imageName
                                   AndBlock:(void(^)(UIButton *button))block{
    CFNavCustomButton *customButton = [[CFNavCustomButton alloc] initWithImage:[UIImage imageNamed:imageName] AndDidBlock:block];
    UIBarButtonItem *barIteam = [[UIBarButtonItem alloc] initWithCustomView:customButton];
    return barIteam;
}
@end
