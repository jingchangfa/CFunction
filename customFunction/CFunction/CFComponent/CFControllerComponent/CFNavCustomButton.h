//
//  CFNavCustomButton.h
//  customFunction
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFNavCustomButton : UIButton
- (instancetype)initWithTitle:(NSString *)title AndDidBlock:(void(^)(UIButton *customButton))didBlock;
- (instancetype)initWithImage:(UIImage *)image AndDidBlock:(void(^)(UIButton *customButton))didBlock;
@end
