//
//  FunctionViewController.m
//  Mall
//
//  Created by midland on 2019/8/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "FunctionViewController.h"
#import "FunctionRequest.h"
#import "DMNetworkTrafficManager.h"
#import "TDNetFlowDataSource.h"
#import "ShowHUD.h"

@interface FunctionViewController ()

@end

@implementation FunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"首页";
    // [self setupUI];
    
    [DMNetworkTrafficManager start];
    FunctionRequest *request = [[FunctionRequest alloc]init];
    request.cacheConfig = [[ICacheConfig alloc]init];
    [request.cacheConfig setIsRead:YES];
    [request.cacheConfig setIsSave:YES];
    [[IHttpRequest shareRequest] sendRequest:request progress:^(NSProgress *progress) {
        
    } success:^(id result, BOOL isCache) {
        NSLog(@"%@", [NSString stringWithFormat:@"%@", result]);
        NSLog(@"请求成功%@", request);
        [DMNetworkTrafficManager end];
        
        NSLog(@"上行：%lld", [TDNetFlowDataSource shareInstance].uploadFlow);
        NSLog(@"下行：%lld", [TDNetFlowDataSource shareInstance].downFlow);
        [[TDNetFlowDataSource shareInstance] clear];
        
    } failure:^(NSError *error) {
        NSLog(@"请求失败%@", error);
        [DMNetworkTrafficManager end];
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // [self performSelector:@selector(string) withObject:nil afterDelay:0];

    /*
    [ShowHUD showTextOnly:@"YouXianMing"
                  configParameter:^(ShowHUD *config) {
                      config.animationStyle  = ZoomOut;  // 设置动画方式
                      config.margin          = 0.f;     // 边缘留白
                      config.opacity         = 1.f;     // 设定透明度
                      config.cornerRadius    = 15.f;     // 设定圆角
                      config.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1.0];  // 设置背景色
                      config.labelColor      = [[UIColor orangeColor] colorWithAlphaComponent:1.0];// 设置文本颜色
                  } duration:1.5 inView:self.view];
     */
    

    /*
    [ShowHUD showCustomView:^UIView *{
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhite)];
        //设置小菊花的frame
        // indicator.frame = CGRectMake(100, 100, 100, 100);
        //设置小菊花颜色
        // indicator.color = [UIColor redColor];
        //设置背景颜色
        //indicator.backgroundColor = [UIColor cyanColor];
        //刚进入这个界面会显示控件，并且停止旋转也会显示，只是没有在转动而已，没有设置或者设置为YES的时候，刚进入页面不会显示
        // indicator.hidesWhenStopped = NO;
        [indicator startAnimating];
        return indicator;
        
    } configParameter:^(ShowHUD *config) {
         config.animationStyle  = ZoomOut;  // 设置动画方式
         config.margin          = 0.f;     // 边缘留白
         config.opacity         = 1.f;     // 设定透明度
         config.cornerRadius    = 15.f;     // 设定圆角
         config.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:1.0];  // 设置背景色
         config.labelColor      = [[UIColor orangeColor] colorWithAlphaComponent:1.0];// 设置文本颜色
    } inView:self.view];
     */
    
    
}


- (void) setupUI {
    
    UIView *redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    /*
    [redView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [redView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [redView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [redView autoPinEdgeToSuperviewEdge:ALEdgeRight];
     */
    
    /*
    [redView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
     */
    
    /*
    [redView autoCenterInSuperview];
    [redView autoSetDimensionsToSize:CGSizeMake(100, 100)];
     */
    
    /*
    [redView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [redView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [redView autoSetDimensionsToSize:CGSizeMake(100, 100)];
    */
    
    /*
    [redView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [redView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [redView autoSetDimensionsToSize:CGSizeMake(100, 100)];
     */
    
    /*
     //蓝色view的左边,距离红色view的右边为30
     [self.blueView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.redView withOffset:30];
     //蓝色view,红色view等宽等高
     [@[self.blueView,self.redView] autoMatchViewsDimension:ALDimensionWidth];
     [@[self.blueView,self.redView] autoMatchViewsDimension:ALDimensionHeight];
     //蓝色view,红色view水平对齐
     [self.blueView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.redView];
     
     */
    
    /*
     //蓝色View的高度是红色View高度的一半
     [self.blueView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.redView withMultiplier:0.5];
     */
    
    /*
     NSArray *colorViews = @[self.redView, self.blueView, self.purpleView, self.greenView];
     [colorViews autoSetViewsDimension:ALDimensionHeight toSize:40.f];
     //间距为10,水平对齐,依次排列
     [colorViews autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeHorizontal withFixedSpacing:10.0 insetSpacing:YES matchedSizes:YES];
     //红色view相对于其父view水平对齐
     [self.redView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
     */
}


@end
