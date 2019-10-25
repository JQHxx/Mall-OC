//
//  TargetProxy.h
//  Mall
//
//  Created by midland on 2019/10/16.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 用于解决Timer循环引用的问题
 */
@interface TargetProxy : NSProxy

+ (instancetype)proxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
