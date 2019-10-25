//
//  AnimationUtil.m
//  DataStructureDemo
//
//  Created by hello on 2018/6/15.
//  Copyright © 2018年 wupeng. All rights reserved.
//

#import "AnimationUtil.h"
#import <QuartzCore/QuartzCore.h>

@implementation AnimationUtil

+ (CABasicAnimation *)translationAnimation:(CGPoint)fromPoint toPoint:(CGPoint)toPoint{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    // 动画选项的设定
    animation.duration = 1; // 持续时间
    animation.repeatCount = 0; // 重复次数
    
    // 起始帧和终了帧的设定
    animation.fromValue = [NSValue valueWithCGPoint:fromPoint]; // 起始帧
    animation.toValue = [NSValue valueWithCGPoint:toPoint]; // 终了帧
    
    // 动画结束后不变回初始状态
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    return animation;
}

//旋转动画
+ (CABasicAnimation *)rotateAnimation:(CGFloat)formValue toValue:(CGFloat)toValue{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    // 设定动画选项
    animation.duration = 1; // 持续时间
    animation.repeatCount = 1; // 重复次数
    // 设定旋转角度
    animation.fromValue = [NSNumber numberWithFloat:formValue*M_PI/180]; // 起始角度
    animation.toValue = [NSNumber numberWithFloat: toValue*M_PI/180]; // 终止角度
    
    // 动画结束后不变回初始状态
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    return animation;
}

@end
