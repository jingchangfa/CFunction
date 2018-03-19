//
//  CFHttpLogInClick.m
//  customFunction
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFHttpLogInClick.h"

@implementation CFHttpLogInClick

- (void)loginWithMobileString:(NSString *)numberString
                  AndPassWord:(NSString *)passwordString
                  withSuccess:(void(^)(NSNumber *userID,NSString *token,NSDictionary *herd))success
                   andFailure:(defaultFailureBlock)failure{
    NSString * urlString = [[self.apiConfiguration login] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSDictionary *parameters = @{@"mobile":numberString,
                                 @"password":passwordString,
                                 };
    HTTPAPIFinishedBlock finishedBlock = [self customFinishedBlock:^BOOL(id resultObject) {
        NSInteger succeed = [resultObject[@"success"] integerValue];
        if (succeed) {
            NSDictionary *herdDic = @{@"upload":resultObject[@"upload_addr"]};
            success(resultObject[@"id"],resultObject[@"token"],herdDic);
        }
        return YES;
    } withFailure:failure];
    [self.apiEngine httpPostRequest:urlString parameters:parameters bodyWithBlock:nil finished:finishedBlock];
}
@end
