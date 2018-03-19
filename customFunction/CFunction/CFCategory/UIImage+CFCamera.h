//
//  UIImage+CFCamera.h
//  customFunction
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CFCamera)
// 拍照的图片直接裁剪会旋转90度的解决
- (UIImage *)fixOrientationImage;
// 毛玻璃
- (UIImage *)toBoxblurByBlurNumber:(CGFloat)blur;
@end
