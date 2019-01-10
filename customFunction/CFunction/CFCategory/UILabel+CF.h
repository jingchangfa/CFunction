//
//  UILabel+CF.h
//  customFunction
//
//  Created by jing on 2019/1/10.
//  Copyright © 2019 jing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (CF)
// masonry 宽度自适应
- (void)masonry_widthToFit;

// masonry 高度自适应
- (void)masonry_heightToFitByWidth:(float)width;
@end

NS_ASSUME_NONNULL_END
