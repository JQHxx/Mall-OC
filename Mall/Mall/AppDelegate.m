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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
     [[BLStopwatch sharedStopwatch] splitWithType:BLStopwatchSplitTypeContinuous description:@"AFL0"];
    [DMNetworkTrafficManager start];
    
    [UncaughtExceptionHandler installUncaughtException:^(NSString *exceptionStr) {
        
        //1、进行数据上传
        
        //2、上传成功后，清除本地崩溃日志.
        
        // [UncaughtExceptionHandler exceptionDocumentsClear];
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
    
    DDLogWarn(@"[Warn]IS %@", @"");
    
    WSLSuspendingView * suspendingView = [WSLSuspendingView sharedSuspendingView];
    WSLFPS * fps = [WSLFPS sharedFPSIndicator];
    [fps startMonitoring];
    fps.FPSBlock = ^(float fps) {
        suspendingView.fpsLabel.text = [NSString stringWithFormat:@"FPS = %.2f",fps];
        NSLog(@"%@",suspendingView.fpsLabel.text);
    };
    
    [[BLStopwatch sharedStopwatch] splitWithType:BLStopwatchSplitTypeContinuous description:@"AFL1"];
    // [[BLStopwatch sharedStopwatch] stopAndPresentResultsThenReset];
    
    return YES;
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


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
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

- (void) adapterOSVersion {
    if (@available(iOS 11.0,*))  {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

@end
