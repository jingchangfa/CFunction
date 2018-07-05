//
//  NSMutableArray+CFChange.m
//  customFunction
//
//  Created by jing on 2018/7/5.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "NSMutableArray+CFChange.h"

@implementation NSMutableArray (CFChange)
- (void)removeModel:(NSObject *)model AndEqualKey:(NSString *)key{
    NSObject *modelValue = [model valueForKey:key];
    for (int i=0; i<self.count; i++) {
        NSObject* obj = self[i];
        if (![obj.class isEqual:model.class]) continue;
        NSObject *objValue = [obj valueForKey:key];
        if ([modelValue isEqual:objValue]) {
            [self removeObject:obj];
            return;
        }
    }
}
@end
