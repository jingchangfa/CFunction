//
//  CFTextFieldBase.h
//  New_Maya
//
//  Created by jing on 2018/3/21.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFTextFieldBase : UITextField
@property (nonatomic,copy)void(^textDidChange)(UITextField *textField);
- (void)bankViewInit;
- (void)setTextDidChange:(void (^)(UITextField *textField))textDidChange;

@end
