//
//  CFFMDBSQLToModel.h
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CFFMDBModelProtocol.h"
#import "CFFMDBBlockHeader.h"
@interface CFFMDBSQLToModel : NSObject
/**
 * 初始化
 * 生成条件检索的infoDictionary
 */
- (instancetype)initWithModelClass:(Class)modelClass;
@property(nonatomic,readonly)Class modelClass;
+ (NSDictionary *)infoDictionaryByValue:(id)value AndClass:(Class)modelClass;
- (void)enumPropertyWithEnumBlcok:(CFGetModelValueBlock)block;
/**
 * enumModelArrayPropertyEnumBlock 有嵌套的model数组属性
 * enumModelPropertyEnumBlock 有嵌套的model属性
 */
- (void)enumModelArrayPropertyEnumBlock:(CFGetPropertyModelBlock)block;
- (void)enumModelPropertyEnumBlock:(CFGetPropertyModelBlock)block;
@end
