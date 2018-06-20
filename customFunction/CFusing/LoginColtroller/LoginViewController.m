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
    [self longSaveModel];
}
#pragma mark http
- (void)httpLogin{
    [[CFHttpLogInClick client] loginWithMobileString:@"123123123" AndPassWord:@"1111111" withSuccess:^(NSNumber *userID, NSString *token, NSDictionary *herd) {
        
    } andFailure:^(NSInteger errorCode, NSString *errorMsg) {
        
    }];
}
#pragma mark methord
// 数据持久化
- (void)longSaveModel{
    // 批量更新（增或改）
    NSMutableArray *userArray = @[].mutableCopy;
    for (int i=0; i<10; i++) {
        UserModel *model = [[UserModel alloc] init];
        model.ID = @(i);
        model.name = [NSString stringWithFormat:@"小明 %d 号",i];
        [userArray addObject:model];
    }
    [CFFMDBComponent CFFMDBUpdateModelsByType:MODEL_MANAGER_TYPE_CHANGE WithModels:userArray AndFinishBlock:^(BOOL successful, NSArray *fireModelArray) {
    }];
    // 查询
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *userAll = [CFFMDBComponent CFFMDBSearchModelsByModelClass:[UserModel class] AndSearchPropertyDictionary:nil];
        NSLog(@"%@",userAll);
        UserModel *oneUser = [CFFMDBComponent CFFMDBSearchModelsByModelClass:[UserModel class] AndSearchPropertyDictionary:@{@"ID":@(5)}].firstObject;
        NSLog(@"%@",oneUser.name);
        oneUser.name = @"5号变小红啦";
        // 单个更新
        [CFFMDBComponent CFFMDBUpdataModelByType:MODEL_MANAGER_TYPE_CHANGE WithModel:oneUser];
        // 查询
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UserModel *oneUser = [CFFMDBComponent CFFMDBSearchModelsByModelClass:[UserModel class] AndSearchPropertyDictionary:@{@"ID":@(5)}].firstObject;
            NSLog(@"%@",oneUser.name);
        });
    });
    
}

- (void)pushListController{
    CFRouteComponent *route = [self cf_registerPushByControllerName:@"ListViewController"];
    [route setCFTitle:@"列表"];
    [self.navigationController pushViewController:self.cf_registerController animated:YES];
}

#pragma mark get
CF_LazyLoadingBlock(LoginBackView, backView, {
    CGRect frame = self.view.bounds;
    frame.size.height -= (CF_NAV_HEIGHT+CF_NAV_VIEW_OFFSET);
    backView.frame = frame;
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
