//
//  CFFMDBConfig.h
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFFMDBConfig : NSObject
// 一个用户一个数据库，返回用户的标示符
+ (NSString *)userDataBaseIdentifier;
+ (NSString *)theCompanyName;// db路径一部分
+ (NSString *)theProjectName;// db路径一部分


@end
