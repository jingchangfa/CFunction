//
//  NSString+CFTypeConversion.h
//  customFunction
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (CFTypeConversion)
//获取字符串的尺寸
- (CGSize)toStringSizeAndFountSize:(float)fountSize
                     AndFountWidth:(float)fountWidth
                        AndMaxSize:(CGSize)maxSize;

// 转化为url
- (NSURL *)filePathToURL;
// 时间格式的字符串转化为time
- (NSTimeInterval)toTimeInterval;
- (NSTimeInterval)toTimeIntervalByDateComponents:(NSString *)dateComponents;
#pragma mark 转化为富文本
/**
 颜色
 
 @param nolmalColor 颜色
 @param selectedStringArray 颜色
 @param selColor 颜色
 @return 富文本
 */
- (NSMutableAttributedString *)toAttributedStringAndNormalColor:(UIColor *)nolmalColor
                                               AndSeletedString:(NSArray<NSString *> *)selectedStringArray
                                               AndSelectenColor:(UIColor *)selColor;

/**
 字体
 
 @param nolmalSize 字体大小
 @param selectedStringArray 选中
 @param selSize 字体大小
 @return 富文本
 */
- (NSMutableAttributedString *)toAttributedStringAndNormalSize:(float)nolmalSize
                                              AndSeletedString:(NSArray<NSString *> *)selectedStringArray
                                              AndSelectenColor:(float )selSize;


/**
 文字和字体
 
 @param nolmalColor 颜色
 @param normalFont 字体
 @param selectedStringArray 选中
 @param selColor 颜色
 @param selectFont 字体
 @return 富文本
 */
- (NSMutableAttributedString *)toAttributedStringAndNormalColor:(UIColor *)nolmalColor
                                                  AndNormalFont:(UIFont *)normalFont
                                               AndSeletedString:(NSArray<NSString *> *)selectedStringArray
                                               AndSelectenColor:(UIColor *)selColor
                                                  AndSelectFont:(UIFont *)selectFont;
@end
