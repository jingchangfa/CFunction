//
//  CFTextFieldBase.m
//  New_Maya
//
//  Created by jing on 2018/3/21.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFTextFieldBase.h"

@implementation CFTextFieldBase
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self bankViewInit];
        [self addAction];
    }
    return self;
}
- (instancetype)init{
    self =  [super init];
    if (self) {
        [self bankViewInit];
        [self addAction];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self bankViewInit];
        [self addAction];
    }
    return self;
}
- (void)addAction{
    [self addTarget:self action:@selector(textFiledDidChange:) forControlEvents:UIControlEventEditingChanged];
}
- (void)textFiledDidChange:(UITextField *)textFiled{
    if (!self.textDidChange) return;
    self.userInteractionEnabled = NO;
    self.textDidChange(self);
    self.userInteractionEnabled = YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
