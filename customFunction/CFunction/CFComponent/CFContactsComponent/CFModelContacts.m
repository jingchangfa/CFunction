//
//  CFModelContacts.m
//  customFunction
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFModelContacts.h"

@implementation CFModelContacts
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id",
             @"nameString":@"name",
             @"mobilesArray":@"numbers"
             };
}
//重写 isEqual
- (BOOL)isEqual:(id)object{
    // ID 用 创建时间+名称 md5加密 生成
    CFModelContacts *model = object;
    if (![self.ID isEqual:model.ID]) {
        return NO;
    }
    if (![self.nameString isEqual:model.nameString]) {
        return NO;
    }
    if (![self.mobilesArray.description isEqual:model.mobilesArray.description]) {
        return NO;
    }
    return YES;
}
@end
