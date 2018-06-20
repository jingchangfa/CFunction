//
//  CFNavCustomButton.m
//  customFunction
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFNavCustomButton.h"
@interface CFNavCustomButton (){
    NSTimeInterval scc_custom_acceptEventTime;// 接收到点击事件的时间
}
@property (nonatomic,copy)void(^didBlock)(UIButton *button);
@property (nonatomic, assign) NSTimeInterval scc_custom_acceptEventInterval;// 可重复点击的时间间隔
@end
@implementation CFNavCustomButton

- (instancetype)initWithTitle:(NSString *)title AndDidBlock:(void(^)(UIButton *customButton))didBlock{
    CGFloat fontSize = 30*0.5;
    CGSize maxSize = CGSizeMake(100, 30);
    CGRect frame = CGRectMake(0, 0, 0, 0);
    frame.size = [title toStringSizeAndFountSize:fontSize AndFountWidth:-1 AndMaxSize:maxSize];
    self = [super initWithFrame:frame];
    if (self) {
        self.didBlock = didBlock;
        self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateHighlighted];
        [self addAction];
    }
    return self;
}
- (instancetype)initWithImage:(UIImage *)image AndDidBlock:(void(^)(UIButton *customButton))didBlock{
    self = [super initWithFrame:CGRectMake(0, 0, 30, 30)];
    if (self) {
        self.didBlock = didBlock;
        if (!image) {
            image = [UIImage imageNamed:@"image_notfound"];
            NSLog(@"未发现图片");
        }
        [self setBackgroundImage:image forState:UIControlStateNormal];
        [self setBackgroundImage:image forState:UIControlStateHighlighted];
        [self addAction];
    }
    return self;
}
- (UIEdgeInsets)alignmentRectInsets {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)addAction{
    // 只添加 点击
    [self addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}
// 防止连续点击(两次点击事件间隔大于scc_custom_acceptEventInterval才会响应)
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
