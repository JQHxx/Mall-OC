//
//  UIImage+Trait.h
//  Mall
//
//  Created by midland on 2019/9/30.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Trait)

/**
 解决黑暗模式拉伸的问题
 */
+ (void)fixResizableImage;

@end

NS_ASSUME_NONNULL_END
