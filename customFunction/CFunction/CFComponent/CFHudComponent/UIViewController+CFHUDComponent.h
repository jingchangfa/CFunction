//
//  UIViewController+CFHUDComponent.h
//  New_Maya
//
//  Created by jing on 2018/3/26.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CFHUDComponent)


/**
 

 @param alertControllerToPresent
 @param flag
 @param time 时间
 */

/**
 弹出alertController

 @param alertControllerToPresent alertController
 @param flag 是否动画
 @param time alert存在时间
 @param showCompletion 出现完成的回掉
 @param hiddenCompletion 消失完成的回掉
 */
- (void)cf_presentViewController:(UIAlertController *)alertControllerToPresent animated:(BOOL)flag afterHidden:(float)time showCompletion:(void (^)(void))showCompletion hiddenCompletion:(void (^)(void))hiddenCompletion;

@end
