//
//  CFContactsComponent.m
//  customFunction
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFContactsComponent.h"
#import "NSString+CFEncryption.h"
#import "NSString+CFDetection.h"
#import "CFFMDBComponent.h" // 数据库存储
#import "YContactsManager.h"
#import "YContactObject.h"

@implementation CFContactsComponent
+(void)CFRequestContactsComplete:(void (^)(NSArray<CFModelContacts *> * contacts,void(^finishblcok)(void)))completeBlock AndFireAlertShow:(void(^)(void))alertShowBlock{
    // 设置弹框
    YContactsManager *contactManager = [YContactsManager shareInstance];
    [contactManager setAlertShowBlcok:alertShowBlock];
    [self iphoneContactsByFinishBlock:^(NSArray<YContactObject *> *array) {
        // 手机通讯录所有联系人的数组
        NSArray *iphonesArray = [self iphoneContactsToSQLContacts:array];
        // 已上传联系人数组
        NSArray *sqlContactsArray = [self sqlContacts];
        // 修改或添加的数组
        NSArray *uploadArray = [self filterNewContactsBySQLContacts:sqlContactsArray AndiphoneContacts:iphonesArray];
        NSLog(@"改变的通讯录%d  %@",(int)uploadArray.count,uploadArray);
        completeBlock(uploadArray,^(){
            [self saveContactsToSQL:uploadArray AndFinshBlock:^(BOOL success, NSArray *firtureArray) {
                // 存储成功/失败，失败的有哪些
            }];
        });
    }];
}

// 筛选修改或添加的联系人
+ (NSArray *)filterNewContactsBySQLContacts:(NSArray *)SQLArray AndiphoneContacts:(NSArray *)iphoneContactsArray{
    NSMutableArray *uploadArray = @[].mutableCopy;
    for (CFModelContacts *content in iphoneContactsArray) {
        if (![SQLArray containsObject:content]) {//筛选改变的新加的
            [uploadArray addObject:content];
        }
    }
    return uploadArray;
}

// 获取手机通讯录联系人
+ (void)iphoneContactsByFinishBlock:(void (^)(NSArray <YContactObject *> *))completeBlock{
    YContactsManager *contactManager = [YContactsManager shareInstance];
    [contactManager requestContactsComplete:completeBlock];
}

// 获取上传服务器手机通讯录联系人
+ (NSArray *)sqlContacts{
    return [CFFMDBComponent CFFMDBSearchModelsByModelClass:[CFModelContacts class] AndSearchPropertyDictionary:nil];
}

// 持久化上传服务器手机通讯录联系人
+ (void)saveContactsToSQL:(NSArray *)contactsArray AndFinshBlock:(void(^)(BOOL success,NSArray *firtureArray))completeBlock{
    [CFFMDBComponent CFFMDBUpdateModelsByType:MODEL_MANAGER_TYPE_CHANGE WithModels:contactsArray AndFinishBlock:completeBlock];
}

#pragma mark 辅助方法
/*
 * YContactObject 转化为 KapModelContacts
 */
+ (NSArray *)iphoneContactsToSQLContacts:(NSArray *)objArray{
    NSMutableArray *iphonesArray = @[].mutableCopy;
    for (YContactObject *obj  in objArray) {
        CFModelContacts *model = [self iphoneContactToSQLContact:obj];
        if (!model.mobilesArray||model.mobilesArray.count == 0) {
            continue;
        }
        [iphonesArray addObject:model];
    }
    return iphonesArray;
}

+ (CFModelContacts *)iphoneContactToSQLContact:(YContactObject *)obj{
    NSString *givenName = obj.nameObject.givenName;
    NSString *familyName = obj.nameObject.familyName;
    NSMutableString *nameString = @"".mutableCopy;
    if(![NSString isBlankString:givenName]){
        [nameString appendString:givenName];
    }
    if (![NSString isBlankString:familyName]) {
        [nameString appendString:familyName];
    }
    NSString *mainKey = [NSString stringWithFormat:@"%d",obj.ID];
    
    CFModelContacts *contact = [[CFModelContacts alloc] init];
    contact.ID = [NSString sha512:mainKey];
    contact.nameString = nameString;
    contact.mobilesArray = [self mobilesWithArray:obj.phoneObject];
    return contact;
}

+ (NSArray *)mobilesWithArray:(NSArray <YContactPhoneObject *> *)phoneObjectsArray{
    NSMutableArray *photos = [NSMutableArray array];
    for (YContactPhoneObject *phone in phoneObjectsArray) {
        [photos addObject:phone.phoneNumber];
    }
    return photos;
}
@end
