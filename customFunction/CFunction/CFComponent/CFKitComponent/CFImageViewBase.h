//
//  CFImageViewBase.h
//  New_Maya
//
//  Created by jing on 2018/3/21.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFImageViewBase : UIImageView
- (void)bankViewInit;
@property (nonatomic,copy) void(^didBlock)(UIImageView *imageView);
- (void)setDidBlock:(void (^)(UIImageView *imageView))didBlock;
@end
