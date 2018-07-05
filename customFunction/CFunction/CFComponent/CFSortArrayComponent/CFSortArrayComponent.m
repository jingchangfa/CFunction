//
//  CFSortArrayComponent.m
//  customFunction
//
//  Created by jing on 2018/7/3.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFSortArrayComponent.h"
@interface CFSortArrayComponent ()
@property (nonatomic,strong)NSString *pinYin;
@property (nonatomic,strong)NSObject *sortModel;
@end

@implementation CFSortArrayComponent
+(void)modelArrayWithArray:(NSArray *)modelsArray
           AndSortModelKey:(NSString *)sortKey
              AndSortBlock:(void(^)(NSArray *suoYinArray,NSArray *sortModelArray))block{
    NSMutableArray *shouZiMuArray = [NSMutableArray array];
    NSMutableArray *ModelArray = [NSMutableArray array];
    NSMutableArray *item = [NSMutableArray array];
    
    NSMutableArray *paiXuArray = [self DaHengUserPaiXuArray:modelsArray AndSortKey:sortKey];
    NSString *tempString ;
    for (CFSortArrayComponent *paiXu in paiXuArray)
    {
        NSString *pinyin = paiXu.pinYin;
        //不同
        if(![tempString isEqualToString:pinyin])
        {
            [shouZiMuArray addObject:pinyin];
            //分组
            item = [NSMutableArray array];
            [item addObject:paiXu.sortModel];
            [ModelArray addObject:item];
            tempString = pinyin;
        }else{
            [item addObject:paiXu.sortModel];
        }
    }
    block(shouZiMuArray,ModelArray);
}
#pragma mark 获取字符串中文字的拼音首字母并与model共同存放 并排序
+ (NSMutableArray *)DaHengUserPaiXuArray:(NSArray *)modelsArray
                              AndSortKey:(NSString *)sortKey{
    NSMutableArray *paiXuArray=[NSMutableArray array];
    NSString *shuZiregex = @"^\\d";
    NSRegularExpression * regex = [[NSRegularExpression alloc]initWithPattern:shuZiregex options:0 error:nil];
    for (NSObject *model in modelsArray) {
        CFSortArrayComponent *paiXu=[[CFSortArrayComponent alloc]init];
        paiXu.sortModel = model;
        NSString *nameString = [self RemoveSpecialCharacter:[model valueForKey:sortKey]];
        NSMutableString *suoyinString = [nameString mutableCopy];
        CFStringTransform((__bridge CFMutableStringRef)suoyinString, NULL, kCFStringTransformToLatin, NO);//转换成拼音
        CFStringTransform((__bridge CFMutableStringRef)suoyinString, NULL, kCFStringTransformStripDiacritics, NO);//去掉音标
        paiXu.pinYin = !!(((NSArray *)[regex matchesInString:suoyinString options:0 range:NSMakeRange(0, suoyinString.length)]).count>0)?@"#":[[NSString stringWithFormat:@"%c",[suoyinString characterAtIndex:0]] capitalizedString];
        [paiXuArray addObject:paiXu];
    }
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
    [paiXuArray sortUsingDescriptors:sortDescriptors];
    return paiXuArray;
}
#pragma mark 辅助
+(NSString*)RemoveSpecialCharacter: (NSString *)string {
    if (!string) {
        return @"###";
    }
    NSString *newString = [NSString stringWithString:string];
    //去除两端空格和回车
    newString = [newString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //过滤指定字符串
    NSRange urgentRange = [newString rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @",.？、~￥#&<>《》()[]{}【】^@/￡¤|§¨「」『』￠￢￣~@#&*（）——+|《》$_€"]];
    while (urgentRange.location != NSNotFound) {
        newString = [newString stringByReplacingCharactersInRange:urgentRange withString:@""];
        urgentRange = [newString rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @",.？、~￥#&<>《》()[]{}【】^@/￡¤|§¨「」『』￠￢￣~@#&*（）——+|《》$_€"]];
    }
    return newString;
}
@end
