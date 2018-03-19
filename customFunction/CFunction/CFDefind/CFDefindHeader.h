//
//  CFDefindHeader.h
//  customFunction
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#ifndef CFDefindHeader_h
#define CFDefindHeader_h

#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;

#define CFException(class,reasion) @throw [NSException exceptionWithName:class reason:reasion userInfo:nil];



#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

#endif /* CFDefindHeader_h */
