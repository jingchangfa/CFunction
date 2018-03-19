//
//  CFFMDBConfiguration.m
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//
#import "CFFMDBConfig.h"
#import "CFFMDBConfiguration.h"

@implementation CFFMDBConfiguration
+ (NSString *)CompletePathByToken:(NSString *)token{
    NSString *pathString = [self SQLPath];
    NSString *nameString = [self SQLLibNameByToken:token];
    pathString = [pathString stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",nameString]];
    return pathString;
}

+ (NSString *)SQLPath{
    NSString *pathString = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    pathString = [pathString stringByAppendingPathComponent:[CFFMDBConfig theCompanyName]];//用公司名比较好
    return pathString;
}
+ (NSString *)SQLLibNameByToken:(NSString *)token{
    NSString *nameString = [NSString stringWithFormat:@"%@%@.sqlite",[CFFMDBConfig theProjectName],token];
    return nameString;
}

//dic json 转化
+ (NSString *)dictionaryToJSONString:(NSDictionary *)dictionary{
    return [self toJson:dictionary];
}
+ (NSString *)arrayToJSONString:(NSArray *)array{
    return [self toJson:array];
}
+ (NSString *)toJson:(id)obj{
    if (![NSJSONSerialization isValidJSONObject:obj]){
        return nil;
    }
    NSError *err = nil;
    NSData *stringData =
    [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&err];
    if (err) {
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    return jsonString;
}
+ (NSDictionary *)jsonStringToDictionary:(NSString *)jsonString{
    return [self jsonToObj:jsonString];
}
+ (NSArray *)jsonStringToArray:(NSString *)jsonString{
    return [self jsonToObj:jsonString];
}
+ (id)jsonToObj:(NSString *)jsonString{
    if (![[jsonString class]isSubclassOfClass:[NSString class]]) {
        return nil;
    }
    NSError *err;
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    id obj;
    if (jsonData) {
        obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    }
    if (err) {
        return nil;
    }
    return obj;
}
@end
