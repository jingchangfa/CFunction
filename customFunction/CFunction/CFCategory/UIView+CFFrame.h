//
//  UIView+CFFrame.h
//  New_Maya
//
//  Created by jing on 2018/3/23.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CFFrame)
@property (nonatomic, assign) CGFloat  originX;
@property (nonatomic, assign) CGFloat  originY;
@property (nonatomic, assign) CGPoint  origin;
@property (nonatomic, assign) CGFloat  width;
@property (nonatomic, assign) CGFloat  height;
@property (nonatomic, assign) CGSize   size;
@property (nonatomic, assign) CGFloat  centerX;
@property (nonatomic, assign) CGFloat  centerY;

#pragma mark 辅助方法
/**
 * convertRectFrame 获取绝对坐标(相对于屏幕的坐标)
 */
- (CGRect)convertRectFrame;
@end
