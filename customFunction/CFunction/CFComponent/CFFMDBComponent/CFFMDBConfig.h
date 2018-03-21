//
//  CFFMDBConfig.h
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFFMDBConfig : NSObject
+ (NSString *)theCompanyName;// db路径一部分
+ (NSString *)theProjectName;// db路径一部分

// 如果一个用户一个数据库，那么你可以重新实现下面的方法，根据用户的ID生成数据库的路径
+ (NSString *)userDataBaseIdentifier;
@end
