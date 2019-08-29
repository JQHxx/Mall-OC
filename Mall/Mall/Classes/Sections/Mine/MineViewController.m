//
//  MineViewController.m
//  Mall
//
//  Created by midland on 2019/8/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "MineViewController.h"
#import "SonicWebViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = @"我的";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    SonicWebViewController *webVC = [[SonicWebViewController alloc]initWithUrl:@"https://www.baidu.com" useSonicMode:YES unStrictMode:YES];
    [self.navigationController pushViewController:webVC animated:YES];
}


@end
