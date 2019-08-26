//
//  HttpRequest.h
//  Mall
//
//  Created by midland on 2019/8/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id result);
typedef void(^FailureBlock)(NSString *result);

@class BaseRequest;
@interface HttpRequest : NSObject

+ (instancetype) shareRequest;

/**
 * common request
 */
- (void) sendRequest:(BaseRequest *) request
             success: (SuccessBlock) successBlock
             failure: (FailureBlock) failureBlock;

/**
 * upload file
 */
- (void) uploadRequest:(BaseRequest *) request
               success: (SuccessBlock) successBlock
               failure: (FailureBlock) failureBlock;

@end

