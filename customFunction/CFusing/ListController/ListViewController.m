//
//  ListViewController.m
//  CF_RUBY_CREATE
//
//  Created by CF on 2018/3/20.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "ListViewController.h"
#import "ListBackView.h"

@interface ListViewController ()
@property(nonatomic,strong) ListBackView *backView;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark controller-init
- (void)setColtro{
    self.title = self.cf_titleValue;
    [self addNavBackButtonByTitle:@"去登录" AndTitleColor:[UIColor blackColor] AndClickBlock:nil];
}
- (void)bankViewInit{
    @WeakObj(self)
    [self.view addSubview:self.backView];
}
- (void)getModel{
    @WeakObj(self)
    
}
#pragma mark http

#pragma mark methord


#pragma mark get
CF_LazyLoadingBlock(ListBackView, backView, {
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
