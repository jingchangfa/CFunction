//
//  CFButtonBase.h
//  New_Maya
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFButtonBase : UIButton{
    NSTimeInterval scc_custom_acceptEventTime;// 接收到点击事件的时间
}
// 可重复点击的时间间隔
@property (nonatomic, assign) NSTimeInterval scc_custom_acceptEventInterval;
@property (nonatomic,copy)void(^didBlock)(UIButton *button) ;
- (void)setDidBlock:(void (^)(UIButton *button))didBlock;
@end
