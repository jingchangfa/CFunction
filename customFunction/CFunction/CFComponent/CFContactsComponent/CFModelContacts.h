//
//  CFModelContacts.h
//  customFunction
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CFFMDBModelProtocol.h"

@interface CFModelContacts : NSObject<CFFMDBModelProtocol>
@property (nonatomic,strong)NSString *ID; //本地的持久化用创建日期+名字作为主键
@property (nonatomic,strong)NSString *nameString;
@property (nonatomic,strong)NSArray *mobilesArray;
@end
