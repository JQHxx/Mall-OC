//
//  Target_Function.m
//  Mall
//
//  Created by HJQ on 2019/10/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "Target_Function.h"
#import "FunctionViewController.h"

@implementation Target_Function

- (UIViewController *) Action_FunctionController: (NSDictionary *) params {
    FunctionViewController *VC = [[FunctionViewController alloc]init];
    VC.view.backgroundColor = [UIColor orangeColor];
    return VC;
}

@end
