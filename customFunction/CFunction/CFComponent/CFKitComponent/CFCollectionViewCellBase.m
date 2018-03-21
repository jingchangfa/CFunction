//
//  CFCollectionViewCellBase.m
//  New_Maya
//
//  Created by jing on 2018/3/21.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFCollectionViewCellBase.h"

@implementation CFCollectionViewCellBase

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self bankViewInit];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
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
- (void)bankViewInit{
}
@end
