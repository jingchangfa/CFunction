//
//  CFFMDBModelToSQL.h
//  customFunction
//
//  Created by jing on 2018/3/17.
//  Copyright © 2018年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CFFMDBModelProtocol.h"

@interface CFFMDBModelToSQL : NSObject
- (instancetype)initWithModel:(NSObject<CFFMDBModelProtocol> *)model;
@property (nonatomic,readonly)NSObject<CFFMDBModelProtocol> *model;
@property (nonatomic,readonly)NSDictionary *mineModelDictionary;
@property (nonatomic,readonly)NSArray<NSDictionary *> *propertyDictionaryArray;
@end
/**
 //{
 //    propertyType = CeShiPeople;
 //    propertyModelMainKey = ID;
 //    propertyValue =     (
 //                         {
 //                             propertyName = dogs;
 //                             propertyType = "T@\"NSArray\",&,N,V_dogs";
 //                             propertyValue = "[\n  11,\n  11,\n  11\n]";
 //                             sqlType = TEXT;
 //                         },
 //                         {
 //                             propertyName = ID;
 //                             propertyType = "T@\"NSNumber\",&,N,V_ID";
 //                             propertyValue = 11;
 //                             sqlType = REAL;
 //                         },
 //                         {
 //                             propertyName = car;
 //                             propertyType = "T@\"CeShiCar\",&,N,V_car";
 //                             propertyValue = 11;
 //                             sqlType = REAL;
 //                         },
 //                         {
 //                             propertyName = name;
 //                             propertyType = "T@\"NSString\",&,N,V_name";
 //                             propertyValue = "";
 //                             sqlType = TEXT;
 //                         }
 //                         );
 //}
 */
