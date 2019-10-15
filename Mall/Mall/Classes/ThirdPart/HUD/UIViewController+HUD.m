//
//  UIViewController+HUD.m
//  Mall
//
//  Created by midland on 2019/10/11.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "UIViewController+HUD.h"


@implementation UIViewController (HUD)

- (void)showSuccess:(NSString *)success icon: (NSString *) icon {
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:[self getView]];
    HUD.animationType = MBProgressHUDAnimationZoomOut;
    HUD.contentColor = [UIColor whiteColor];
    HUD.bezelView.color = [UIColor blackColor];
    // 设置图片
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    // 再设置模式
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.label.text = success;
    HUD.removeFromSuperViewOnHide = YES;
    [[self getView] addSubview:HUD];
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:1.5];
}

- (void)showError:(NSString *)error icon: (NSString *) icon {
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:[self getView]];
    HUD.animationType = MBProgressHUDAnimationZoomOut;
    HUD.contentColor = [UIColor whiteColor];
    HUD.bezelView.color = [UIColor blackColor];
    // 设置图片
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    // 再设置模式
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.label.text = error;
    HUD.removeFromSuperViewOnHide = YES;
    [[self getView] addSubview:HUD];
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:1.5];
}

- (void)showToast:(NSString *)message {
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:[self getView]];
    HUD.animationType = MBProgressHUDAnimationZoomOut;
    HUD.contentColor = [UIColor whiteColor];
    HUD.bezelView.color = [UIColor blackColor];
    HUD.mode = MBProgressHUDModeText;
    HUD.label.text = message;
    HUD.removeFromSuperViewOnHide = YES;
    [[self getView] addSubview:HUD];
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:1.5];
}

- (void)showLoading:(NSString *)message {
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:[self getView]];
    HUD.animationType = MBProgressHUDAnimationZoomOut;
    HUD.backgroundView.color = [UIColor colorWithWhite:1.f alpha:.2f];
    HUD.bezelView.color = [UIColor blackColor];
    HUD.contentColor = [UIColor whiteColor];
    HUD.label.text = message;
    HUD.removeFromSuperViewOnHide = YES;
    [[self getView] addSubview:HUD];
    [HUD showAnimated:YES];
}

- (void)hideHUD {
    [MBProgressHUD hideHUDForView:[self getView] animated:YES];
}

- (UIView *)getView {
    UIView *view;
    if (self.navigationController.view) {
        view = self.navigationController.view;
    } else {
        view = self.view;
    }
    return view;
}

@end
