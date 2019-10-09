//
//  ViewController.m
//  TableViewLoadDemo
//
//  Created by midland on 2019/10/9.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "ViewController.h"
#import "MZImageCell.h"
#import "MZImageModel.h"
#import "UIImage+Core.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self setupUI];
    [self setupDatas];
    
}

#pragma makr: - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MZImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MZImageCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"MZImageCell" owner:nil options:nil].firstObject;
    }
    MZImageModel * model = self.datas[indexPath.row];
    if (model.isLoad) {
        [cell setImageWithModel:model];
    }else{
        [cell setImageWithModel:nil];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark: - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MZImageModel * model = self.datas[indexPath.row];
    if (model.cellHeight == 0) {
        CGSize size = [UIImage downloadImageSizeWithURL:model.picUrl];
        NSLog(@"%@", NSStringFromCGSize(size));
        CGFloat height = UIScreen.mainScreen.bounds.size.width * size.height / size.width;
        model.cellHeight = height;
    }
    return model.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self loadShowCells];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        //滑动时,加载占位图
        [self loadShowCells];
    }
}

#pragma mark: - Private methods
-(void)loadShowCells{
    NSArray * array = [self.tableView indexPathsForVisibleRows];
    for (NSIndexPath *indexPath in array) {
        MZImageCell * cell = (MZImageCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        MZImageModel * model = self.datas[indexPath.row];
        [cell setImageWithModel:model];
    }
}

- (void) setupDatas {
    
    NSMutableArray *tempDatas = [NSMutableArray array];
    for (int i = 0; i < 50; i++) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        if(i % 2 == 0) {
            dict[@"picUrl"] = @"http://e.hiphotos.baidu.com/image/pic/item/e850352ac65c1038776fc83db8119313b07e893f.jpg";
        } else {
            dict[@"picUrl"] = @"http://a.hiphotos.baidu.com/image/pic/item/a50f4bfbfbedab64bb824a3ffd36afc378311e58.jpg";
        }
        [tempDatas addObject:dict];
    }
    for (NSDictionary *homeDic in tempDatas) {
        MZImageModel *model =[[MZImageModel alloc] init];
        [model setValuesForKeysWithDictionary:homeDic];
        model.isLoad = NO;//装到数组中，先不下载
        [self.datas addObject:model];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //让tableView准备好后，再显示
            [self loadShowCells];
        });
    }
}

- (void) setupUI {
    self.tableView.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
    [self.view addSubview:self.tableView];
}

#pragma mark: - Lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerNib:[UINib nibWithNibName:@"MZImageCell" bundle:nil] forCellReuseIdentifier:@"MZImageCell"];
        tableView.tableFooterView = nil;
        _tableView = tableView;
    }
    return _tableView;
}

- (NSMutableArray *)datas {
    if (! _datas) {
        NSMutableArray *datas = [NSMutableArray array];
        _datas = datas;
    }
    return _datas;
}


@end
