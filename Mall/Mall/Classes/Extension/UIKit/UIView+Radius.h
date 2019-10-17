//
//  UIView+Radius.h
//  Mall
//
//  Created by midland on 2019/10/17.
//  Copyright © 2019 JQHxx. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Radius)

/*
 *  Sets a corners
 */
-(void)bf_setRoundedCorners:(UIRectCorner)corners
                  radius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
