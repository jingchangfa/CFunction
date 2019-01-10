//
//  UILabel+CF.m
//  customFunction
//
//  Created by jing on 2019/1/10.
//  Copyright © 2019 jing. All rights reserved.
//

#import "UILabel+CF.h"

@implementation UILabel (CF)
// masonry 宽度自适应
- (void)masonry_widthToFit{
    [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    //     [self setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
}

// masonry 高度自适应
- (void)masonry_heightToFitByWidth:(float)width{
    self.preferredMaxLayoutWidth = width;
    [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    self.numberOfLines = 0;
}
@end
