//
//  UserInfoViewController.m
//  Mall
//
//  Created by HJQ on 2019/12/20.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "UserInfoViewController.h"

typedef void(^FinishBlock)(void);

@interface UserInfoViewController ()

@property (nonatomic, copy) FinishBlock block;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _block = ^{
        NSLog(@"%@",self);
    };
    _block();
    [self addTimer];
    // Do any additional setup after loading the view.
}

- (void) addTimer {
    //self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countAction) userInfo:nil repeats:YES];
}

- (void) countAction {

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
