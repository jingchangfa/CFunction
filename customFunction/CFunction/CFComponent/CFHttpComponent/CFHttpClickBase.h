//
//  CFHttpClickBase.h
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CFHttpEngine.h"
#import "CFHttpCache.h"
#import "CFHttpConfiguration+CFClildrenConfig.h" // children 使用的api
typedef void (^defaultFailureBlock)(NSInteger errorCode, NSString * errorMsg);

@interface CFHttpClickBase : NSObject
@property (nonatomic, strong, readonly) CFHttpEngine * apiEngine;
@property (nonatomic, strong, readonly) CFHttpConfiguration * apiConfiguration;
+ (instancetype)client;
+ (void)cleanCache;
# pragma mark 子类调用的方法
// 添加公有字段(eg:token user_id等)
- (NSMutableDictionary *)urlParametersDictionary:(NSDictionary *)parametersDictionary;


- (HTTPAPIFinishedBlock)customFinishedBlock:(BOOL(^)(id resultObject))customBlock
                                withFailure:(defaultFailureBlock)failure;

- (DownloadFileFinishedBlock)customDownloadFinishedBlock:(BOOL (^)(NSURL * filePathURL))customHandler
                                             withFailure:(defaultFailureBlock)failure;
@end
