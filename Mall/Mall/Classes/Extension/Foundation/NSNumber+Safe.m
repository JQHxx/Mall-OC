//
//  NSNumber+Safe.m
//  OFweekPhone
//
//  Created by OFweek01 on 2020/1/18.
//  Copyright © 2020 wayne. All rights reserved.
//

#import "NSNumber+Safe.h"

@implementation NSNumber (Safe)

/// 修复崩溃： -[__NSCFNumber isEqualToString:]: unrecognized selector sent to instance 0x7c2680b0
/// 判断是否相等
- (BOOL)isEqualToString:(NSString *)str {
    NSString *newStr = [NSString stringWithFormat:@"%@",self];
    if ([newStr isEqualToString:str]) {
        return YES;
    }
    return NO;
}

@end
