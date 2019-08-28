//
//  HttpRequest.m
//  Mall
//
//  Created by midland on 2019/8/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "IHttpRequest.h"
#import "IBaseRequest.h"
#import "AFNetworking.h"
#import "IHttpCache.h"
#import "ICacheKey.h"
#import "IDataBase.h"
#import "IDataManager.h"

/*
const NSString *RequestTypesMap[] = {
    [RequestTypeGET] = @"GET",
    [RequestTypePOST] = @"POST",
    [RequestTypeUPLOAD] = @"UPLOAD",
};
 */

@interface IHttpRequest()


@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation IHttpRequest
static IHttpRequest *_instance = nil;

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self manager];
    }
    return self;
}

+ (instancetype)shareRequest {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[IHttpRequest alloc]init];
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

#pragma mark: - Setter & Getter
- (AFHTTPSessionManager *)manager {
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //_manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // parsing json
        _manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:(NSJSONReadingAllowFragments)];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"image/jpg", nil];
    }
    return _manager;
}

/**
 * GET/POST/UPLOAD request
 */
- (NSURLSessionDataTask *) sendRequest: (IBaseRequest *) request
                              progress: (ProgressBlock) progressBlock
                               success: (SuccessBlock) successBlock
                               failure: (FailureBlock) failureBlock {
    
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", request.baseURL, request.methodName];
    NSLog(@"请求链接：%@ 请求参数：%@", requestURL, request.params);
    NSMutableDictionary *tempParams =  request.params == nil ? [NSMutableDictionary dictionary] : [request.params mutableCopy];
    if (request.cacheConfig.userId) {
        tempParams[@"userId"] = request.cacheConfig.userId;
    }
    NSString *cacheKey = [ICacheKey getKey:requestURL params:tempParams];
    // 从本地读取缓存
    if (request.cacheConfig.isRead) {
        NSDictionary *dict = [IDataManager dataToDict:[IHttpCache read:cacheKey request: request]];
        if (successBlock && dict) {
            successBlock(dict, YES);
        }
    }
    switch (request.requestType) {
        case RequestTypeGET:
            return [self getRequest:request progress: progressBlock success:successBlock failure:failureBlock];
        case RequestTypePOST:
            return [self postRequest:request progress: progressBlock success:successBlock failure:failureBlock];
        case RequestTypeUPLOAD:
            return [self uploadRequest:request progress: progressBlock success:successBlock failure:failureBlock];
    }
    
}


#pragma mark: - private methdos
- (NSURLSessionDataTask *)getRequest: (IBaseRequest *) request
                            progress: (ProgressBlock) progressBlock
                             success: (SuccessBlock) successBlock
                             failure: (FailureBlock) failureBlock {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", request.baseURL, request.methodName];
    NSMutableDictionary *tempParams =  request.params == nil ? [NSMutableDictionary dictionary] : [request.params mutableCopy];
    if (request.cacheConfig.userId) {
        tempParams[@"userId"] = request.cacheConfig.userId;
    }
    NSString *cacheKey = [ICacheKey getKey:requestURL params:tempParams];
    
    // request timeout
    [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    _manager.requestSerializer.timeoutInterval = request.timeout;
    [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    // header
    if (request.header) {
        [request.header enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString *  _Nonnull obj, BOOL * _Nonnull stop) {
            [self->_manager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    return [_manager GET:requestURL parameters:request.params progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progressBlock) {
            progressBlock(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (request.cacheConfig.isSave) {
            NSData *resultData;
            if ([responseObject isKindOfClass:[NSString class]]) {
                resultData = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
            } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
                resultData = [IDataManager dictToData:responseObject];
            }
            if (resultData) {
                [IHttpCache save:cacheKey data: resultData request: request];
            }
        }
        if (successBlock) {
            successBlock(responseObject, NO);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    
}

- (NSURLSessionDataTask *)postRequest: (IBaseRequest *) request
                             progress: (ProgressBlock) progressBlock
                              success: (SuccessBlock) successBlock
                              failure: (FailureBlock) failureBlock {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", request.baseURL, request.methodName];
    NSMutableDictionary *tempParams =  request.params == nil ? [NSMutableDictionary dictionary] : [request.params mutableCopy];
    if (request.cacheConfig.userId) {
        tempParams[@"userId"] = request.cacheConfig.userId;
    }
    NSString *cacheKey = [ICacheKey getKey:requestURL params:tempParams];
    
    // request timeout
    [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    _manager.requestSerializer.timeoutInterval = request.timeout;
    [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // header
    if (request.header) {
        [request.header enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString *  _Nonnull obj, BOOL * _Nonnull stop) {
            [self->_manager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    
    return [_manager POST:requestURL parameters:request.params progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progressBlock) {
            progressBlock(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (request.cacheConfig.isSave) {
            NSData *resultData;
            if ([responseObject isKindOfClass:[NSString class]]) {
                resultData = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
            } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
                resultData = [IDataManager dictToData:responseObject];
            }
            if (resultData) {
                [IHttpCache save:cacheKey data: resultData request: request];
            }
        }
        if (successBlock) {
            successBlock(responseObject, NO);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    
}

/**
 * UPLOAD request
 */
- (NSURLSessionDataTask *) uploadRequest: (IBaseRequest *)request
                                progress: (ProgressBlock) progressBlock
                                 success: (SuccessBlock)successBlock
                                 failure: (FailureBlock)failureBlock {
    
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", request.baseURL, request.methodName];
    NSMutableDictionary *tempParams =  request.params == nil ? [NSMutableDictionary dictionary] : [request.params mutableCopy];
    if (request.cacheConfig.userId) {
        tempParams[@"userId"] = request.cacheConfig.userId;
    }
    NSString *cacheKey = [ICacheKey getKey:requestURL params:tempParams];
    
    // request timeout
    [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    _manager.requestSerializer.timeoutInterval = request.timeout;
    [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // header
    if (request.header) {
        [request.header enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString *  _Nonnull obj, BOOL * _Nonnull stop) {
            [self->_manager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    
    return [_manager POST:requestURL parameters:request.params constructingBodyWithBlock:request.filesData progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progressBlock) {
            progressBlock(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (request.cacheConfig.isSave) {
            NSData *resultData;
            if ([responseObject isKindOfClass:[NSString class]]) {
                resultData = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
            } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
                resultData = [IDataManager dictToData:responseObject];
            }
            if (resultData) {
                [IHttpCache save:cacheKey data: resultData request: request];
            }
        }
        if (successBlock) {
            successBlock(responseObject, NO);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    
}


@end
