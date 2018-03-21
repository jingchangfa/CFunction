//
//  CFImageViewBase.m
//  New_Maya
//
//  Created by jing on 2018/3/21.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFImageViewBase.h"

@implementation CFImageViewBase
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
- (instancetype)initWithImage:(UIImage *)image{
    self = [super initWithImage:image];
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
- (void)bankViewInit{
    self.userInteractionEnabled = YES;
}
- (void)addAction{
    UITapGestureRecognizer *didTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewAction:)];
    didTapGesture.numberOfTouchesRequired = 1;
    didTapGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:didTapGesture];
}
- (void)imageViewAction:(UITapGestureRecognizer *)tap{
    if (!self.didBlock) return;
    self.userInteractionEnabled = NO;
    self.didBlock(self);
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
