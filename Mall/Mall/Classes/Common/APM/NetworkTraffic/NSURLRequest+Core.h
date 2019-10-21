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

- (NSUInteger)dgm_getLineLength;
- (NSUInteger)dgm_getHeadersLengthWithCookie;
- (NSDictionary<NSString *, NSString *> *)dgm_getCookies;
- (NSUInteger)dgm_getBodyLength;


@end

NS_ASSUME_NONNULL_END
