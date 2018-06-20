//
//  NewCreateViewController.m
//  CF_RUBY_CREATE
//
//  Created by CF on 2018/3/20.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "NewCreateViewController.h"
#import "NewCreateBackView.h"

@interface NewCreateViewController ()
@property(nonatomic,strong) NewCreateBackView *backView;

@end

@implementation NewCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark controller-init
- (void)setColtro{
    @WeakObj(self)
    self.title = @"";
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

#pragma mark push


#pragma mark get
CF_LazyLoadingBlock(NewCreateBackView, backView, {
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
