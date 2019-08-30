//
//  JQJQWKWebViewModuleAPI.m
//  JQWKWebViewObjC
//
//  Created by HJQ on 2017/8/11.
//  Copyright © 2017年 JQHee. All rights reserved.
//

#import "WKWebViewModuleAPI.h"
#import "BaseWebBrowserViewController.h"

@implementation WKWebViewModuleAPI
static WKWebViewModuleAPI *_instance = nil;

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

#pragma mark: - setter and geter
- (UIViewController *)wkWebViewVC {
    return [[BaseWebBrowserViewController alloc]init];
}

- (UIViewController *)getWKWebViewVCWithUrlStr:(NSString *)urlStr loadType:(WKWebViewLoadType)loadType title:(NSString *)title {
    BaseWebBrowserViewController *vc = [[BaseWebBrowserViewController alloc]init];
    [vc loadWebWithUrlStr:urlStr loadType:loadType title:title];
    return vc;
}


@end
