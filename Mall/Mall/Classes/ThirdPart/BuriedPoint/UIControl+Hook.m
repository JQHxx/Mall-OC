//
//  UIControl+Logger.m
//  Mall
//
//  Created by midland on 2019/10/9.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "UIControl+Hook.h"
#import "BFHook.h"
#import "HookObjcLog.h"

@implementation UIControl (Hook)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 通过 @selector 获得被替换和替换方法的 SEL，作为 SMHook:hookClass:fromeSelector:toSelector 的参数传入
        SEL fromSelector = @selector(sendAction:to:forEvent:);
        SEL toSelector = @selector(hook_sendAction:to:forEvent:);
        [BFHook hookClass:self fromSelector:fromSelector toSelector:toSelector];
    });
}

- (void)hook_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    [self insertToSendAction:action to:target forEvent:event];
    [self hook_sendAction:action to:target forEvent:event];
}
- (void)insertToSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    // 日志记录
    if ([[[event allTouches] anyObject] phase] == UITouchPhaseEnded) {
        // NSString *actionString = NSStringFromSelector(action);
        // NSString *targetName = NSStringFromClass([target class]);
        // NSLog(@"hook到button事件啦： %@",[NSString stringWithFormat:@"%@ %@",targetName,actionString]);
        [[HookObjcLog shareInstance] recordLogActionHookClass:[target class] action:action identifier:@"UIButton"];
    }
}

@end
