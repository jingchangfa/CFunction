//
//  CFDefindHeader.h
//  customFunction
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#ifndef CFDefindHeader_h
#define CFDefindHeader_h
// 循环引用
#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define StrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

// 颜色
#define CF_CUSTUM_COLOR(y) [UIColor colorWithRed:((float)((y  & 0xFF0000) >> 16))/255.0 green:((float)((y  & 0xFF00) >> 8))/255.0 blue:((float)(y  & 0xFF))/255.0 alpha:1.0]  //custumcolor输入对应的色值

// 语言国际化
#define CF_LocalizedString(key) NSLocalizedString(@#key, nil)

// 尺寸
#define CF_SCREEN_HEIGHT  ([UIScreen mainScreen].bounds.size.height)
#define CF_SCREEN_WIDTH   ([UIScreen mainScreen].bounds.size.width)
#define CF_SIZE_SCREEN_HEIGHT    (CF_SCREEN_HEIGHT/667)
#define CF_SIZE_SCREEN_WIDTH     (CF_SCREEN_WIDTH/375)
#define CF_BitMap_BY_SIZE(height) (((height)/2.0f)*CF_SIZE_SCREEN_WIDTH)//像素为单位

#define IS_IPHONEX (([[UIScreen mainScreen] bounds].size.height - 812) ? NO : YES)
#define CF_NAV_VIEW_OFFSET ((IS_IPHONEX) ? (44) : (20))
#define CF_TAB_HEIGHT      ((IS_IPHONEX) ? (83) : (49))
#define CF_NAV_HEIGHT      (44)
// 懒加载
#pragma mark  - ========== 懒加载  ================
#ifndef CF_LazyLoading
#define CF_LazyLoading(_type_, _ivar_) \
- (_type_ *)_ivar_ { \
if (! _##_ivar_) { \
_##_ivar_ = [[_type_ alloc] init]; \
} \
return _##_ivar_; \
}
#endif

#ifndef CF_LazyLoadingBlock
#define CF_LazyLoadingBlock(_type_, _ivar_ ,block) \
- (_type_ *)_ivar_{\
void(^initBlock)(_type_ *_ivar_) = ^(_type_ *_ivar_) block;\
if (!_##_ivar_) {\
_type_ *_ivar_ = [[_type_ alloc] init];\
_##_ivar_ = _ivar_;\
initBlock(_ivar_);\
}\
return _##_ivar_;\
}
#endif

// 单利
#pragma mark  - ========== 单利  ================
#define CF_SimpleH(className)\
+ (className *)shared##className;


#define CF_SimpleM(className) \
static className *_instance = nil ; \
+ (className *)shared##className \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}\
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
- (id)copyWithZone:(NSZone *)zone{\
return _instance;\
}

// 调试
#define Debug_BaseViewControllerCreated(str) [[NSClassFromString(str) alloc] init]
#define CF_Exception(class,reasion) @throw [NSException exceptionWithName:class reason:reasion userInfo:nil];

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

#endif /* CFDefindHeader_h */
