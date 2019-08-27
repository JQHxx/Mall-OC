//
//  UIImageView+SDWebImage.m
//  Mall
//
//  Created by midland on 2019/8/27.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "UIImageView+SDWebImage.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (SDWebImage)

#pragma mark - 下载图片
- (void)downloadImage:(NSString *)url placeholder:(NSString *)imageName
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:imageName] options:(SDWebImageRetryFailed | SDWebImageLowPriority)];
}


#pragma mark - 获取下载图片百分比的封装方法
- (void)downloadImage:(NSString *)url
          placeholder:(NSString *)imageName
              success:(DownloadImageSuccessBlock)success
               failed:(DownloadImageFailedBlock)failed
             progress:(DownloadImageProgressBlock)progress
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:imageName] options:(SDWebImageLowPriority | SDWebImageRetryFailed) progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
        NSLog(@"progress = %@" , @(receivedSize / expectedSize * 1.0f));
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (!error){
            NSLog(@"下载成功");
            self.image = image;
            //成功回调:把图片给我下载完成回调过来:
            success(image);
        }else{
            NSLog(@"下载失败");
            failed(error);
        }
        
    }];
}
@end
