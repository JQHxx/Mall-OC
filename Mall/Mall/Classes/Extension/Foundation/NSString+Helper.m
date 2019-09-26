//
//  NSString+Helper.m
//  Mall
//
//  Created by midland on 2019/8/27.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "NSString+Helper.h"

@implementation NSString (Helper)

#pragma mark 清空字符串中的空白字符
- (NSString *)trimString
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark 是否空字符串
- (BOOL)isEmptyString
{
    return (self.length == 0);
}

/**
 判断接口返回的数据 是否存在null
 */
- (Boolean) isEmptyOrNull {
    if (!self) {
        return YES;
    } else if ([self isEqual:[NSNull null]]) {
        return YES;
    } else {
        NSString *trimedString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([trimedString length] == 0) {
            return YES;
        } else {
            return NO;
        }
    }
}

/**
 截取字符串
 
 begin: 开始位置
 end: 结束位置
 */
- (NSString *) substringFromIndex:(int)begin endIndex:(int)end {
    if (end <= begin) {
        return @"";
    }
    NSRange range = NSMakeRange(begin, end - begin);
    return  [self substringWithRange:range];
}

/**
 去除" "字符串
 */
- (NSString *)trim {
    NSString *temp = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableString *string = [temp mutableCopy];
    CFStringTrimWhitespace((CFMutableStringRef)string);
    NSString *result = [string copy];
    return result;
}

@end
