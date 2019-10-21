//
//  DMURLProtocol.h
//  Mall
//
//  Created by midland on 2019/9/27.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMURLProtocol : NSURLProtocol

/** 开启网络请求拦截 */
+ (void)start;
/** 停止网络请求拦截 */
+ (void)end;

@end
