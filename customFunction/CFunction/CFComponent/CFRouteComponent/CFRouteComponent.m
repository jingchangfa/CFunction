//
//  CFRouteComponent.m
//  New_Maya
//
//  Created by jing on 2018/3/21.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFRouteComponent.h"
@interface CFRouteComponent ()
@property (nonatomic,strong) NSDictionary *param;
@property (nonatomic,strong) NSNumber *ID;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSObject<CFFMDBModelProtocol> *model;
@property (nonatomic,copy) void(^block)(NSDictionary *param);
@end

@implementation CFRouteComponent
- (void)setCFParam:(NSDictionary *)param{
    self.param = param;
}
- (void)setCFID:(NSNumber *)ID{
    self.ID = ID;
}
- (void)setCFTitle:(NSString *)title{
    self.title = title;
}
- (void)setCFModel:(NSObject<CFFMDBModelProtocol> *)model{
    self.model = model;
}
- (void)setCFBlock:(void (^)(NSDictionary *param))block{
    self.block = block;
}
@end
