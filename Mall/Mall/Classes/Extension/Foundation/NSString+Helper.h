//
//  NSString+Helper.h
//  Mall
//
//  Created by midland on 2019/8/27.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helper)

/**
 *  清空字符串中的空白字符
 *
 *  @return 清空空白字符串之后的字符串
 */
- (NSString *)trimString;

/**
 *  是否空字符串
 *
 *  @return 如果字符串为nil或者长度为0返回YES
 */
- (BOOL)isEmptyString;
    
/**
 判断接口返回的数据 是否存在null
 */
- (Boolean) isEmptyOrNull;
    
/**
 截取字符串
 
 begin: 开始位置
 end: 结束位置
 */
- (NSString *) substringFromIndex:(int)begin endIndex:(int)end;
    
/**
 去除" "字符串
 */
- (NSString *)trim;

// 将阿拉伯数字转换为大写
- (NSString *)convertAmount;

/**
 wct20190716 字符串指定位置替换为*

 @param range 密文展示的字符位置 range值第一个参数是第几位开始展示*，第二个参数是展示*的字符个数
 @return 处理后返回值
 */
- (NSString *)numberSuitScanfRange:(NSRange)range;

// 金额： 如 1000000 => 1,000,000.00
- (NSString*)positiveFormat;

@end

