//
//  UIImageView+SDWebImage.h
//  Mall
//
//  Created by midland on 2019/8/27.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <UIKit/UIKit.h>

//获取网络图片成功:
typedef void(^DownloadImageSuccessBlock)(UIImage *image);
//获取网络图片失败:
typedef void (^DownloadImageFailedBlock)(NSError *error);
//获取下载图片进度:
typedef void (^DownloadImageProgressBlock)(CGFloat progress);

@interface UIImageView (SDWebImage)

/**
 *  异步加载图片
 *
 *  @param url       图片地址
 *  @param imageName 占位图片名
 */
- (void)downloadImage:(NSString *)url placeholder:(NSString *)imageName;


/**
 *  异步加载图片，可以监听下载进度，成功或失败
 *
 *  @param url       图片地址
 *  @param imageName 占位图片名
 *  @param success   下载成功
 *  @param failed    下载失败
 *  @param progress  下载进度
 */
- (void)downloadImage:(NSString *)url
          placeholder:(NSString *)imageName
              success:(DownloadImageSuccessBlock)success
               failed:(DownloadImageFailedBlock)failed
             progress:(DownloadImageProgressBlock)progress;

@end

