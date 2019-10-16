//
//  Created by HJQ on 2017/8/11.
//  Copyright © 2017年 JQHee. All rights reserved.
//

#import "BaseWebBrowserViewController.h"
#import "WKDelegateViewController.h"

@interface BaseWebBrowserViewController () <WKScriptMessageHandler, WKDelegateViewControllerDelegate, WKNavigationDelegate, WKUIDelegate>
{
    NSString *_urlStr;
    WKWebViewLoadType _loadType;
}

@property (strong, nonatomic) WKWebView *wkwebView;
// 进度条
@property (nonatomic, strong) UIProgressView *progressView;

@property (nonatomic, strong) WKUserContentController *userContentController;

@end

@implementation BaseWebBrowserViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self setupUI];
    [self openURL];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.wkwebView.frame = self.view.bounds;
    self.progressView.frame = CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height + 44.0, self.view.bounds.size.width, 2.0);
}

- (void)dealloc {
    
    //这里需要注意，前面增加过的方法一定要remove掉。
    [self.userContentController removeScriptMessageHandlerForName:@"Native"];
    [self.wkwebView removeObserver:self forKeyPath:@"estimatedProgress"];
    NSLog(@"WebVCdealloc");
}

#pragma mark - Public Methods
- (void)loadWeb:(NSString *)content loadType:(WKWebViewLoadType)loadType title: (NSString *)title {
    _urlStr = content;
    _loadType = loadType;
    self.navigationItem.title = title;
}

#pragma mark - Private methods
- (void)setupUI {
    [self.view addSubview:self.wkwebView];
    [self.view addSubview:self.progressView];
}

- (void)openURL {

    if (_urlStr.length <= 0) {
        return;
    }
    
    if (_loadType == WKWebViewLoadTypeLocal) {
        [self.wkwebView loadHTMLString:_urlStr baseURL:nil];
    }else {
        NSURL *url = [NSURL URLWithString:_urlStr];
        // 根据URL创建请求
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setTimeoutInterval:15];
        [self.wkwebView loadRequest:request];
    }
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //开始加载网页时展示出progressView
    self.progressView.hidden = NO;
    //开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    //防止progressView被网页挡住
    [self.view bringSubviewToFront:self.progressView];
}

#pragma mark - WKDelegateVCDelegate
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
}

#pragma mark - event response
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.wkwebView.estimatedProgress;
        if (self.progressView.progress == 1.0) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
                
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - setter and getter
- (UIProgressView *)progressView {
    if (! _progressView) {
        //进度条初始化
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectZero];
        _progressView.progressTintColor = [UIColor orangeColor];
        //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
        _progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    }
    return _progressView;
}

- (WKUserContentController *)userContentController {
    if (! _userContentController) {
        _userContentController = [[WKUserContentController alloc]init];
        // 内容视图自适应大小
        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        [_userContentController addUserScript:wkUScript];
        
        // 2.注册方法（必要设置，不然WKWebView会无法释放）
        WKDelegateViewController *delegateController = [[WKDelegateViewController alloc] init];
        delegateController.delegate = self;
        // 有添加一定有移除，成对出现
        [_userContentController addScriptMessageHandler:delegateController name:@"Native"];
    }
    return _userContentController;
}

- (WKWebView *)wkwebView {
    if (! _wkwebView) {
        // 1.配置环境
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = self.userContentController;
        _wkwebView = [[WKWebView alloc]initWithFrame:CGRectZero configuration:configuration];
        _wkwebView.opaque = NO;
        _wkwebView.UIDelegate = self;
        _wkwebView.navigationDelegate = self;
        [_wkwebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _wkwebView;
}


@end
