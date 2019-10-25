//
//  UIView+Radius.m
//  Mall
//
//  Created by midland on 2019/10/17.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "UIView+Radius.h"
#import <QuartzCore/QuartzCore.h>


@implementation UIView (Radius)

-(void)bf_setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius {
    CGRect rect = self.bounds;
    
    // Create the path
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(radius, radius)];
    
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    
    // Set the newly created shape layer as the mask for the view's layer
    self.layer.mask = maskLayer;
}

@end
