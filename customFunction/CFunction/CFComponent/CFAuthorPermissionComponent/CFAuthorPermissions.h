//
//  CFAuthorPermissions.h
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger){
    CFAuthorPermissions_camera = 0,
    CFAuthorPermissions_mic = 1,
    CFAuthorPermissions_photo = 2,
    CFAuthorPermissions_adress = 3,
    CFAuthorPermissions_location = 4
} CFAuthorPermissions_status;

@interface CFAuthorPermissions : NSObject
+ (BOOL)CFAuthorPermissionWithStatus:(CFAuthorPermissions_status)status;
@end
