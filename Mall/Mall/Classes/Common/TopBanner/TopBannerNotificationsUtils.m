//
//  TopBannerNotificationsUtils.m
//  Mall
//
//  Created by midland on 2019/9/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "TopBannerNotificationsUtils.h"
#import "ControllerUtils.h"

#define kDefaultLastTime 1.4
#define kDefaultAnimationTime 0.3

@implementation TopBannerNotificationsUtils
    
int HEIGHT_IPHONEX_BOTTOM_WHITE = 34;
    
+ (void)alertWithMessage:(NSString *)message
{
    if ([message isEqualToString:@""] || message == nil) {
        return;
    }
    
    CGFloat statusBarHeight = 10;
    if ([UIApplication sharedApplication].isStatusBarHidden || [self isIphoneX]) {
        statusBarHeight = 0;
    }
    UIViewController *vc = [ControllerUtils topViewController];
    __block UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, - 56 - HEIGHT_IPHONEX_BOTTOM_WHITE, [UIScreen mainScreen].bounds.size.width, 56 + HEIGHT_IPHONEX_BOTTOM_WHITE);
    view.backgroundColor = [UIColor blackColor];
    if (vc.navigationController.navigationBarHidden) {
        [vc.view addSubview:view];
    } else {
        [vc.navigationController.navigationBar.superview addSubview:view];
    }
    
    UILabel *lab = [[UILabel alloc] init];
    lab.frame = CGRectMake(0, statusBarHeight + HEIGHT_IPHONEX_BOTTOM_WHITE, [UIScreen mainScreen].bounds.size.width, 56);
    lab.backgroundColor = [UIColor blackColor];
    lab.text = message;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    lab.font = [UIFont systemFontOfSize:14];
    [view addSubview:lab];
    
    [UIView animateWithDuration:kDefaultAnimationTime delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 56 + HEIGHT_IPHONEX_BOTTOM_WHITE);
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kDefaultLastTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:kDefaultAnimationTime delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                view.frame = CGRectMake(0, - 56 - HEIGHT_IPHONEX_BOTTOM_WHITE, [UIScreen mainScreen].bounds.size.width, 56 + HEIGHT_IPHONEX_BOTTOM_WHITE);
            } completion:^(BOOL finished) {
                [view removeFromSuperview];
                view = nil;
            }];
        });
    }];
}
    
+ (BOOL) isIphoneX {
    BOOL iPhoneX = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {//判断是否是手机
        return iPhoneX;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneX = YES;
        }
    }
    return iPhoneX;
}


@end
