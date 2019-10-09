//
//  MZImageCell.h
//  TableViewLoadDemo
//
//  Created by midland on 2019/10/9.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MZImageModel;

/**
 关于动态获取网络图片的宽高
 */
@interface MZImageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;

- (void)setImageWithModel: (MZImageModel*)model;

@end

