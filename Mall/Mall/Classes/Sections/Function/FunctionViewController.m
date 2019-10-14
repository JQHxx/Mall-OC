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

@interface FunctionViewController ()

@end

@implementation FunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[BLStopwatch sharedStopwatch] splitWithType:BLStopwatchSplitTypeContinuous description:@"VDL0"];
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
    [[BLStopwatch sharedStopwatch] splitWithType:BLStopwatchSplitTypeContinuous description:@"VDL1"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[BLStopwatch sharedStopwatch] splitWithType:BLStopwatchSplitTypeContinuous description:@"VDAP"];
    [[BLStopwatch sharedStopwatch] stopAndPresentResultsThenReset];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // [self performSelector:@selector(string) withObject:nil afterDelay:0];
    
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
