//
//  UIColor+CFColor.m
//  customFunction
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "UIColor+CFColor.h"

@implementation UIColor (CFColor)
- (UIImage *)backgroundImage{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (UIImage *)backgroundImageBySize:(CGSize)size{
    CGRect rect=CGRectMake(0.0f, 0.0f,size.width,size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (UIColor *)toOtherColorByColor:(UIColor *)color AndRatio:(CGFloat)ratio{
    if(ratio > 1)
        ratio = 1;
    const CGFloat * components1 = CGColorGetComponents(self.CGColor);
    const CGFloat * components2 = CGColorGetComponents(color.CGColor);
    CGFloat r = components1[0]*ratio + components2[0]*(1-ratio);
    CGFloat g = components1[1]*ratio + components2[1]*(1-ratio);
    CGFloat b = components1[2]*ratio + components2[2]*(1-ratio);
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}
@end
