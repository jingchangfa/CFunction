//
//  NSMutableArray+CFChange.h
//  customFunction
//
//  Created by jing on 2018/7/5.
//  Copyright © 2018年 jing. All rights reserved.
//  数组方法延展

#import <Foundation/Foundation.h>

@interface NSMutableArray (CFChange)
/**
 数组根据一个model的字段相似删除一个对象（不是根据内存地址判断相似）
 */
- (void)removeModel:(NSObject *)model AndEqualKey:(NSString *)key;
@end
