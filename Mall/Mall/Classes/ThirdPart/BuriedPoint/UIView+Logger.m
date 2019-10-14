//
//  UIView+Logger.m
//  Mall
//
//  Created by midland on 2019/10/14.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "UIView+Logger.h"
#import "WYEHook.h"
#import "HookObjcLog.h"
#import "UIGestureRecognizer+Logger.h"

@implementation UIView (Logger)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSel = @selector(addGestureRecognizer:);
        SEL swizzledSEL = @selector(hook_addGestureRecognizer:);
        [WYEHook hookClass:self fromSelector:originalSel toSelector:swizzledSEL];
    });
}

- (void)hook_addGestureRecognizer:(UIGestureRecognizer *)gesture {
    [self hook_addGestureRecognizer:gesture];

    // || [gesture isKindOfClass:[UILongPressGestureRecognizer class]]
    if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
       [gesture addTarget:self action:@selector(autoEventAction:)];
        // [self autoEventAction:gesture];
    }
}

- (void)autoEventAction:(UIGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateEnded) {
        // 获取顶层VC
        // NSString *viewControllerName = [PathHelper getMyViewControllerWithSender:gesture];
        NSString *actionName = gesture.methodName;
        [[HookObjcLog shareInstance] recordLogActionHookClass:[[self topViewController] class] action:NSSelectorFromString(actionName) identifier:@"手势"];

    }
}

#pragma mark -  获取当前最顶层的ViewController

- (UIViewController*)topVC:(UIViewController*)VC {

    if([VC isKindOfClass:[UINavigationController class]]) {
        return[self topVC:[(UINavigationController*)VC topViewController]];
    }

    if([VC isKindOfClass:[UITabBarController class]]) {
        return[self topVC:[(UITabBarController*)VC selectedViewController]];
    }
    return VC;

}

- (UIViewController*)topViewController {

    UIViewController *vc = [self topVC:[UIApplication sharedApplication].keyWindow.rootViewController];
    while(vc.presentedViewController) {
        vc = [self topVC:vc];
    }
    return vc;

}

@end
