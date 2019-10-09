//
//  MZImageCell.m
//  TableViewLoadDemo
//
//  Created by midland on 2019/10/9.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "MZImageCell.h"
#import "MZImageModel.h"
#import "UIImageView+WebCache.h"

@implementation MZImageCell


- (void)setImageWithModel:(MZImageModel*)model {
    
    if(model == nil){ //如果模型为空，加载占位图
        
        [self.mainImageView setImage:[UIImage imageNamed:@"14.png"]];
        
    }else{//否则，请求图片
        
        [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:[UIImage imageNamed:@"14.png"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            [model setIsLoad:YES];//下载
        }];
        
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
