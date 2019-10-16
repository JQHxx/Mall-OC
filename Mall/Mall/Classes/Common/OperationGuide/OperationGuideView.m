//
//  OperationGuideView.m
//  Mall
//
//  Created by midland on 2019/10/16.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "OperationGuideView.h"

@implementation OperationGuideView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createTabbarHighlightAtIndex:0];
        [self viewBindEvents];
    }
    return self;
}

- (void) viewBindEvents {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
    [self addGestureRecognizer:tap];
}

- (void) singleTap: (UIGestureRecognizer *) tapGes {
    [self removeFromSuperview];
}

- (void)createTabbarHighlightAtIndex:(NSInteger)idx {

    UIBezierPath *bpath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];    // bezierPathByReversingPath表示反向绘制     （利用反向绘制掏出需要高亮的部分）
    
    // 需要判断是否是刘海屏
    CGFloat safeAreaBottom = 0;
    CGFloat tabbarItem_w = UIScreen.mainScreen.bounds.size.width / 4.0;
    CGFloat tabbarItem_h = 50.0;
    
    CGFloat startPoint_x = tabbarItem_w / 2.0 + idx * tabbarItem_w;
    // (((idx + 1.f) * 2.f - 1.f) / ((idx + 1.f) * 2.f) * (tabbarItem_w * (idx + 1.f)))

    UIBezierPath *reversingPath = [[UIBezierPath bezierPathWithArcCenter:CGPointMake(startPoint_x, UIScreen.mainScreen.bounds.size.height - safeAreaBottom - tabbarItem_h/2.f) radius:tabbarItem_h/2.f  startAngle:0 endAngle:M_PI * 2 clockwise:YES] bezierPathByReversingPath];
    [bpath appendPath: reversingPath];
    [bpath stroke];

    // 创建一个CAShapeLayer 图层，黑色半透明背景
    CAShapeLayer  *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [[UIColor blackColor] colorWithAlphaComponent:0.5].CGColor;
    shapeLayer.path = bpath.CGPath;
    [self.layer addSublayer:shapeLayer];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar_customerservice_h_b"]];
    [imageView sizeToFit];
    imageView.frame = CGRectMake(tabbarItem_w / 2, UIScreen.mainScreen.bounds.size.height - 50 - CGRectGetHeight(imageView.bounds), CGRectGetWidth(imageView.bounds), CGRectGetHeight(imageView.bounds));
    [self addSubview:imageView];
    
}

/*
- (void)createMemberManageHighlightAtIndex:(NSInteger)idx{

    UIBezierPath *bpath = [UIBezierPath bezierPathWithRect:CGRectMake(0.f, 0.f, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
    CGFloat item_interval = (UIScreen.mainScreen.bounds.size.width - 14.f * 2.f - 2.f * 25.f - 3.f * MemberManageItem_Highlight_W) * 0.5f;
    CGFloat itemMinx = 14.f + 25.f;
    // bezierPathByReversingPath表示反向绘制
    UIBezierPath *reversingPath = [[UIBezierPath bezierPathWithRoundedRect:CGRectMake((itemMinx + idx * (MemberManageItem_Highlight_W + item_interval)), (MemberCenterHeader_H - 95.f + 5.f), MemberManageItem_Highlight_W, MemberManageItem_Highlight_H) cornerRadius:5.f] bezierPathByReversingPath];

    [bpath appendPath: reversingPath];

    [bpath stroke];    //创建一个CAShapeLayer 图层，黑色半透明背景

    CAShapeLayer  *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [[UIColor blackColor] colorWithAlphaComponent:0.5].CGColor;                                                            shapeLayer.path = bpath.CGPath;
    [self.layer addSublayer:shapeLayer];
 }
 */

@end
