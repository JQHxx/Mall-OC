//
//  HttpRequest.h
//  Mall
//
//  Created by midland on 2019/8/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^SuccessBlock)(id result, BOOL isCache);
typedef void(^FailureBlock)(NSError *error);
typedef void(^ProgressBlock)(NSProgress *progress);

@class IBaseRequest;
@interface IHttpRequest : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *manager;

+ (instancetype) shareRequest;

// 是否有网络
- (BOOL) isHasNetWork;

/**
 * @brief request
 * @param progressBlock progress callback
 * @param successBlock success callback
 * @param failureBlock failure callback
 */
- (NSURLSessionDataTask *) sendRequest: (IBaseRequest *) request
                              progress: (ProgressBlock) progressBlock
                               success: (SuccessBlock) successBlock
                               failure: (FailureBlock) failureBlock;


@end

