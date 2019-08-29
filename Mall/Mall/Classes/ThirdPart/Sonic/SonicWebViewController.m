//
//  SonicWebViewController.m
//  Mall
//
//  Created by midland on 2019/8/29.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "SonicWebViewController.h"

@interface SonicWebViewController ()

@property (nonatomic,assign)BOOL isStandSonic;

@end

@implementation SonicWebViewController

- (instancetype)initWithUrl:(NSString *)aUrl useSonicMode:(BOOL)isSonic unStrictMode:(BOOL)state
{
    if (self = [super init]) {
        
        self.url = aUrl;
        
        self.clickTime = (long long)([[NSDate date]timeIntervalSince1970]*1000);
        
        if (isSonic) {
            if (state) {
                SonicSessionConfiguration *configuration = [SonicSessionConfiguration new];
                NSString *linkValue = @"http://assets.kgc.cn/ff7f069b/css/common-min.www.kgc.css?v=e4ecfe82;http://assets.kgc.cn/ff7f069b/css/themes.www.kgc.css?v=612eb426;http://assets.kgc.cn/ff7f069b/css/style.www.kgc.css?v=05d94f84";
                configuration.customResponseHeaders = @{
                                                        SonicHeaderKeyCacheOffline:SonicHeaderValueCacheOfflineStore,
                                                        SonicHeaderKeyLink:linkValue
                                                        };
                configuration.enableLocalServer = YES;
                configuration.supportCacheControl = YES;
                [[SonicEngine sharedEngine] createSessionWithUrl:self.url withWebDelegate:self withConfiguration:configuration];
            }else{
                self.isStandSonic = YES;
                [[SonicEngine sharedEngine] createSessionWithUrl:self.url withWebDelegate:self];
            }
        }
    }
    return self;
}

- (void)dealloc
{
    [[SonicEngine sharedEngine] removeSessionWithWebDelegate:self];
}

- (void)loadView
{
    [super loadView];
    
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    self.view = self.webView;
    
    if (self.isStandSonic) {
        UIBarButtonItem *reloadItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(updateAction)];
        self.navigationItem.rightBarButtonItem = reloadItem;
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    
    SonicSession* session = [[SonicEngine sharedEngine] sessionWithWebDelegate:self];
    if (session) {
        [self.webView loadRequest:[SonicUtil sonicWebRequestWithSession:session withOrigin:request]];
    }else{
        [self.webView loadRequest:request];
    }
    
}

- (void)updateAction
{
    [[SonicEngine sharedEngine] reloadSessionWithWebDelegate:self completion:^(NSDictionary *result) {
        
    }];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{

    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{

}

#pragma mark - Sonic Session Delegate

- (void)sessionWillRequest:(SonicSession *)session
{
    //可以在请求发起前同步Cookie等信息
}

- (void)session:(SonicSession *)session requireWebViewReload:(NSURLRequest *)request
{
    [self.webView loadRequest:request];
}

@end
