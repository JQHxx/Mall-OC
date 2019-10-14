//
//  UIGestureRecognizer+Logger.m
//  Mall
//
//  Created by midland on 2019/10/9.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "UIGestureRecognizer+Logger.h"
#import "WYEHook.h"
#import "HookObjcLog.h"

@implementation UIGestureRecognizer (Logger)
@dynamic methodName;

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ///获取
        SEL originalSEL = @selector(initWithTarget:action:);
        SEL changeSEL = @selector(hook_initWithTarget:action:);
        [WYEHook hookClass:self fromSelector:originalSEL toSelector:changeSEL];
    });
}

- (instancetype)hook_initWithTarget:(nullable id)target action:(nullable SEL)action{
    UIGestureRecognizer *gestureRecognizer = [self hook_initWithTarget:target action:action];
    self.methodName = NSStringFromSelector(action);
    return gestureRecognizer;
}

/*
- (void)hook_gestureAction:(id)sender {
    [self hook_gestureAction:sender];
    NSLog(@"%@", [sender class]);
    [[HookObjcLog shareInstance] recordLogActionHookClass:self.view.classForCoder action:@selector(hook_gestureAction:) identifier:@"手势"];

}
 */

static const void *MethodName = &MethodName;
- (void)setMethodName:(NSString *)methodName {
    objc_setAssociatedObject(self, MethodName, methodName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)methodName {
    return objc_getAssociatedObject(self, MethodName);
}


@end
