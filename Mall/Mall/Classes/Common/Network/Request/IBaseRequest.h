//
//  BaseRequest.h
//  Mall
//
//  Created by midland on 2019/8/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef NS_ENUM(NSInteger,RequestType) {
    RequestTypeGET = 0,
    RequestTypePOST = 1,
    RequestTypeFORM = 2,
};

@class ICacheConfig;
@interface IBaseRequest : NSObject

// 服务器地址
@property (nonatomic, copy) NSString *baseURL;
// 请求的接口名
@property (nonatomic, copy) NSString *methodName;
// 默认为POST请求方式
@property (nonatomic, assign) RequestType requestType;
// 请求参数
@property (nonatomic, strong) NSDictionary *params;
// 请求的Header头
@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *header;
// 超时时间
@property (nonatomic, assign) NSTimeInterval timeout;
// 文件参数
@property (nonatomic, copy) void (^filesData)(id<AFMultipartFormData>);

// 后续待添加缓存的相关逻辑
@property (nonatomic, strong) ICacheConfig *cacheConfig;

@end

