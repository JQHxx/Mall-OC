//
//  FunctionViewController.m
//  Mall
//
//  Created by midland on 2019/8/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "FunctionViewController.h"
#import "FunctionRequest.h"

@interface FunctionViewController ()

@end

@implementation FunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    
    FunctionRequest *request = [[FunctionRequest alloc]init];
    request.cacheConfig = [[ICacheConfig alloc]init];
    [request.cacheConfig setIsRead:YES];
    [request.cacheConfig setIsSave:YES];
    [[IHttpRequest shareRequest] sendRequest:request progress:^(NSProgress *progress) {
        
    } success:^(id result, BOOL isCache) {
        NSLog(@"%@", [NSString stringWithFormat:@"%@", result]);
        NSLog(@"请求成功%@", request);
    } failure:^(NSError *error) {
        NSLog(@"请求失败%@", error);
    }];
    
}


@end
