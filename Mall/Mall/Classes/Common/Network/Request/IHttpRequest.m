//
//  HttpRequest.m
//  Mall
//
//  Created by midland on 2019/8/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "IHttpRequest.h"
#import "IBaseRequest.h"
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
    NSLog(@"请求链接 ==> %@ 请求参数：%@", requestURL, request.params);
    NSString *cacheKey = [ICacheKey getKey:requestURL params:[self getTempParams:request]];
    
     [self setupConfig:request];
    
    // get cache from local
    if (request.cacheConfig.isRead) {
        NSDictionary *dict = [IDataManager dataToDict:[IHttpCache read:cacheKey request: request]];
        if (successBlock && dict) {
            successBlock(dict, YES);
        }
    }
    switch (request.requestType) {
        case RequestTypeGET:
            return [self getRequest:request progress: progressBlock success:^(id responseObject, BOOL isCache) {
                // save data to local
                [self handleSuccessResult:responseObject cacheKey:cacheKey request:request];
                if (successBlock) {
                    successBlock(responseObject, isCache);
                }
            } failure:^(NSError *error) {
                if (failureBlock) {
                    failureBlock(error);
                }
            }];
        case RequestTypePOST:
            return [self postRequest:request progress: progressBlock success:^(id responseObject, BOOL isCache) {
                // save data to local
                [self handleSuccessResult:responseObject cacheKey:cacheKey request:request];
                if (successBlock) {
                    successBlock(responseObject, isCache);
                }
            } failure:^(NSError *error) {
                if (failureBlock) {
                    failureBlock(error);
                }
            }];
        case RequestTypeFORM:
            return [self uploadRequest:request progress: progressBlock success:^(id responseObject, BOOL isCache) {
                // save data to local
                [self handleSuccessResult:responseObject cacheKey:cacheKey request:request];
                if (successBlock) {
                    successBlock(responseObject, isCache);
                }
            } failure:^(NSError *error) {
                if (failureBlock) {
                    failureBlock(error);
                }
            }];
    }
    
}


#pragma mark: - private methdos
/**
 * GET
 */
- (NSURLSessionDataTask *)getRequest: (IBaseRequest *) request
                            progress: (ProgressBlock) progressBlock
                             success: (SuccessBlock) successBlock
                             failure: (FailureBlock) failureBlock {
    
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", request.baseURL, request.methodName];
    return [_manager GET:requestURL parameters:request.params progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progressBlock) {
            progressBlock(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
 * POST
 */
- (NSURLSessionDataTask *)postRequest: (IBaseRequest *) request
                             progress: (ProgressBlock) progressBlock
                              success: (SuccessBlock) successBlock
                              failure: (FailureBlock) failureBlock {
    
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", request.baseURL, request.methodName];
    return [_manager POST:requestURL parameters:request.params progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progressBlock) {
            progressBlock(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
 * From POST
 */
- (NSURLSessionDataTask *) uploadRequest: (IBaseRequest *)request
                                progress: (ProgressBlock) progressBlock
                                 success: (SuccessBlock)successBlock
                                 failure: (FailureBlock)failureBlock {
    
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", request.baseURL, request.methodName];
    return [_manager POST:requestURL parameters:request.params constructingBodyWithBlock:request.filesData progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progressBlock) {
            progressBlock(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
 * config request timeout and header
 */
- (void) setupConfig: (IBaseRequest *) request {
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
}

- (NSDictionary *) getTempParams: (IBaseRequest *) request {
    NSMutableDictionary *tempParams =  request.params == nil ? [NSMutableDictionary dictionary] : [request.params mutableCopy];
    if (request.cacheConfig.userId) {
        tempParams[@"USERID"] = request.cacheConfig.userId;
    }
    return tempParams;
}

- (void) handleSuccessResult: (id) responseObject cacheKey: (NSString *) cacheKey request: (IBaseRequest *) request {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", request.baseURL, request.methodName];
    NSLog(@"%@ Success=>%@", requestURL, [NSString stringWithFormat:@"%@", responseObject]);
    if (request.cacheConfig.isSave) {
        NSData *resultData = [IDataManager getData:responseObject];
        if (resultData) {
            [IHttpCache save:cacheKey data: resultData request: request];
        }
    }
}
@end
