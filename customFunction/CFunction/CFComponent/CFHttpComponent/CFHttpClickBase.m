//
//  CFHttpClickBase.m
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFHttpClickBase.h"
#import "CFHttpClickBase+CFClickBaseErrorConfig.h"

@implementation CFHttpClickBase
+ (instancetype)client{
    return [[[self class] alloc] init];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _apiEngine = [[CFHttpEngine alloc] init];
        _apiConfiguration = [CFHttpConfiguration defaultConfiguration];
    }
    return self;
}
+ (void)cleanCache{
    [CFHttpCache CFHttpCacheCleanAll];
}
# pragma mark 子类调用的方法
- (NSMutableDictionary *)urlParametersDictionary:(NSDictionary *)parametersDictionary{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSDictionary *publicWordBreaks = [self.apiConfiguration publicWordBreaks];
    if (publicWordBreaks) [dic setDictionary:publicWordBreaks];
    if (parametersDictionary) [dic addEntriesFromDictionary:parametersDictionary];
    return dic;
}


- (HTTPAPIFinishedBlock)customFinishedBlock:(BOOL(^)(id resultObject))customBlock
                                withFailure:(defaultFailureBlock)failure{
    return ^(id resultObject, NSError * error){
        // 网络错误
        if ([self handleNetworkError:error withFailure:failure]) return ;
        // 数据错误
        if (error && !resultObject) {
            resultObject = [CFHttpEngine errorToDictionaryWithError:error];
        }
        if ([self handleCommonErrorFromResponse:resultObject withFailure:failure]) return ;
        if (customBlock(resultObject)) return;
        failure(-1, @"后段返回数据不符合前端逻辑～");
    };
}

- (DownloadFileFinishedBlock)customDownloadFinishedBlock:(BOOL (^)(NSURL * filePathURL))customHandler
                                             withFailure:(defaultFailureBlock)failure{
    return ^void(NSURL * filePathURL, NSError * error) {
        if ([self handleNetworkError:error withFailure:failure]) return;
        if (customHandler(filePathURL))  return;
        failure(-1, @"后段返回数据不符合前端逻辑～");
    };
}

#pragma mark 辅助方法
- (BOOL)handleNetworkError:(NSError *)error withFailure:(defaultFailureBlock)failure{
    if (!error) return NO;
    NSInteger errorCode = error.code;
    NSString *msg = error.domain;
    [CFHttpClickBase NetworkErrorConfigByErrorCode:errorCode AndMes:msg];
    failure(errorCode,msg);
    return YES;
}
- (BOOL)handleCommonErrorFromResponse:(id)responseObject withFailure:(defaultFailureBlock)failure{
    if (!responseObject) return NO;
    BOOL success = [CFHttpConfiguration isRightResultByResult:responseObject];
    if (success) return NO;
    NSInteger errorCode = [CFHttpConfiguration resultErrorCodeByResult:responseObject];
    NSString *msg = [CFHttpConfiguration resultErrorMsgByResult:responseObject];
    [CFHttpClickBase ServerErrorConfigByErrorCode:errorCode AndMes:msg];
    failure(errorCode,msg);
    return YES;
}

@end
