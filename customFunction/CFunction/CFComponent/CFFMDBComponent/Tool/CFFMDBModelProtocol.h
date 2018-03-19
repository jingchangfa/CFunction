//
//  CFFMDBModelProtocol.h
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CFFMDBModelProtocol <NSObject>
// model类中有一些property不需要创建数据库字段重写此方法 (默认 @[@"debugDescription",@"description",@"hash",@"superclass"])
@optional
+ (NSArray *)transients;
// 下面两个当model存在嵌套时重写
#pragma mark +(Class)属性名+CFModel
#pragma mark +(Class)属性名+CFModelArray
// 设置主键(默认ID注意！！ 如果存储失败则看此处)
@optional
+ (NSString *)mainKey;
@optional
- (NSString *)mainKey;

// 指定父类 (默认 NSObject)
@optional
+ (Class)modelBaseClass;
@end
