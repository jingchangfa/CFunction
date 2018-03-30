//
//  CFHttpArticleClick.m
//  New_Maya
//
//  Created by jing on 2018/3/20.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFHttpArticleClick.h"

@implementation CFHttpArticleClick
- (void)articleListByOffset:(int)offset
                   AndLimit:(int)limit
                withSuccess:(void(^)(NSArray *articleArray))success
                 andFailure:(defaultFailureBlock)failure{
    NSString * urlString = [[self.apiConfiguration list] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSDictionary *parameters = @{@"offset":@(offset),
                                 @"limit":@(limit)
                                 };
    parameters = [self urlParametersDictionary:parameters];
    HTTPAPIFinishedBlock finishedBlock = [self customFinishedBlock:^BOOL(id resultObject) {
        NSInteger succeed = [resultObject[@"success"] integerValue];
        if (succeed) {
            success(@[]);
        }
        return YES;
    } withFailure:failure];
    [self.apiEngine httpPostRequest:urlString parameters:parameters bodyWithBlock:nil finished:finishedBlock];
}

- (void)articleCreatByTitle:(NSString *)title
                 AndContent:(NSString *)content
                withSuccess:(void(^)(NSObject *article))success
                 andFailure:(defaultFailureBlock)failure{
    NSString * urlString = [[self.apiConfiguration create] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSDictionary *parameters = @{@"title":title,
                                 @"content":content
                                 };
    parameters = [self urlParametersDictionary:parameters];
    HTTPAPIFinishedBlock finishedBlock = [self customFinishedBlock:^BOOL(id resultObject) {
        NSInteger succeed = [resultObject[@"success"] integerValue];
        if (succeed) {
            success(@[]);
        }
        return YES;
    } withFailure:failure];
    [self.apiEngine httpPostRequest:urlString parameters:parameters bodyWithBlock:nil finished:finishedBlock];
}

@end
