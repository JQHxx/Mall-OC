//
//  UIWindow+Hierarchy.m
//  Mall
//
//  Created by midland on 2019/10/17.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "UIWindow+Hierarchy.h"

@implementation UIWindow (Hierarchy)

- (UIViewController*)bf_topMostController {
    UIViewController *topController = [self rootViewController];
    //  Getting topMost ViewController
    while ([topController presentedViewController]) {
        topController = [topController presentedViewController];
    }
    //  Returning topMost ViewController
    return topController;
}

- (UIViewController*)bf_currentViewController {
    UIViewController *currentViewController = [self bf_topMostController];
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController]) {
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    }
    return currentViewController;
}

@end
