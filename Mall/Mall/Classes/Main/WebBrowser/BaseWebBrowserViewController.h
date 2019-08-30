//
//  JQWKWebViewViewController.h
//  JQWKWebViewObjC
//
//  Created by HJQ on 2017/8/11.
//  Copyright © 2017年 JQHee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKWebViewBase.h"

@interface BaseWebBrowserViewController : UIViewController

- (void)loadWebWithUrlStr:(NSString *)urlStr loadType:(WKWebViewLoadType)loadType title: (NSString *)title;

@end
