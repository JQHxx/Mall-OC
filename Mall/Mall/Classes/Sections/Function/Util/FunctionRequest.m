//
//  FunctionRequest.m
//  Mall
//
//  Created by midland on 2019/8/27.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "FunctionRequest.h"

@implementation FunctionRequest

- (NSString *)methodName {
    return API_HOME;
}

- (NSDictionary *)params {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    return dict;
}

@end
