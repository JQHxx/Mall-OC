//
//  ViewController.m
//  面向协议开发Demo
//
//  Created by jaime on 2019/9/20.
//  Copyright © 2019 qinghua.ios. All rights reserved.
//

#import "ViewController.h"
#import "ModelConfigProtocol.h"
#import "ArrayDataSource.h"
#import "BaseModel.h"
#import "BaseCell.h"

@interface ViewController ()<ArrayDataSourceDelegate, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) ArrayDataSource *arrayDataSource;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation ViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.arrayDataSource.items = self.dataArray;
    self.tableView.dataSource = self.arrayDataSource;
    self.tableView.delegate = self;
}

#pragma mark - ArrayDataSourceDelegate
- (void)configureCell:(id)cell withItem:(id<ModelConfigProtocol>)item {
    
    //设置cell的属性
    if ([[item cellType] isEqualToString:@"BaseCell"]) {
        [((BaseCell *)cell) setModel:item];
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BaseModel *baseModel = [self.arrayDataSource itemAtIndexPath:indexPath];
    NSLog(@"%@", baseModel.text);
    
    /*
    NSInvocation *doWhat = self.strategies[baseModel.text];
    [doWhat invoke];
     */
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = UIColor.redColor;
    return view;
}

/*
// 一、使用策略处理事件
// 1.将复杂的业务逻辑包装成invocation,这里传入的每天做的事,例如playBasketball
- (NSInvocation *)invocationWithMethod:(SEL)selector{
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:selector];
    if (!signature) {
        // 传入的方法不存在 就抛异常
       NSString*info = [NSString stringWithFormat:@"-[%@ %@]:unrecognized selector sent to instance",[self class],NSStringFromSelector(selector)];
        @throw [[NSException alloc] initWithName:@"方法没有" reason:info userInfo:nil];
        return nil;
    }
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = selector;
    return invocation;
}

// 2.将每天做的事进行整合
- (NSDictionary *)strategies{
   NSDictionary *Strategies = @{
                           @"0" : [self invocationWithMethod:@selector(playBasketball)],
                           @"1" : [self invocationWithMethod:@selector(shopping)],
                           @"2" : [self invocationWithMethod:@selector(washClothes)],
                           @"3" : [self invocationWithMethod:@selector(playGames)],
                           @"4" : [self invocationWithMethod:@selector(sing)],
                           @"5" : [self invocationWithMethod:@selector(watchMovie)],
                           @"6" : [self invocationWithMethod:@selector(climbing)],
                           };
   return Strategies;
}

#pragma mark - event response
- (void) playBasketball {
    
}

- (void) shopping {
    
}

- (void) washClothes {
    
}

- (void) playGames {
    
}

- (void) sing {
    
}

- (void) watchMovie {
    
}

- (void) climbing {
    
}
 */

// 二、表驱动法
- (void) handleIndex: (NSIndexPath *) indexPath {
    //只需要维护这个字典即可
     NSArray *arr = @[
              @{
                //跳转的类名
                 @"only_className":@"ViewController",
                 //携带的参数
                 @"index":@(2),
              },
              @{
                  @"only_className":@"ViewController",
                  @"index":@(2),
              },
              @{
                   @"only_className":@"ViewController",
                   @"index":@(2),
              },
              @{
                   @"only_className":@"ViewController",
                   @"index":@(2),
              },
              @{
                  @"only_className":@"ViewController",
                  @"index":@(2),
              },
     ];
    NSDictionary *keyDic = arr[indexPath.row];
    //getClassNames方法 是我写的一个工具类方法 根据类名和传递的参数获取对应的对象
     if (keyDic) {
         UIViewController * vc = (UIViewController *)NSClassFromString(keyDic[@"only_className"]);
        [self.navigationController pushViewController:vc animated:YES];
     }
}

#pragma mark - getter
- (ArrayDataSource *)arrayDataSource {
    
    if (!_arrayDataSource) {
        _arrayDataSource = [[ArrayDataSource alloc] init];
        _arrayDataSource.delegate = self;
    }
    
    return _arrayDataSource;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray array];
        
        //模拟数据
        NSMutableArray *tmpArray = [NSMutableArray array];
        for (int i = 0; i<7; i++) {
            BaseModel *baseModel = [[BaseModel alloc] init];
            baseModel.text = [NSString stringWithFormat:@"%d",i];
            [tmpArray addObject:baseModel];
        }
        _dataArray = tmpArray;
    }
    return _dataArray;
}

@end
