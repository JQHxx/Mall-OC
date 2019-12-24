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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self testArray];
}

-(void)testArray{
    /** 不可变数组 */
    //角标越界
    //数组 = nil
    NSArray *array = nil;
    NSLog(@"array[1] = %@",array[2]);

    //count = 0
    NSArray *array1 = @[];
    NSLog(@"array1[1] = %@",array1[2]);

    //只有一个元素
    NSArray *array2 = @[@"123"];
    NSLog(@"array2[2] = %@",array2[2]);

    //多个元素
    NSArray *array3 = @[@"123",@"321",@"456"];
    NSLog(@"array3[8] = %@",array3[8]);

    
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
