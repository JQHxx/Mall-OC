//
//  DMNetworkTrafficManager.h
//  Mall
//
//  Created by midland on 2019/9/27.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DMNetworkLog;
@interface DMNetworkTrafficManager : NSObject

/** 所有 NSURLProtocol 对外设置接口，可以防止其他外来监控 NSURLProtocol */
@property (nonatomic, strong) NSArray *protocolClasses;


/** 单例 */
+ (DMNetworkTrafficManager *)manager;

/** 通过 protocolClasses 启动流量监控模块 */
+ (void)startWithProtocolClasses:(NSArray *)protocolClasses;
/** 仅以 DMURLProtocol 启动流量监控模块 */
+ (void)start;
/** 停止流量监控 */
+ (void)end;

@end
