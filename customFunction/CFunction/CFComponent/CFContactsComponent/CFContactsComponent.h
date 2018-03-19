//
//  CFContactsComponent.h
//  customFunction
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CFModelContacts.h"

@interface CFContactsComponent : NSObject
+(void)CFRequestContactsComplete:(void (^)(NSArray<CFModelContacts *> * contacts,void(^finishblcok)(void)))completeBlock AndFireAlertShow:(void(^)(void))alertShowBlock;
@end
