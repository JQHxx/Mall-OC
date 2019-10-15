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

#define WeakSelf(type) autoreleasepool{} __weak __typeof__(type) weakSelf = type;
#define StrongSelf(type) autoreleasepool{} __strong __typeof__(type) strongSelf = type;

#endif /* Macro_h */

