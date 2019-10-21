//
//  AnimationUtil.h
//  DataStructureDemo
//
//  Created by hello on 2018/6/15.
//  Copyright © 2018年 wupeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationUtil : UIView
+ (CABasicAnimation *)translationAnimation:(CGPoint)fromPoint toPoint:(CGPoint)toPoint;//平移动画
+ (CABasicAnimation *)rotateAnimation:(CGFloat)formValue toValue:(CGFloat)toValue;//旋转动画
@end
