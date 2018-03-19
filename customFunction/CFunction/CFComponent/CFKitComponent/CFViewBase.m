//
//  CFViewBase.m
//  New_Maya
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFViewBase.h"

@implementation CFViewBase
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self bankViewInit];
    }
    return self;
}

- (instancetype)init{
    self =  [super init];
    if (self) {
        [self bankViewInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self bankViewInit];
    }
    return self;
}

- (void)bankViewInit{
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
