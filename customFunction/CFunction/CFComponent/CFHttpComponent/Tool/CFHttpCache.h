//
//  CFHttpCache.h
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
/** AFNetworking 缓存类 **/

@interface CFHttpCache : NSObject

+ (void)CFHttpCacheSaveResponseObject:(id)responseObject
                        ByHttpAPIString:(NSString *)apiString
                    AndHttpApiParametes:(NSDictionary *)parameters;


+ (id)CFHttpCacheGetDictionaryByHttpAPIString:(NSString *)apiString
                            AndHttpApiParametes:(NSDictionary *)parameters;


+ (void)CFHttpCacheCleanAll;

@end
