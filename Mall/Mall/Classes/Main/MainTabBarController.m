//
//  MainTabBarController.m
//  Mall
//
//  Created by midland on 2019/8/27.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainNavigationController.h"

#import "MessageViewController.h"
#import "FunctionViewController.h"
#import "ServiceViewController.h"
#import "MineViewController.h"


static CGFloat const CYLTabBarControllerHeight = 40.f;
#define RANDOM_COLOR [UIColor colorWithHue: (arc4random() % 256 / 256.0) saturation:((arc4random()% 128 / 256.0 ) + 0.5) brightness:(( arc4random() % 128 / 256.0 ) + 0.5) alpha:1]


@interface MainTabBarController ()<UITabBarControllerDelegate>

@end

@implementation MainTabBarController

- (instancetype)init
{
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;//UIEdgeInsetsMake(4.5, 0, -4.5, 0);
    UIOffset titlePositionAdjustment = UIOffsetMake(0, -3.5);
    self = [super initWithViewControllers:[self viewControllersForTabBar]
                    tabBarItemsAttributes:[self tabBarItemsAttributesForTabBar]
                              imageInsets:imageInsets
                  titlePositionAdjustment:titlePositionAdjustment
                                  context:@""
            ];
    if (self) {
        [self customizeTabBarAppearance];
        self.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customizeInterface];
}

#pragma mark: - Private methods
- (NSArray *)viewControllersForTabBar {
    MessageViewController *firstViewController = [[MessageViewController alloc] init];
    UIViewController *firstNavigationController = [[MainNavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    [firstViewController cyl_setHideNavigationBarSeparator:YES];
    // [firstViewController cyl_setNavigationBarHidden:YES];
    
    UIStoryboard *functionStoryboard = [UIStoryboard storyboardWithName:StoryBoard(Function) bundle:nil];
    FunctionViewController *secondViewController = [functionStoryboard instantiateViewControllerWithIdentifier:@"FunctionViewController"];
    UIViewController *secondNavigationController = [[MainNavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    [secondViewController cyl_setHideNavigationBarSeparator:YES];
    // [secondViewController cyl_setNavigationBarHidden:YES];
    
    ServiceViewController *thirdViewController = [[ServiceViewController alloc] init];
    UIViewController *thirdNavigationController = [[MainNavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    [thirdViewController cyl_setHideNavigationBarSeparator:YES];
    
    MineViewController *fourthViewController = [[MineViewController alloc] init];
    UIViewController *fourthNavigationController = [[MainNavigationController alloc]
                                                    initWithRootViewController:fourthViewController];
    [fourthNavigationController cyl_setHideNavigationBarSeparator:YES];
    
    NSArray *viewControllers = @[
                                 firstNavigationController,
                                 secondNavigationController,
                                 thirdNavigationController,
                                 fourthNavigationController
                                 ];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForTabBar {
    CGFloat firstXOffset = -12/2;
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"消息",
                                                 CYLTabBarItemImage : [UIImage imageNamed:@"tabbar_customerservice_n"],  /* NSString and UIImage are supported*/
                                                 CYLTabBarItemSelectedImage : @"tabbar_customerservice_n",  /* NSString and UIImage are supported*/
                                                 CYLTabBarItemTitlePositionAdjustment : [NSValue valueWithUIOffset : UIOffsetMake(firstXOffset, -3.5)],
                                                 };
    CGFloat secondXOffset = (-25+2)/2;
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"功能",
                                                  CYLTabBarItemImage : [UIImage imageNamed:@"tabbar_customerservice_n"],
                                                  CYLTabBarItemSelectedImage : @"tabbar_customerservice_n",
                                                  CYLTabBarItemTitlePositionAdjustment : [NSValue valueWithUIOffset : UIOffsetMake(secondXOffset, -3.5)],
                                                  };
    
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"客服",
                                                 CYLTabBarItemImage : [UIImage imageNamed:@"tabbar_customerservice_n"],
                                                 CYLTabBarItemSelectedImage : @"tabbar_customerservice_n",
                                                 CYLTabBarItemTitlePositionAdjustment : [NSValue valueWithUIOffset : UIOffsetMake(-secondXOffset, -3.5)],
                                                 };
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"我的",
                                                  CYLTabBarItemImage : [UIImage imageNamed:@"tabbar_customerservice_n"],
                                                  CYLTabBarItemSelectedImage : @"tabbar_customerservice_n",
                                                  CYLTabBarItemTitlePositionAdjustment : [NSValue valueWithUIOffset : UIOffsetMake(-firstXOffset, -3.5)],
                                                  };
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       fourthTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}

/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance {
    // Customize UITabBar height
    // 自定义 TabBar 高度
    // tabBarController.tabBarHeight = CYL_IS_IPHONE_X ? 65 : 40;
    
    [self rootWindow].backgroundColor = [UIColor whiteColor];
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
    // [self customizeTabBarSelectionIndicatorImage];
    
    // update TabBar when TabBarItem width did update
    // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
    // remove the comment '//'
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
    //     [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
    
    // set background color
    // 设置 TabBar 背景
    // 半透明
    //    [UITabBar appearance].translucent = YES;
    // [UITabBar appearance].barTintColor = [UIColor cyl_systemBackgroundColor];
    // [[UITabBar appearance] setBackgroundColor:[UIColor cyl_systemBackgroundColor]];
    
    
    //     [[UITabBar appearance] setBackgroundImage:[[self class] imageWithColor:[UIColor whiteColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, tabBarController.tabBarHeight ?: (CYL_IS_IPHONE_X ? 65 : 40))]];
    //    [[UITabBar appearance] setUnselectedItemTintColor:[UIColor systemGrayColor]];
    
    //Three way to deal with shadow 三种阴影处理方式：
    // NO.3, without shadow : use -[[CYLTabBarController hideTabBarShadowImageView] in CYLMainRootViewController.m
    // NO.2，using Image
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    //    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    //    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"TabBar_Bg_Shadow"]];
    // NO.1，using layer to add shadow. note:recommended. 推荐该方式，可以给PlusButton突出的部分也添加上阴影
    //    tabBarController.tabBar.layer.shadowColor = [UIColor blackColor].CGColor;
    //    tabBarController.tabBar.layer.shadowRadius = 15.0;
    //    tabBarController.tabBar.layer.shadowOpacity = 0.2;
    //    tabBarController.tabBar.layer.shadowOffset = CGSizeMake(0, 3);
    //    tabBarController.tabBar.layer.masksToBounds = NO;
    //    tabBarController.tabBar.clipsToBounds = NO;
}

- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate {
    void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
            NSLog(@"Landscape Left or Right !");
        } else if (orientation == UIDeviceOrientationPortrait) {
            NSLog(@"Landscape portrait!");
        }
        // [self customizeTabBarSelectionIndicatorImage];
    };
    [[NSNotificationCenter defaultCenter] addObserverForName:CYLTabBarItemWidthDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:deviceOrientationDidChangeBlock];
}

- (void)customizeTabBarSelectionIndicatorImage {
    ///Get initialized TabBar Height if exists, otherwise get Default TabBar Height.
    CGFloat tabBarHeight = CYLTabBarControllerHeight;
    CGSize selectionIndicatorImageSize = CGSizeMake(CYLTabBarItemWidth, tabBarHeight);
    //Get initialized TabBar if exists.
    UITabBar *tabBar = self.tabBar ?: [UITabBar appearance];
    [tabBar setSelectionIndicatorImage:
     [[self class] imageWithColor:[UIColor whiteColor]
                             size:selectionIndicatorImageSize]];
}

+ (UIImage *)scaleImage:(UIImage *)image {
    CGFloat halfWidth = image.size.width/2;
    CGFloat halfHeight = image.size.height/2;
    UIImage *secondStrechImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(halfHeight, halfWidth, halfHeight, halfWidth) resizingMode:UIImageResizingModeStretch];
    return secondStrechImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), @"");
}


- (void)customizeInterface {
    //设置导航栏

    //添加小红点
    //添加提示动画，引导用户点击
    [self setViewDidLayoutSubViewsBlockInvokeOnce:YES block:^(CYLTabBarController *tabBarController) {
        NSUInteger delaySeconds = 1.5;
        dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delaySeconds * NSEC_PER_SEC));
        dispatch_after(when, dispatch_get_main_queue(), ^{
            @try {

                [tabBarController.viewControllers[3] cyl_showBadgeValue:@"NEW" animationType:CYLBadgeAnimationTypeBreathe];
            } @catch (NSException *exception) {}
            
            //添加仿淘宝tabbar，第一个tab选中后有图标覆盖
            if (self.selectedIndex != 0) {
                return;
            }
            // tabBarController.selectedIndex = 1;
        });
    }];
}


@end
