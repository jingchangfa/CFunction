//
//  LoginViewController.m
//  New_Maya
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginBackView.h"

@interface LoginViewController ()
@property(nonatomic,strong) LoginBackView *backView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)setColtro{
    @WeakObj(self)
    self.title = @"登录";
    [self addNavRightButtonByTitle:@"注册" AndTitleColor:[UIColor blackColor] AndClickBlock:^(UIButton *button) {
        [selfWeak pushListController];
    }];
}
- (void)bankViewInit{
    @WeakObj(self)
    [self.view addSubview:self.backView];
    [self.backView.loginButton setDidBlock:^(UIButton *button) {
        [selfWeak httpLogin];
    }];
}
- (void)getModel{
    
}
#pragma mark http
- (void)httpLogin{
    [[CFHttpLogInClick client] loginWithMobileString:@"123123123" AndPassWord:@"1111111" withSuccess:^(NSNumber *userID, NSString *token, NSDictionary *herd) {
        
    } andFailure:^(NSInteger errorCode, NSString *errorMsg) {
        
    }];
}
#pragma mark methord
- (void)pushListController{
    CFRouteComponent *route = [self cf_registerPushByControllerName:@"ListViewController"];
    [route setCFTitle:@"列表"];
    [self.navigationController pushViewController:self.cf_registerController animated:YES];
}

#pragma mark get
CF_LazyLoadingBlock(LoginBackView, backView, {
    backView.frame = self.view.bounds;
})
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
