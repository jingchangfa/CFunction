//
//  LoginBackView.h
//  New_Maya
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
// 注意一定要pch文件中引用  #import "CFunctionHeader.h"

#import <UIKit/UIKit.h>

@interface LoginBackView : CFViewBase
@property (nonatomic,strong) UITextField *numberTextfiled;
@property (nonatomic,strong) UITextField *passwordTextfiled;
@property (nonatomic, strong) CFButtonBase *loginButton;
@end
