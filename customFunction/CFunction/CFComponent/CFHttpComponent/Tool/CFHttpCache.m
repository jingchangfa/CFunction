//
//  CFHttpCache.m
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//
#import "CFHttpCache.h"
#import "NSString+CFEncryption.h"
#import "CFDefindHeader.h"

@implementation CFHttpCache
+ (void)CFHttpCacheSaveResponseObject:(id)responseObject
                      ByHttpAPIString:(NSString *)apiString
                  AndHttpApiParametes:(NSDictionary *)parameters{
    // 这个放在子线程就OK了
    @WeakObj(self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *filePath = [selfWeak getFilePathByHttpAPIString:apiString AndHttpApiParametes:parameters];
        [NSKeyedArchiver archiveRootObject:responseObject toFile:filePath];
    });
}


+ (id)CFHttpCacheGetDictionaryByHttpAPIString:(NSString *)apiString
                          AndHttpApiParametes:(NSDictionary *)parameters{
    NSString *filePath = [self getFilePathByHttpAPIString:apiString AndHttpApiParametes:parameters];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}


+ (void)CFHttpCacheCleanAll{
    NSString *floadPath = [self CFModelCacheFolderPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    [fileManager removeItemAtPath:floadPath error:&error];
    if (error) {
        NSLog(@"删除缓存失败 CFHttpCacheCleanAll error = %@",error);
    }
}


#pragma mark 辅助方法
// 获取完整的路径
+ (NSString *)getFilePathByHttpAPIString:(NSString *)apiString AndHttpApiParametes:(NSDictionary *)parameters{
    NSString *fileName = [self getFileNameByHttpAPIString:apiString AndHttpApiParametes:parameters];
    return [NSString stringWithFormat:@"%@/%@",[self CFModelCacheFolderPath],fileName];
}

// 缓存文件夹的路径
+ (NSString *)CFModelCacheFolderPath{
    return [self getFilePathByFolderName:@"maya_http_model_cache"];
}
+ (NSString *)getFilePathByFolderName:(NSString *)folderName{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                  NSUserDomainMask,
                                                                  YES) objectAtIndex:0];
    NSString *folderPath = [documentPath stringByAppendingPathComponent:folderName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:folderPath]) return folderPath;
    [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    return folderPath;
}
// 缓存url生成的文件名
+ (NSString *)getFileNameByHttpAPIString:(NSString *)apiString AndHttpApiParametes:(NSDictionary *)parameters{
    // 完整的api
    if (parameters) {
        NSArray *allKeyArray = parameters.allKeys;
        allKeyArray = [allKeyArray sortedArrayUsingComparator:^NSComparisonResult(NSString *  _Nonnull obj1, NSString *  _Nonnull obj2) {
            return [obj1 compare:obj2];
        }];
        NSMutableString *parametersString = @"".mutableCopy;
        for (NSString *key in allKeyArray) {
            [parametersString appendString:key];
            [parametersString appendFormat:@"%@",parameters[key]];
        }
        apiString = [apiString stringByAppendingString:parametersString];
    }
    NSString *fileName = [NSString stringWithFormat:@"%@.json",[NSString sha1:apiString]];
    return fileName;
}

@end
