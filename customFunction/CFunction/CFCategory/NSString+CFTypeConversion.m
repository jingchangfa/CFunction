//
//  NSString+CFTypeConversion.m
//  customFunction
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "NSString+CFTypeConversion.h"

@implementation NSString (CFTypeConversion)
- (CGSize)toStringSizeAndFountSize:(float)fountSize
                     AndFountWidth:(float)fountWidth
                        AndMaxSize:(CGSize)maxSize{
    UIFont *fount = [UIFont systemFontOfSize:fountSize weight:fountWidth];
    if (fountWidth == -1) {
        fount = [UIFont systemFontOfSize:fountSize];
    }
    NSDictionary *dic = @{NSFontAttributeName:fount};//输入的字体的大小
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGSize stringSize = [self boundingRectWithSize:maxSize options:options attributes:dic context:nil].size;
    return stringSize;
}
- (NSURL *)filePathToURL{
    NSURL *url = nil;
    if ([self containsString:@"http"]) {
        url = [NSURL URLWithString:self];
        return url;
    }
    url = [NSURL fileURLWithPath:self];
    return url;
}
- (NSTimeInterval)toTimeInterval{
    return [self toTimeIntervalByDateComponents:@"yyyy.MM.dd  HH:mm"];
}

- (NSTimeInterval)toTimeIntervalByDateComponents:(NSString *)dateComponents{
    NSDateFormatter *dateformat = [NSString createdDateFormatterByDateComponents:dateComponents];
    NSDate *date = [dateformat dateFromString:self];
    return date.timeIntervalSince1970;
}
+ (NSDateFormatter *)createdDateFormatterByDateComponents:(NSString *)dateComponents{
    NSDateFormatter *dateformat = [[NSDateFormatter alloc]init];
    [dateformat setDateStyle:NSDateFormatterNoStyle];
    [dateformat setTimeStyle:NSDateFormatterNoStyle];
    [dateformat setDateFormat:dateComponents];
    return dateformat;
}
// 富文本
- (NSMutableAttributedString *)toAttributedStringAndNormalColor:(UIColor *)nolmalColor
                                               AndSeletedString:(NSArray<NSString *> *)selectedStringArray
                                               AndSelectenColor:(UIColor *)selColor{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:self];
    [attributeString setAttributes:@{NSForegroundColorAttributeName :nolmalColor
                                     }
                             range:NSMakeRange(0, self.length)];
    [self traverseSeletedArray:selectedStringArray ByFinishBlock:^(NSRange selRange) {
        [attributeString setAttributes:@{NSForegroundColorAttributeName :selColor}
                                 range: selRange];
    }];
    return attributeString;
}
- (NSMutableAttributedString *)toAttributedStringAndNormalSize:(float)nolmalSize
                                              AndSeletedString:(NSArray<NSString *> *)selectedStringArray
                                              AndSelectenColor:(float )selSize{
    UIFont *normalFont = [UIFont systemFontOfSize:nolmalSize];
    UIFont *selectFont = [UIFont systemFontOfSize:selSize];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:self];
    [attributeString addAttribute:NSFontAttributeName value:normalFont range:NSMakeRange(0, self.length)];
    [self traverseSeletedArray:selectedStringArray ByFinishBlock:^(NSRange selRange) {
        [attributeString addAttribute:NSFontAttributeName value:selectFont range:selRange];
    }];
    return attributeString;
}

- (NSMutableAttributedString *)toAttributedStringAndNormalColor:(UIColor *)nolmalColor
                                                  AndNormalFont:(UIFont *)normalFont
                                               AndSeletedString:(NSArray<NSString *> *)selectedStringArray
                                               AndSelectenColor:(UIColor *)selColor
                                                  AndSelectFont:(UIFont *)selectFont{
    NSMutableAttributedString *attributeString = [self toAttributedStringAndNormalColor:nolmalColor AndSeletedString:selectedStringArray AndSelectenColor:selColor];
    [attributeString addAttribute:NSFontAttributeName value:normalFont range:NSMakeRange(0, self.length)];
    [self traverseSeletedArray:selectedStringArray ByFinishBlock:^(NSRange selRange) {
        [attributeString addAttribute:NSFontAttributeName value:selectFont range:selRange];
    }];
    return attributeString;
}
#pragma mark 辅助方法
- (void)traverseSeletedArray:(NSArray<NSString *> *)selectedStringArray
               ByFinishBlock:(void(^)(NSRange selRange))finishBlock{
    for (NSString *selectedString in selectedStringArray) {
        NSRange selRange = [self rangeOfString:selectedString];
        if (selRange.location != NSNotFound && finishBlock) finishBlock(selRange);
    }
}
@end
