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
    [TopBannerNotificationsUtils alertWithMessage:@"退出登录"];
}


@end
