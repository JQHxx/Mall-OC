//
//  MessageViewController.m
//  Mall
//
//  Created by midland on 2019/8/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "MessageViewController.h"
#import "TopBannerNotificationsUtils.h"
#import "OperationGuideView.h"
#import "UIView+Action.h"

@interface MessageViewController () <UITableViewDataSource, UITableViewDelegate, BackButtonHandlerProtocol>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *button;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息";
     self.edgesForExtendedLayout = UIRectEdgeNone;
    
    OperationGuideView *guideView = [[OperationGuideView alloc]init];
    guideView.frame = self.view.bounds;
    [UIApplication.sharedApplication.delegate.window addSubview:guideView];
    
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.backgroundColor = [UIColor redColor];
    self.button.frame = CGRectMake(0, 0, 100, 50);
    @WeakSelf(self);
    /*
    [self.button handleEvent:UIControlEventTouchUpInside block:^(UIButton * _Nonnull btn) {
        @StrongSelf(weakSelf);
        NSLog(@"%@", strongSelf.view);
        MessageViewController *firstViewController = [[MessageViewController alloc] init];
        [strongSelf.navigationController pushViewController:firstViewController animated:YES];
    }];
     */
    [self.button bf_addTapActionWithBlock:^(UIGestureRecognizer * _Nullable gestureRecoginzer) {
        @StrongSelf(weakSelf);
        NSLog(@"%@", strongSelf.view);
        MessageViewController *firstViewController = [[MessageViewController alloc] init];
        [strongSelf.navigationController pushViewController:firstViewController animated:YES];
    }];
    // UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(invoke:)];
    // [self.button addGestureRecognizer:tapGes];
    [self.view addSubview:self.button];
    
    adjustsTableViewInsets_NO(self.tableView)
    // UIScrollViewContentInsetAdjustmentAlways
    // self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    // [self setupUI];
}

- (BOOL)navigationShouldPopOnBackButton {
    return YES;
}

- (void)invoke: (UIGestureRecognizer *) tapGes {
    
}

- (void)dealloc {
    
}

- (void) setupUI {
     self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:self.tableView];
   
    [self.tableView headerRefresh:^{

    }];
    [self.tableView footerRefresh:^{

    }];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MessageViewController *firstViewController = [[MessageViewController alloc] init];
    [self.navigationController pushViewController:firstViewController animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    return cell;
}

#pragma mark - Setter & Getter
- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        tableView.tableFooterView = [UIView new];
        _tableView = tableView;
    }
    return _tableView;
}


@end
