//
//  HookObjcLog.m
//  Mall
//
//  Created by midland on 2019/10/9.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "HookObjcLog.h"

@implementation HookObjcLog

+ (HookObjcLog *)shareInstance {
    static HookObjcLog * objLog = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        objLog = [[HookObjcLog alloc]init];
    });
    return objLog;
}

- (void)recordHookClass:(Class)cls identifier:(NSString *)identifier{
    NSLog(@"当前类名:%@",NSStringFromClass(cls));
    NSLog(@"标识符:%@",identifier);
}

- (void)recordLogActionHookClass:(Class)cls
                          action:(SEL)action
                      identifier:(NSString *)identifier{
    NSLog(@"当前类名:%@",NSStringFromClass(cls));
    NSLog(@"标识符:%@",identifier);
    NSLog(@"当前点击的方法:%@",NSStringFromSelector(action));
}

@end
