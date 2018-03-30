//
//  UIViewController+CFHUDComponent.m
//  New_Maya
//
//  Created by jing on 2018/3/26.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "UIViewController+CFHUDComponent.h"

@implementation UIViewController (CFHUDComponent)
- (void)cf_presentViewController:(UIAlertController *)alertControllerToPresent animated:(BOOL)flag afterHidden:(float)time showCompletion:(void (^)(void))showCompletion hiddenCompletion:(void (^)(void))hiddenCompletion{
    [self presentViewController:alertControllerToPresent animated:flag completion:showCompletion];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertControllerToPresent dismissViewControllerAnimated:flag completion:hiddenCompletion];
    });
}
@end
