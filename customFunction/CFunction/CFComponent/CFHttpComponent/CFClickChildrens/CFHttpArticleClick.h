//
//  CFHttpArticleClick.h
//  New_Maya
//
//  Created by jing on 2018/3/20.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "CFHttpClickBase.h"

@interface CFHttpArticleClick : CFHttpClickBase
- (void)articleListByOffset:(int)offset
                   AndLimit:(int)limit
                withSuccess:(void(^)(NSArray *articleArray))success
                 andFailure:(defaultFailureBlock)failure;
- (void)articleCreatByTitle:(NSString *)title
                 AndContent:(NSString *)content
                withSuccess:(void(^)(NSObject *article))success
                 andFailure:(defaultFailureBlock)failure;
@end
