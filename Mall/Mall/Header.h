//
//  Header.h
//  Mall
//
//  Created by midland on 2019/10/11.
//  Copyright © 2019 JQHxx. All rights reserved.
//

// 只会在OC的代码中被引用
#ifdef __OBJC__
#import <Foundation/Foundation.h>
#endif

#pragma mark - 通用
#import "Macro.h"
#import "Network.h"
#import "Config.h"
#import "Common.h"
#import "StoryBoardNameUtil.h"
#import "BFLayoutConstraint.h"
#import "JSONUtil.h"

#pragma mark - Extension
#import "Extension.h"
#import "UIViewController+Swizzle.h"

#pragma mark - 第三方
#import "UIImageView+SDWebImage.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "PureLayout.h"
#import "MBProgressHUD.h"
#import <CocoaLumberjack.h>
#import "UIViewController+HUD.h"
#import "BLStopwatch.h"
#import "UIScrollView+MJ.h"

#pragma mark - 埋点
// 可参考：https://github.com/lanjiaoli/Objc_-Thread/tree/master/Runtime_HookLog
// https://github.com/wanqingrongruo/HookCollection
#import "UIViewController+Logger.h"
#import "UITableView+Logger.h"
#import "UICollectionView+Logger.h"
#import "UIGestureRecognizer+Logger.h"
#import "UIControl+Logger.h"
#import "UIView+Logger.h"

#pragma mark - 其他
#ifdef DEBUG
// 如果要禁止
// #define NULLSAFE_ENABLED 0
#endif

#ifndef __OPTIMIZE__

#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}

#endif



//
#ifdef DEBUG
#define MYLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define MYLog(format, ...)
#endif

// 适配iOS 11 scrollView
#define  adjustsScrollViewInsets_NO(scrollView)\
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"") \
if (@available(iOS 11.0,*))  {\
scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;\
} else {\
self.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \

#define  adjustsTableViewInsets_NO(scrollView)\
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"") \
if (@available(iOS 11.0,*))  {\
scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;\
} else {\
self.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \

// 主线程异步执行
#define dispatch_main_sync_safe(block)\
    if ([NSThread isMainThread]) {\
        block();\
    } else {\
        dispatch_sync(dispatch_get_main_queue(), block);\
    }

// 主线程同步执行
#define dispatch_main_async_safe(block)\
    if ([NSThread isMainThread]) {\
        block();\
    } else {\
        dispatch_async(dispatch_get_main_queue(), block);\
    }


// 去除警告 https://www.jianshu.com/p/cbe9f21cee81

//定义并导入CoCoaLumberJack框架
#define LOG_LEVEL_DEF ddLogLevel
//通过DEBUG模式设置全局日志等级，DEBUG时为Verbose，所有日志信息都可以打印，否则Error，只打印
#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelError;
#endif
