//
//  HttpRequest.h
//  Mall
//
//  Created by midland on 2019/8/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id result, BOOL isCache);
typedef void(^FailureBlock)(NSError *error);
typedef void(^ProgressBlock)(NSProgress *progress);

@class IBaseRequest;
@interface IHttpRequest : NSObject

+ (instancetype) shareRequest;

/**
 * request
 */
- (NSURLSessionDataTask *) sendRequest: (IBaseRequest *) request
                              progress: (ProgressBlock) progressBlock
                               success: (SuccessBlock) successBlock
                               failure: (FailureBlock) failureBlock;


@end

