//
//  NSNumber+Safe.h
//  OFweekPhone
//
//  Created by OFweek01 on 2020/1/18.
//  Copyright © 2020 wayne. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (Safe)

/// 修复崩溃： -[__NSCFNumber isEqualToString:]: unrecognized selector sent to instance 0x7c2680b0
/// 判断字符串是否相等
- (BOOL)isEqualToString:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
