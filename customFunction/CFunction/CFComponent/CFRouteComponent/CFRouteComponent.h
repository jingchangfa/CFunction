//
//  CFRouteComponent.h
//  New_Maya
//
//  Created by jing on 2018/3/21.
//  Copyright © 2018年 jing. All rights reserved.
// 

#import <Foundation/Foundation.h>
#import "CFFMDBModelProtocol.h"
@interface CFRouteComponent : NSObject
- (void)setCFParam:(NSDictionary *)param;
- (void)setCFID:(NSNumber *)ID;
- (void)setCFTitle:(NSString *)title;
- (void)setCFModel:(NSObject<CFFMDBModelProtocol> *)model;
- (void)setCFBlock:(void (^)(NSDictionary *param))block;
@end
