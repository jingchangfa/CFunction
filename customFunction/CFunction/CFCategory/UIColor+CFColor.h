//
//  UIColor+CFColor.h
//  customFunction
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CFColor)
- (UIImage *)backgroundImage;
- (UIImage *)backgroundImageBySize:(CGSize)size;
// 两个颜色过渡，颜色混色算法
- (UIColor *)toOtherColorByColor:(UIColor *)color AndRatio:(CGFloat)ratio;
@end
