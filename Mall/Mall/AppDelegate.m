//
//  AppDelegate.m
//  Mall
//
//  Created by midland on 2019/8/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "UncaughtExceptionHandler.h"
#import "CSFileLogger.h"
#import "DMNetworkTrafficManager.h"
#import "WSLSuspendingView.h"
#import "WSLFPS.h"
#import <AuthenticationServices/AuthenticationServices.h>

#import <FBMemoryProfiler/FBMemoryProfiler.h>
#import "CacheCleanerPlugin.h"
#import "RetainCycleLoggerPlugin.h"

#import "ONLDynamicLoader.h"
#import "NKDelayedMonitor.h"
#import "UIViewController+FPS.h"
#import "UIViewController+LoadingTime.h"

@interface AppDelegate ()
{
  FBMemoryProfiler *_memoryProfiler;
}

@property (nonatomic, strong) UIVisualEffectView *effectView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 卡顿检测
    NKDelayedMonitor *monitor = [NKDelayedMonitor sharedInstance];
    [monitor startOnlineMonitor];
    // [monitor startOfflineMonitor];
    [UIViewController recordViewLoadTime:YES];

    
    // 延时调用
    [ONLDynamicLoader executeFunctionsForKey:LEVEL_B];
    
    [[BLStopwatch sharedStopwatch] splitWithType:BLStopwatchSplitTypeContinuous description:@"AFL0"];
    [DMNetworkTrafficManager start];
    
    FBMemoryProfiler *memoryProfiler = [FBMemoryProfiler new];
    [memoryProfiler enable];
    _memoryProfiler = [[FBMemoryProfiler alloc] initWithPlugins:@[[CacheCleanerPlugin new],
                                                                  [RetainCycleLoggerPlugin new]]
                               retainCycleDetectorConfiguration: nil];
    [_memoryProfiler enable];
    
    [UncaughtExceptionHandler installUncaughtException:^(NSString *exceptionStr) {
        
        // 1、进行数据上传
        
        // 2、上传成功后，清除本地崩溃日志.
        [UncaughtExceptionHandler exceptionDocumentsClear];
        NSLog(@"%@", exceptionStr);
    }];
    
    // [self performSelector:@selector(string) withObject:nil afterDelay:0];
    
    //NSURLProtocol
    // [NSURLProtocol registerClass:[SonicURLProtocol class]];
    
    
    // 设置主窗口,并设置根控制器
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    [self.window makeKeyAndVisible];
    MainTabBarController *rootViewController = [[MainTabBarController alloc] init];
    [self.window setRootViewController:rootViewController];
    [self setUpNavigationBarAppearance];
    [self adapterOSVersion];
    [self setupLogger];

    DDLogWarn(@"[Warn]IS %@", [Config qqAppKey]);
    
    NSLog(@"%@", [@"18775134256" numberSuitScanfRange:NSMakeRange(1, 5)]);
    /*
    WSLSuspendingView * suspendingView = [WSLSuspendingView sharedSuspendingView];
    WSLFPS * fps = [WSLFPS sharedFPSIndicator];
    [fps startMonitoring];
    fps.FPSBlock = ^(float fps) {
        suspendingView.fpsLabel.text = [NSString stringWithFormat:@"FPS = %.2f",fps];
        NSLog(@"%@",suspendingView.fpsLabel.text);
    };
     */
    [[BLStopwatch sharedStopwatch] splitWithType:BLStopwatchSplitTypeContinuous description:@"AFL1"];
    // [[BLStopwatch sharedStopwatch] stopAndPresentResultsThenReset];
    [self observeAuthticationState];

    return YES;
}


//! 苹果登录观察授权状态监听
- (void)observeAuthticationState {
    
    if (@available(iOS 13.0, *)) {
        // A mechanism for generating requests to authenticate users based on their Apple ID.
        // 基于用户的Apple ID 生成授权用户请求的机制
        ASAuthorizationAppleIDProvider *appleIDProvider = [ASAuthorizationAppleIDProvider new];
        // 注意 存储用户标识信息需要使用钥匙串来存储 这里笔者简单期间 使用NSUserDefaults 做的简单示例
        NSString *userIdentifier = [YostarKeychain load:KEYCHAIN_IDENTIFIER(@"userIdentifier")];
        
        if (userIdentifier) {
            NSString* __block errorMsg = nil;
            //Returns the credential state for the given user in a completion handler.
            // 在回调中返回用户的授权状态
            [appleIDProvider getCredentialStateForUserID:userIdentifier completion:^(ASAuthorizationAppleIDProviderCredentialState credentialState, NSError * _Nullable error) {
                switch (credentialState) {
                        // 苹果证书的授权状态
                    case ASAuthorizationAppleIDProviderCredentialRevoked:
                        // 苹果授权凭证失效
                        errorMsg = @"苹果授权凭证失效";
                        break;
                    case ASAuthorizationAppleIDProviderCredentialAuthorized:
                        // 苹果授权凭证状态良好
                        errorMsg = @"苹果授权凭证状态良好";
                        break;
                    case ASAuthorizationAppleIDProviderCredentialNotFound:
                        // 未发现苹果授权凭证
                        errorMsg = @"未发现苹果授权凭证";
                        break;
                        // 可以引导用户重新登录
                    case ASAuthorizationAppleIDProviderCredentialTransferred:
                        
                        break;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"SignInWithApple授权状态变化情况");
                    NSLog(@"%@", errorMsg);
                });
            }];
            
        }
    }
}

- (void) setupLogger {

    // 这将在你的日志框架中添加两个“logger”。也就是说你的日志语句将被发送到Console.app和Xcode控制 台（就像标准的NSLog）
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
  
    //系统上保持一周的日志文件。
    //如果不设置rollingFrequency和maximumNumberOfLogFiles，
    //则默认每天1个Log文件、存5天、单个文件最大1M、总计最大20M，否则自动清理最前面的记录。
    CSFileLogger *customLogger = [[CSFileLogger alloc] initWithFlag:1011];
    customLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    customLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:customLogger];
}

- (void) setupKeyboarManager {
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [[IQKeyboardManager sharedManager] setToolbarDoneBarButtonItemText:@"完成"];
    
    /*
    IQTextView *textView = [[IQTextView alloc]init];
    textView.placeholder = @"提示文字";
    */
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
     // 仿支付宝信息安全
     //添加屏幕毛玻璃
     UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
     self.effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
     self.effectView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
     self.effectView.alpha = 0.93;
     [self.window addSubview:self.effectView];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    //移除屏幕毛玻璃
    [self.effectView removeFromSuperview];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Private methods
/**
 *  设置navigationBar样式
 */
- (void)setUpNavigationBarAppearance {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    UIColor *backgroundColor = [UIColor whiteColor];
    NSDictionary *textAttributes = nil;
    UIColor *labelColor =   [UIColor blackColor];
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        textAttributes = @{
                           NSFontAttributeName : [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName : labelColor,
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        textAttributes = @{
                           UITextAttributeFont : [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor : labelColor,
                           UITextAttributeTextShadowColor : [UIColor clearColor],
                           UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    [navigationBarAppearance setBarTintColor:backgroundColor];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}

/**
 适配iOS11以上的系统
 */
- (void) adapterOSVersion {
    if (@available(iOS 11.0, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [UITableView appearance].estimatedRowHeight = 0;
        [UITableView appearance].estimatedSectionHeaderHeight = 0;
        [UITableView appearance].estimatedSectionFooterHeight = 0;
    }
}

@end

/*
#import "OFPrivacyAlertVC.h"
#import <Masonry.h>
#import <YYText.h>

@interface OFPrivacyAlertVC ()

@property (nonatomic, strong) UIButton *backgroundButton;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UILabel *privacyTileLabel;
@property (nonatomic, strong) YYLabel *contentLabel;

@end

@implementation OFPrivacyAlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];;
    [self setupUI];
    [self setupContent];
}

#pragma mark - Private methods
- (void) setupUI {
    [self.view addSubview:self.backgroundButton];
    [self.view addSubview:self.contentView];
    [self.backgroundButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(45);
        make.right.mas_equalTo(self.view).offset(-45);
        make.centerY.mas_equalTo(self.view);
    }];
    
    // 设置contentView上的内容
    [self.contentView addSubview:self.privacyTileLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.sureButton];
    
    [self.privacyTileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.right.mas_equalTo(self.contentView).offset(-15);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.contentView);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.privacyTileLabel);
        make.top.mas_equalTo(self.privacyTileLabel.mas_bottom);
        make.height.mas_greaterThanOrEqualTo(20);
    }];
    
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(self.contentLabel.mas_bottom);
    }];
    
}

- (void) setupContent {
    
    //设置整段字符串的颜色
    UIColor *color = [UIColor blackColor];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:15], NSForegroundColorAttributeName: color};
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"1.在浏览使用时，我们会收集、使用设备标识信息用于推荐。\n2.你可以查看完整版《用户协议》和《隐私政策》以便了解我们收集、使用、共享、存储信息的情况，以及对信息的保护策施。\n\n如果你同意请点击下面的按钮以接受我们的服务。" attributes:attributes];
    //设置高亮色和点击事件
    [text yy_setTextHighlightRange:[[text string] rangeOfString:@"《用户协议》"] color:[UIColor orangeColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"点击了《用户协议》");
    }];
    //设置高亮色和点击事件
    [text yy_setTextHighlightRange:[[text string] rangeOfString:@"《隐私政策》"] color:[UIColor orangeColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"点击了《隐私政策》");

    }];
    _contentLabel.attributedText = text;
}

#pragma mark - Public methods
- (void) show {
    
}

- (void) dismiss {
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - Setter & Getter
- (UIButton *)backgroundButton {
    if (!_backgroundButton) {
        _backgroundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backgroundButton.frame = UIScreen.mainScreen.bounds;
        _backgroundButton.backgroundColor = [UIColor clearColor];
    }
    return _backgroundButton;
}
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 15;
        _contentView.clipsToBounds = YES;
    }
    return _contentView;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureButton setTitle:@"知道了" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }
    return _sureButton;
}

- (UILabel *)privacyTileLabel {
    if (!_privacyTileLabel) {
        _privacyTileLabel = [[UILabel alloc]init];
        _privacyTileLabel.font = [UIFont systemFontOfSize:15];
        _privacyTileLabel.text = @"个人信息保护指引";
    }
    return _privacyTileLabel;
}

- (YYLabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[YYLabel alloc]init];
        _contentLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        _contentLabel.numberOfLines = 0;
        _contentLabel.preferredMaxLayoutWidth = UIScreen.mainScreen.bounds.size.width - 2 * 45 - 2 * 15;
    }
    return _contentLabel;
}

@end
*/
