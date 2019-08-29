//
//  SonicWebViewController.h
//  Mall
//
//  Created by midland on 2019/8/29.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sonic.h"

@interface SonicWebViewController : UIViewController<SonicSessionDelegate,UIWebViewDelegate>
@property (nonatomic,strong)NSString *url;
@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,assign)long long clickTime;

- (instancetype)initWithUrl:(NSString *)aUrl useSonicMode:(BOOL)isSonic unStrictMode:(BOOL)state;

@end
