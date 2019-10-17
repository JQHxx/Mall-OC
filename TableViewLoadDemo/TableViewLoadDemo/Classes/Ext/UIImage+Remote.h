//
//  UIImage+Core.h
//  TableViewLoadDemo
//
//  Created by midland on 2019/10/9.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Remote)

/**
 获取在线图片的尺寸
 */
+(CGSize)downloadImageSizeWithURL:(id)imageURL;

@end

NS_ASSUME_NONNULL_END
