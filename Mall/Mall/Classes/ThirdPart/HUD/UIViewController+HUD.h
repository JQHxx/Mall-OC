//
//  UIViewController+HUD.h
//  Mall
//
//  Created by midland on 2019/10/11.
//  Copyright © 2019 JQHxx. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HUD)

- (void)showSuccess:(NSString *)message icon: (NSString *) icon;
- (void)showSuccess:(NSString *)message isEnabled: (BOOL) isEnabled icon: (NSString *) icon;

- (void)showError:(NSString *)message icon: (NSString *) icon;
- (void)showError:(NSString *)message isEnabled: (BOOL) isEnabled icon: (NSString *) icon;

- (void)showToast:(NSString *)message;

- (void)showLoading:(NSString *)message;
- (void)showLoading:(NSString *)message isEnabled: (BOOL) isEnabled;

- (void)hideHUD;
- (void)hideHUDNoAnimated;

@end

NS_ASSUME_NONNULL_END
