//
//  CFHttpEngine.m
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFHttpEngine.h"
#import "HMFJSONResponseSerializerWithData.h"
#import "CFHttpCache.h"
#import "CFDefindHeader.h"


@interface CFHttpEngine ()
@property (nonatomic, strong) NSURLSessionTask * sessionTask;
@end

@implementation CFHttpEngine
#pragma mark 对外公开的方法
static AFNetworkReachabilityStatus staticStatus = AFNetworkReachabilityStatusUnknown;
+ (void)load{
    AFNetworkReachabilityManager *networkManager = [AFNetworkReachabilityManager sharedManager];
    [networkManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        staticStatus = status;
    }];
    [networkManager startMonitoring];
}
- (AFNetworkReachabilityStatus)currentStatus{
    return staticStatus;
}

+ (NSDictionary *)errorToDictionaryWithError:(NSError *)error{
    if (!error) return nil;
    NSString *errorString = error.userInfo[@"body"];
    NSData *jsonData = [errorString dataUsingEncoding:NSUTF8StringEncoding];
    id obj;
    if (jsonData) {
        NSError *err;
        obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    }
    return obj;
}

- (void)httpGetRequest:(NSString *)urlString
              finished:(HTTPAPIFinishedBlock)finished{
    NSLog(@"链接:\n%@",urlString);
    [self createdRequestSerializerByparameters:nil AndIsUpLoad:NO];
    self.sessionTask =
    [[self manager] GET:urlString parameters:nil progress:NULL success:^(NSURLSessionDataTask *  task, id responseObject) {
        finished(responseObject, nil);
        [self SaveModelCacheByRequest:urlString parameters:nil AndResponseObject:responseObject];// 缓存
        NSLog(@"结果：%@",responseObject);
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        NSLog(@"结果：: %@",error);
        finished(nil, error);
        [self loadCacheByRequest:urlString Parameters:nil AndFinished:finished];
    }];
}


- (void)httpPostRequest:(NSString *)urlString
             parameters:(NSDictionary *)parameters
          bodyWithBlock:(void(^)(id<AFMultipartFormData>))block
               finished:(HTTPAPIFinishedBlock)finished{
    NSLog(@"链接:\n%@\n参数:\n%@",urlString,parameters);
    if (!block)
    {
        [self createdRequestSerializerByparameters:parameters AndIsUpLoad:NO];
        self.sessionTask =
        [[self manager] POST:urlString parameters:parameters progress:NULL success:^(NSURLSessionDataTask * task, id responseObject) {
            finished(responseObject, nil);
            
            [self SaveModelCacheByRequest:urlString parameters:parameters AndResponseObject:responseObject];
            NSLog(@"结果：%@",responseObject);
        } failure:^(NSURLSessionDataTask * task, NSError * error) {
            NSLog(@"结果：%@ %@",task,error);
            finished(nil, error);
            [self loadCacheByRequest:urlString Parameters:parameters AndFinished:finished];
        }];
    }
    else
    {
        [self createdRequestSerializerByparameters:parameters AndIsUpLoad:YES];
        self.sessionTask =
        [[self manager] POST:urlString parameters:parameters constructingBodyWithBlock:block progress:NULL success:^(NSURLSessionDataTask * task, id   responseObject) {
            finished(responseObject, nil);
            NSLog(@"结果：%@",responseObject);
        } failure:^(NSURLSessionDataTask * task, NSError * error) {
            NSLog(@"结果：%@ %@",task,error);
            finished(nil, error);
        }];
    }
}


- (void)httpPostRequest:(NSString *)urlString
             parameters:(NSDictionary *)parameters
               progress:(DownLoadProgressBlock)progress
          bodyWithBlock:(void (^)(id<AFMultipartFormData>))block
               finished:(HTTPAPIFinishedBlock)finished;{
    NSLog(@"链接:\n%@\n参数:\n%@",urlString,parameters);
    [self createdRequestSerializerByparameters:parameters AndIsUpLoad:YES];
    self.sessionTask =
    [[self manager] POST:urlString parameters:parameters constructingBodyWithBlock:block progress:^(NSProgress * _Nonnull uploadProgress){
        // This is not called back on the main queue.
        // You are responsible for dispatching to the main queue for UI updates
        if (progress)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                progress(uploadProgress);
            });
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finished(responseObject, nil);
        NSLog(@"结果：%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        finished(nil, error);
        NSLog(@"错误：%@",error);
    }];
}

- (void)downLoadFile:(NSString *)urlString
              toPath:(NSString *)toPath
            progress:(DownLoadProgressBlock)progress
            finished:(DownloadFileFinishedBlock)finished{
    NSLog(@"下载链接：\n%@\n本地路径:\n%@",urlString,toPath);
    NSURL * url = [NSURL URLWithString:urlString];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    self.sessionTask =
    [[self downloadManager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        // This is not called back on the main queue.
        // You are responsible for dispatching to the main queue for UI updates
        if (!progress)return ;
        dispatch_async(dispatch_get_main_queue(), ^{
            progress(downloadProgress);
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:toPath
                          isDirectory:NO];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"结果：%@", filePath);
        if (error)
        {
            finished(nil, error);
        }
        else
        {
            finished(filePath, nil);
        }
    }];
    [self.sessionTask resume];
}

- (void)cancelRequest{
    if (self.sessionTask)
    {
        [self.sessionTask cancel];
        self.sessionTask = nil;
    }
}

- (void)cancelAllRequest{
    [[self manager].operationQueue cancelAllOperations];
}

#pragma mark 辅助方法
- (void)loadCacheByRequest:(NSString *)urlString
                Parameters:(NSDictionary *)parameters
               AndFinished:(HTTPAPIFinishedBlock)finished{
    if(!self.isUseCache) return;// 不使用缓存
    self.isUseCache = NO;
    // 异步取本地缓存
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id responseObject = [CFHttpCache CFHttpCacheGetDictionaryByHttpAPIString:urlString AndHttpApiParametes:parameters];
        dispatch_async(dispatch_get_main_queue(), ^{
            finished(responseObject,nil);
        });
    });
}
- (void)SaveModelCacheByRequest:(NSString *)urlString
                     parameters:(NSDictionary *)parameters
              AndResponseObject:(id)responseObject{
    if(!responseObject) return;
    [CFHttpCache CFHttpCacheSaveResponseObject:responseObject ByHttpAPIString:urlString AndHttpApiParametes:parameters];
}
#pragma mark 初始化方法
// 设置请求头
- (void)createdRequestSerializerByparameters:(NSDictionary *)parameters
                                 AndIsUpLoad:(BOOL)isUpload{
    AFHTTPSessionManager *manager = [self manager];
    if (isUpload) {
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];//
    }else{
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    [manager.requestSerializer setTimeoutInterval:30];
//    // 设置请求头
//    if ([parameters.allKeys containsObject:@"token"]) {
//        NSString *token = parameters[@"token"];
//        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
//    }
//    [manager.requestSerializer setValue:@"APP" forHTTPHeaderField:@"X-MAYA-CLIENT"];
}


- (AFHTTPSessionManager *)manager{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        NSSet *set = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html", nil];
        set = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", nil];
        manager.responseSerializer.acceptableContentTypes = set;
        manager.responseSerializer = [HMFJSONResponseSerializerWithData serializer];
    });
    return manager;
}

- (AFURLSessionManager *)downloadManager{
    static AFURLSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    });
    return manager;
}

- (void)dealloc{
    [self cancelRequest];
}

@end
