//
//  UIColor+CustomDynamicColor.h
//  Mall
//
//  Created by midland on 2019/10/15.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (DarkMode)

/**
暗景模式 传入RGBColor 或者 UIColor
*/
+ (UIColor *)adaptColor:(UIColor *)color darkColor:(UIColor *)darkColor;

/**
 暗景模式 16进制  默认 alpha=1
 */
+ (UIColor *)adaptHexColor:(NSString *)hexColor darkColor:(NSString *)hexDarkColor;

/**
 暗景模式 16进制  自定义alpha
 */
+ (UIColor *)adaptHexColor:(NSString *)hexColor darkColor:(NSString *)hexDarkColor alpha:(CGFloat)alpha;

/// 16进制颜色转UIColor
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;


@end

NS_ASSUME_NONNULL_END
