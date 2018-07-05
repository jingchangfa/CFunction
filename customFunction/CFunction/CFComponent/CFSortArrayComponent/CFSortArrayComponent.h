//
//  CFSortArrayComponent.h
//  customFunction
//
//  Created by jing on 2018/7/3.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFSortArrayComponent : NSObject
/**
 model数组按照字段排序
 * @param modelsArray 需要排序的数组
 * @param sortKey 排序的key
 * @param block 回掉函数(suoYinArray:@[@"",@'']   sortModelArray:@[@[],@[]])
 */
+(void)modelArrayWithArray:(NSArray *)modelsArray
           AndSortModelKey:(NSString *)sortKey
              AndSortBlock:(void(^)(NSArray *suoYinArray,NSArray *sortModelArray))block;
@end
