//
//  MessageViewController.m
//  Mall
//
//  Created by midland on 2019/8/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "MessageViewController.h"
#import "TopBannerNotificationsUtils.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = @"消息";
}
    
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // [TopBannerNotificationsUtils alertWithMessage:@"退出登录"];
    [self feedbackGenerator];
    /*
   NSString *result =  [@"1000000" convertAmount];
    NSLog(@"%@", result);
     */

}

/**
 @brief MJRefresh增加震动反馈
 // 增加KVO监听
 [_tableView.mj_header addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
 [_tableView.mj_footer addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
 
 - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
     
     if ([object isEqual:self.tableView.mj_header] && self.tableView.mj_header.state == MJRefreshStatePulling) {
         [self feedbackGenerator];
     }
     else if ([object isEqual:self.tableView.mj_footer] && self.tableView.mj_footer.state == MJRefreshStatePulling) {
         [self feedbackGenerator];
     }
 }
 
 */

- (void)feedbackGenerator {
    if (@available(iOS 10.0, *)) {
        UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
        [generator prepare];
        [generator impactOccurred];
    }
}


@end
