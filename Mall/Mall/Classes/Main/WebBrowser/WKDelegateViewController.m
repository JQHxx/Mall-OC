//
//  JQDelegateViewController.m
//  JQWKWebViewObjC
//
//  Created by HJQ on 2017/8/11.
//  Copyright © 2017年 JQHee. All rights reserved.
//

#import "WKDelegateViewController.h"

@interface WKDelegateViewController ()

@end

@implementation WKDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([self.delegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.delegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}


@end
