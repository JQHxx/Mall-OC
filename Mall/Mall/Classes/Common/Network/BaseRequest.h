//
//  BaseRequest.h
//  Mall
//
//  Created by midland on 2019/8/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,RequestType) {
    RequestTypeGET = 0,
    RequestTypePOST = 1,
    RequestTypeUpload = 2,
};

const NSString *RequestTypesMap[] = {
    [RequestTypeGET] = @"GET",
    [RequestTypePOST] = @"POST",
    [RequestTypeUpload] = @"UPLOAD",
};

@interface BaseRequest : NSObject

// 服务器地址
@property (nonatomic, copy) NSString *baseURL;
// 请求的接口名
@property (nonatomic, copy) NSString *methodName;
// 默认为POST请求方式
@property (nonatomic, assign) RequestType requestType;
// 请求参数
@property (nonatomic, strong) NSDictionary *params;
// 请求的Header头
@property (nonatomic, strong) NSDictionary *header;
// 超时时间
@property (nonatomic, assign) NSTimeInterval timeout;

@end

