//
//  CFButtonBase.m
//  New_Maya
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFButtonBase.h"

@implementation CFButtonBase
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
- (void)bankViewInit{
    self.scc_custom_acceptEventInterval = 0.3;
}
- (void)addAction{
    // 只添加 点击
    [self addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)buttonAction:(UIButton *)button{
    BOOL needSendAction = (NSDate.date.timeIntervalSince1970 - scc_custom_acceptEventTime > self.scc_custom_acceptEventInterval);
    if (self.scc_custom_acceptEventInterval > 0) {
        scc_custom_acceptEventTime = NSDate.date.timeIntervalSince1970;
    }
    if (!needSendAction) return;
    if (self.didBlock) {
        self.userInteractionEnabled = NO;
        self.didBlock(self);
        self.userInteractionEnabled = YES;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
