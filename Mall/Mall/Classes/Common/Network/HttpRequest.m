//
//  HttpRequest.m
//  Mall
//
//  Created by midland on 2019/8/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "HttpRequest.h"
#import "BaseRequest.h"
#import "AFNetworking.h"

const NSString *RequestTypesMap[] = {
    [RequestTypeGET] = @"GET",
    [RequestTypePOST] = @"POST",
    [RequestTypeUpload] = @"UPLOAD",
};

@interface HttpRequest()


@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation HttpRequest
static HttpRequest *_instance = nil;

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
        _instance = [[HttpRequest alloc]init];
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
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
        // 这样设置是解析好的json
        // _manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:(NSJSONReadingAllowFragments)];
        //AFNetWorking 自动处理返回 null 对象的异常
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"image/jpg", nil];
    }
    return _manager;
}

/**
 * GET/POST/UPLOAD request
 */
- (void) sendRequest:(BaseRequest *) request
            progress: (ProgressBlock) progressBlock
             success: (SuccessBlock) successBlock
             failure: (FailureBlock) failureBlock {
    
    NSLog(@"请求链接：%@ 请求参数：%@", [NSString stringWithFormat:@"%@%@", request.baseURL, request.methodName], request.params);
    switch (request.requestType) {
        case RequestTypeGET:
            [self getRequest:request progress: progressBlock success:successBlock failure:failureBlock];
            break;
        case RequestTypePOST:
            [self postRequest:request progress: progressBlock success:successBlock failure:failureBlock];
            break;
        case RequestTypeUpload:
            [self uploadRequest:request progress: progressBlock success:successBlock failure:failureBlock];
            break;
    }
    
}


#pragma mark: - private methdos
- (void)getRequest:(BaseRequest *) request
          progress: (ProgressBlock) progressBlock
           success: (SuccessBlock) successBlock
           failure: (FailureBlock) failureBlock {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", request.baseURL, request.methodName];
    
    // 设置请求超时时间
    [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    _manager.requestSerializer.timeoutInterval = request.timeout;
    [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    // 设置header
    if (request.header) {
        [request.header enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString *  _Nonnull obj, BOOL * _Nonnull stop) {
            [self->_manager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    [_manager GET:requestURL parameters:request.params progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progressBlock) {
            progressBlock(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    
}

- (void)postRequest:(BaseRequest *) request
           progress: (ProgressBlock) progressBlock
           success: (SuccessBlock) successBlock
           failure: (FailureBlock) failureBlock {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", request.baseURL, request.methodName];
    // 设置请求超时时间
    [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    _manager.requestSerializer.timeoutInterval = request.timeout;
    [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // 设置header
    if (request.header) {
        [request.header enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString *  _Nonnull obj, BOOL * _Nonnull stop) {
            [self->_manager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    
    [_manager POST:requestURL parameters:request.params progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progressBlock) {
            progressBlock(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            successBlock(responseObject);
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
- (void) uploadRequest:(BaseRequest *)request
              progress: (ProgressBlock) progressBlock
               success:(SuccessBlock)successBlock
               failure:(FailureBlock)failureBlock {
    
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", request.baseURL, request.methodName];
    
    // 设置请求超时时间
    [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    _manager.requestSerializer.timeoutInterval = request.timeout;
    [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // 设置header
    if (request.header) {
        [request.header enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString *  _Nonnull obj, BOOL * _Nonnull stop) {
            [self->_manager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    
    [_manager POST:requestURL parameters:request.params constructingBodyWithBlock:request.filesData progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progressBlock) {
            progressBlock(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    
}


@end
