//
//  StencilViewController.m
//  CF_RUBY_CREATE
//
//  Created by CF on 2018/3/20.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "StencilViewController.h"
#import "StencilBackView.h"

@interface StencilViewController ()
@property(nonatomic,strong) StencilBackView *backView;

@end

@implementation StencilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark controller-init
- (void)jc_setColtro{
    @WeakObj(self)
    self.title = @"";
}
- (void)jc_bankViewInit{
    @WeakObj(self)
    [self.view addSubview:self.backView];
    
}
- (void)jc_getModel{
    @WeakObj(self)
    
}
#pragma mark http

#pragma mark methord

#pragma mark push


#pragma mark get
- (StencilBackView *)backView{
    if (!_backView) {
        CGRect frame = self.view.bounds;
        frame.size.height -= (CF_NAV_HEIGHT+CF_NAV_VIEW_OFFSET);
        StencilBackView *backView = [[StencilBackView alloc] initWithFrame:frame];
        _backView = backView;
    }
    return _backView;
}
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
