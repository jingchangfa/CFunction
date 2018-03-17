//
//  CFHttpEngine.h
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
/** AFNetworking引擎类 **/
typedef void (^HTTPAPIFinishedBlock) (id resultObject, NSError * error);
typedef void (^DownloadFileFinishedBlock) (NSURL * filePathURL, NSError * error);
typedef void (^DownLoadProgressBlock) (NSProgress * progress);

@interface CFHttpEngine : NSObject
@property (nonatomic,assign) BOOL isUseCache;// 是否启用缓存，默认NO
@property (nonatomic, readonly) AFNetworkReachabilityStatus currentStatus;

+ (NSDictionary *)errorToDictionaryWithError:(NSError *)error;

// GET 请求
- (void)httpGetRequest:(NSString *)urlString
              finished:(HTTPAPIFinishedBlock)finished;


// POST 请求
- (void)httpPostRequest:(NSString *)urlString
             parameters:(NSDictionary *)parameters
          bodyWithBlock:(void(^)(id<AFMultipartFormData>))block
               finished:(HTTPAPIFinishedBlock)finished;


// POST 上传数据到服务器，bodyWithBlock 参数内拼接要上传的内容
- (void)httpPostRequest:(NSString *)urlString
             parameters:(NSDictionary *)parameters
               progress:(DownLoadProgressBlock)progress
          bodyWithBlock:(void (^)(id<AFMultipartFormData>))block
               finished:(HTTPAPIFinishedBlock)finished;

// 下载文件到本地，urlString 为下载地址，toPath 为本地存储路径（含文件名），finished block中，如果成功，返回最终文件保存的地址
- (void)downLoadFile:(NSString *)urlString
              toPath:(NSString *)toPath
            progress:(DownLoadProgressBlock)progress
            finished:(DownloadFileFinishedBlock)finished;

// 取消当前请求
- (void)cancelRequest;

// 取消全部请求
- (void)cancelAllRequest;

@end
