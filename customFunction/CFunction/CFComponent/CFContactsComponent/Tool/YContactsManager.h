//
//  YContactsManager.h
//  YAddressBookDemo
//
//  Created by YueWen on 16/5/6.
//  Copyright © 2016年 YueWen. All rights reserved.
//

#import <Foundation/Foundation.h>


@class YContactObject;



NS_ASSUME_NONNULL_BEGIN

/**
 *  请求通讯录所有联系人的Manager
 */
@interface YContactsManager : NSObject

/**
 *  YAddressBookManager单例
 */
+(instancetype)shareInstance;


/**
 *  请求所有的联系人,按照添加人的时间顺序
 *
 *  @param completeBlock 完成的回调
 */
- (void)requestContactsComplete:(void (^)(NSArray <YContactObject *> *))completeBlock;

/**
 * 通过ischange 来储存通讯录是否变化  变化 才给后台
 * 经过测试发现  若app 未启动 则监测不到通讯录的变化  所以用 fmdb 持久化通讯录 通过比对上传新添加的吧
 * 处理放到 kapcontansmanager
 **/
/**
 * alert show
 */
@property (nonatomic,copy)void(^alertShowBlcok)();
- (void)setAlertShowBlcok:(void (^ _Nonnull)())alertShowBlcok;
@end


NS_ASSUME_NONNULL_END


