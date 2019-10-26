//
//  CTMediator+Function_Mediator.m
//  Mall
//
//  Created by HJQ on 2019/10/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "CTMediator+Function.h"

@implementation CTMediator (Function)

// 调用swift
- (UIViewController *)Function_Swift_ViewControllerWithCallback:(void (^)(NSString *))callback
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"callback"] = callback;
    params[kCTMediatorParamsKeySwiftTargetModuleName] = @"Mall";
    return [self performTarget:@"Function" action:@"FunctionController" params:params shouldCacheTarget:NO];
}

// 调用OC
- (UIViewController *)Function_Objc_ViewControllerWithCallback:(void (^)(NSString *))callback
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"callback"] = callback;
    return [self performTarget:@"Function" action:@"FunctionController" params:params shouldCacheTarget:NO];
}

@end
