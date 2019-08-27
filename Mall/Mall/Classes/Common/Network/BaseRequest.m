//
//  BaseRequest.m
//  Mall
//
//  Created by midland on 2019/8/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "BaseRequest.h"


@implementation BaseRequest

- (NSString *)baseURL {
    return KBaseServer;
}

- (NSString *)methodName {
    return @"";
}

- (NSDictionary<NSString *, NSString *> *)header {
    return [NSDictionary dictionary];
}

- (NSDictionary *)params {
    return [NSDictionary dictionary];
}

- (RequestType)requestType {
    return RequestTypePOST;
}

- (NSTimeInterval)timeout {
    return 15;
}

@end
