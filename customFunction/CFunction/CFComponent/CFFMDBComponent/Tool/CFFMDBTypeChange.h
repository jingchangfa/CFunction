//
//  CFFMDBTypeChange.h
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
/** SQLite五种数据类型 */
#define SQLTEXT     @"TEXT"
#define SQLINTEGER  @"INTEGER"
#define SQLREAL     @"REAL"
#define SQLBLOB     @"BLOB"
#define SQLNULL     @"NULL"

// 数据库数据类型与objectc数据类型转化的工具类
@interface CFFMDBTypeChange : NSObject
// model类型 -> sql类型
+ (NSString *)sqlTypeStringByPropertyTypeString:(NSString *)propertyType;
@end
