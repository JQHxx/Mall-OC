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

-(void)showSuccess:(NSString *)success;
-(void)showError:(NSString *)error;
-(void)showMessage:(NSString *)message;
-(void)showWaiting;
-(void)showLoading;
-(void)showLoadingWithMessage:(NSString *)message;
-(void)hideHUD;

@end

NS_ASSUME_NONNULL_END
