//
//  HttpRequest.m
//  Mall
//
//  Created by midland on 2019/8/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "HttpRequest.h"
#import "BaseRequest.h"

@interface HttpRequest()


@end

@implementation HttpRequest
static HttpRequest *_instance = nil;

+ (instancetype)shareRequest {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[HttpRequest alloc]init];
    });
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

/**
 * GET/POST request
 */
- (void) sendRequest:(BaseRequest *) request
             success: (SuccessBlock) successBlock
             failure: (FailureBlock) failureBlock {
    switch (request.requestType) {
        case RequestTypeGET:
            [self getRequest:request success:successBlock failure:failureBlock];
            break;
        case RequestTypePOST:
            [self postRequest:request success:successBlock failure:failureBlock];
            break;
        case RequestTypeUpload:
            break;
    }
    
}

/**
 * UPLOAD request
 */
- (void) uploadRequest:(BaseRequest *)request
               success:(SuccessBlock)successBlock
               failure:(FailureBlock)failureBlock {
    
}

#pragma mark: - private methdos
- (void)getRequest:(BaseRequest *) request
           success: (SuccessBlock) successBlock
           failure: (FailureBlock) failureBlock {
    
}

- (void)postRequest:(BaseRequest *) request
           success: (SuccessBlock) successBlock
           failure: (FailureBlock) failureBlock {
    
}




@end
