//
//  MineViewController.m
//  Mall
//
//  Created by midland on 2019/8/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "MineViewController.h"
#import "BaseWebBrowserViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = @"我的";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@"objc"];
    [array addObject:@"swift"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"key"] = @"value";
    // dict[@"itmes"] = array;
    NSString *json = [JSONUtil queryStringFrom:dict];
    NSLog(@"json: %@", json);
    json = [JSONUtil clearParams:json];
    NSLog(@"json: %@", json);
    
    
    NSString *json1 = [JSONUtil dictToJSON:dict];
    NSLog(@"json1: %@", json1);
    json1 = [JSONUtil clearParams:json1];
    NSLog(@"json2: %@", json1);
    
    /*
    BaseWebBrowserViewController *webVC = [[BaseWebBrowserViewController alloc]init];
    [webVC loadWeb:@"https://www.baidu.com" loadType: WKWebViewLoadTypeRemote title:@"百度首页"];
    [self.navigationController pushViewController:webVC animated:YES];
     */
}


@end
