//
//  UIButton+BlocksKit.h
//  Wolverine
//
//  Created by jing on 2019/4/9.
//  Copyright © 2019 jing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (BlocksKit)
- (void)bk_addEventHandler:(void (^)(UIButton *button))block forControlEvents:(UIControlEvents)controlEvents;
@end

NS_ASSUME_NONNULL_END
