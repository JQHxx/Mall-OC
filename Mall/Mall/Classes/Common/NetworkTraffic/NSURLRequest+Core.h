//
//  NSURLRequest+Core.h
//  Mall
//
//  Created by midland on 2019/9/27.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURLRequest (Core)

- (NSUInteger)dm_getLineLength;

/**
 通过 httpResponse.allHeaderFields 拿到 Header 字典，再拼接成报文的 key: value 格式，转换成 NSData 计算大小
 */
- (NSUInteger)dm_getHeadersLength;

- (NSUInteger)dgm_getHeadersLengthWithCookie;

- (NSUInteger)dgm_getBodyLength;


@end

NS_ASSUME_NONNULL_END
