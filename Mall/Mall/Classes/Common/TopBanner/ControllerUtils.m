//
//  ControllerUtils.m
//  Mall
//
//  Created by midland on 2019/9/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "ControllerUtils.h"

@implementation ControllerUtils
    
+ (UIViewController *)topViewController {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    return [self topVisibleViewControllerOfViewControlller:rootViewController];
}
    
+ (UIViewController *)topVisibleViewControllerOfViewControlller:(UIViewController *)vc {
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)vc;
        return [self topVisibleViewControllerOfViewControlller:tabBarController.selectedViewController];
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)vc;
        return [self topVisibleViewControllerOfViewControlller:navigationController.visibleViewController];
    } else if (vc.presentedViewController) {
        return [self topVisibleViewControllerOfViewControlller:vc.presentedViewController];
    } else if (vc.childViewControllers.count > 0){
        return [self topVisibleViewControllerOfViewControlller:vc.childViewControllers.lastObject];
    }
    
    return vc;
}

@end
