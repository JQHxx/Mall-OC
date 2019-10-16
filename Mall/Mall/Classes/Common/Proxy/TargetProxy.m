//
//  TargetProxy.m
//  Mall
//
//  Created by midland on 2019/10/16.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "TargetProxy.h"

@interface TargetProxy()
//target, 这里必须要用weak, 因为某个对象会强引TimeProxy对象, TimeProxy对象不能再强引target, 否则会形成循环引用
@property (nonatomic, weak)id target;

@end

@implementation TargetProxy

+ (instancetype)proxyWithTarget:(id)target {
    TargetProxy *proxy = [[self class] alloc];
    proxy.target = target;
    return proxy;
}

//获取target类中的sel方法的方法签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    //判断target是否实现了该方法
    if ([self.target respondsToSelector:invocation.selector]) {
        //让target调用该方法
        [invocation invokeWithTarget:self.target];
    }else {
        //找不到该方法
        [invocation doesNotRecognizeSelector:invocation.selector];
    }
}

@end
