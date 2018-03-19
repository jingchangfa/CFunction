//
//  CFAuthorPermissions.m
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFAuthorPermissions.h"
#import "CFPermissionConfig.h"

#import "PrefsCamera.h"
#import "PrefsMicrophone.h"
#import "PrefsPhoto.h"
#import "PrefsAddressBook.h"
#import "PrefsLocation.h"

@implementation CFAuthorPermissions

+ (BOOL)CFAuthorPermissionWithStatus:(CFAuthorPermissions_status)status{
    __block BOOL havePermission = YES;
    __block Class authClass;
    __block NSString *title;
    [self getClassAndTitleStringByStatus:status AndFinishBlock:^(NSString *titleString, __unsafe_unretained Class class) {
        authClass = &*class;
        title = titleString;
    }];
    [authClass adjustPrivacySettingEnable:^(BOOL pFlag) {
        if (!pFlag) {
            //无权限
            havePermission = NO;
            [CFPermissionConfig alertShowWithTitle:title BySetingBlock:^{
                [authClass openPrivacySetting];
            }];
        }
    }];
    return havePermission;
}

+ (void)getClassAndTitleStringByStatus:(CFAuthorPermissions_status)status
                        AndFinishBlock:(void(^)(NSString *titleString,Class class))finishBlock{
    if (!finishBlock) return;
    switch (status) {
        case CFAuthorPermissions_camera:
            finishBlock([CFPermissionConfig cameraTitle],[PrefsCamera class]);
            break;
        case CFAuthorPermissions_mic:
            finishBlock([CFPermissionConfig micTitle],[PrefsMicrophone class]);
            break;
        case CFAuthorPermissions_photo:
            finishBlock([CFPermissionConfig photoTitle],[PrefsPhoto class]);
            break;
        case CFAuthorPermissions_adress:
            finishBlock([CFPermissionConfig adressTitle],[PrefsAddressBook class]);
            break;
        case CFAuthorPermissions_location:
            finishBlock([CFPermissionConfig locationTitle],[PrefsLocation class]);
            break;
        default:
            break;
    }
}

@end
