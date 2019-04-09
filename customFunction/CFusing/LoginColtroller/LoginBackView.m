//
//  LoginBackView.m
//  New_Maya
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "LoginBackView.h"

@implementation LoginBackView
- (void)jc_backViewInit{
    [self addSubview:self.numberTextfiled];
    [self addSubview:self.passwordTextfiled];
    [self addSubview:self.loginButton];
    
    float topOffset = CF_BitMap_BY_SIZE(36);
    float leftOffset = CF_BitMap_BY_SIZE(20);
    float viewHeight = CF_BitMap_BY_SIZE(86);

    [self.numberTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(leftOffset);
        make.right.equalTo(self).offset(-leftOffset);
        make.top.equalTo(self).offset(topOffset*5);
        make.height.mas_equalTo(viewHeight);
    }];
    [self.passwordTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.numberTextfiled);
        make.top.equalTo(self.numberTextfiled.mas_bottom).offset(topOffset);
    }];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.passwordTextfiled);
        make.top.equalTo(self.passwordTextfiled.mas_bottom).offset(topOffset);
    }];
}

#pragma mark get
CF_LazyLoadingBlock(UITextField, numberTextfiled, {
    numberTextfiled.placeholder = @"手机号";
    numberTextfiled.keyboardType = UIKeyboardTypePhonePad;
    numberTextfiled.backgroundColor = [UIColor redColor];
    numberTextfiled.clipsToBounds = YES;
})
CF_LazyLoadingBlock(UITextField, passwordTextfiled, {
    passwordTextfiled.placeholder = @"密码";
    passwordTextfiled.backgroundColor = [UIColor redColor];
})
CF_LazyLoadingBlock(UIButton, loginButton, {
    NSString *normalTitle = @"登录";
    UIColor *backColor = CF_CUSTUM_COLOR(0x313131);
    [loginButton setTitle:normalTitle forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:backColor.backgroundImage forState:UIControlStateNormal];
    [loginButton setTitle:normalTitle forState:UIControlStateNormal|UIControlStateHighlighted];
    [loginButton setBackgroundImage:backColor.backgroundImage forState:UIControlStateNormal|UIControlStateHighlighted];
})

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
