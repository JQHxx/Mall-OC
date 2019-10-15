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
{
    UILabel *label;
}
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = @"我的";
    [self setupUI];
}

- (void) setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    label.text = @"ViewController 跟随手机进行暗黑适配";
    label.font = [UIFont systemFontOfSize:20.0];
    label.numberOfLines = 0;
    [self.view addSubview:label];
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

// 系统模式切换才会改变
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    NSLog(@"traitCollectionDidChange");
    
    self.view.backgroundColor = [UIColor adaptColor:[UIColor redColor] darkColor:[UIColor blackColor]];
    label.textColor = [UIColor adaptColor:[UIColor redColor] darkColor:[UIColor darkGrayColor]];

}

// 单个界面不遵循暗黑模式
//- (UIUserInterfaceStyle)overrideUserInterfaceStyle {
//    return [DarkModel isDarkMode] ? UIUserInterfaceStyleDark : UIUserInterfaceStyleLight;
//}


@end
