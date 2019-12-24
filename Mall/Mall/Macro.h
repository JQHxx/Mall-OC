//
//  Macro.h
//  Mall
//
//  Created by midland on 2019/8/27.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

//状态栏高度
#define STATUSBAR_HEIGHT  [[UIApplication sharedApplication] statusBarFrame].size.height
#define NAVBAR_HEIGHT 44.0
#define BOTTOM_BAR_HEIGHT 34.0

// 设备屏幕的大小
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define KEYCHAIN_IDENTIFIER(a) ([NSString stringWithFormat:@"%@_%@",[[NSBundle mainBundle] bundleIdentifier],a])

//#define WeakObj(o) try{}@finally{} __weak typeof(o) o##Weak = o;
//#define StrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

#pragma mark - 引用相关
#define WEAK_SELF __weak __typeof(self) weakSelf = self;
#define STRONG_SELF __unused __strong __typeof(weakSelf) self = weakSelf;

#endif /* Macro_h */

/*
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
//过期的方法
#pragma clang diagnostic pop
 */

