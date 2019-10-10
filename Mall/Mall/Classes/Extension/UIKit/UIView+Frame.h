//
//  UIView+Frame.h
//  Mall
//
//  Created by midland on 2019/10/10.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat bf_x;
@property (nonatomic, assign) CGFloat bf_y;
@property (nonatomic, assign) CGFloat bf_centerX;
@property (nonatomic, assign) CGFloat bf_centerY;
@property (nonatomic, assign) CGFloat bf_width;
@property (nonatomic, assign) CGFloat bf_height;
@property (nonatomic, assign) CGSize bf_size;

@end

NS_ASSUME_NONNULL_END
