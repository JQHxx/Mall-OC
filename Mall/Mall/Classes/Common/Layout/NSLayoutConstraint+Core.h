//
//  NSLayoutConstraint+Core.h
//  BFAlertViewController
//
//  Created by OFweek01 on 2020/1/2.
//  Copyright © 2020 OFweek01. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSLayoutConstraint (Core)

+ (NSArray<NSLayoutConstraint *> *)edgeInsetsConstraintWithItem:(UIView *)item toItem:(UIView *)toItem edgeInsets:(UIEdgeInsets)edgeInsets;

+ (NSLayoutConstraint *)topConstraintWithItem:(UIView *)item toItem:(UIView *)toItem constant:(CGFloat)constant;
+ (NSLayoutConstraint *)rightConstraintWithItem:(UIView *)item toItem:(UIView *)toItem constant:(CGFloat)constant;
+ (NSLayoutConstraint *)bottomContraintWithItem:(UIView *)item toItem:(UIView *)toItem constant:(CGFloat)constant;
+ (NSLayoutConstraint *)leftConstraintWithItem:(UIView *)item toItem:(UIView *)toItem constant:(CGFloat)constant;

+ (NSLayoutConstraint *)widthConstraintWithItem:(UIView *)item constant:(CGFloat)constant;
+ (NSLayoutConstraint *)widthConstraintWithItem:(UIView *)item toItem:(UIView *)toItem multiplier:(CGFloat)multiplier constant:(CGFloat)constant;
+ (NSLayoutConstraint *)heightConstraintWithItem:(UIView *)item constant:(CGFloat)constant;
+ (NSLayoutConstraint *)heightConstraintWithItem:(UIView *)item toItem:(UIView *)toItem multiplier:(CGFloat)multiplier constant:(CGFloat)constant;

+ (NSLayoutConstraint *)rightLeftContraintWithItem:(UIView *)item toItem:(UIView *)toItem constant:(CGFloat)constant;
+ (NSLayoutConstraint *)leftRightContraintWithItem:(UIView *)item toItem:(UIView *)toItem constant:(CGFloat)constant;

@end

NS_ASSUME_NONNULL_END


/**
 
 iOS 9  NSLayoutAnchor
 
 UILayoutGuide *spaceAB = [[UILayoutGuide alloc] init]; // 创建间距AB
 [self.view addLayoutGuide:spaceAB]; // 加入所在视图
  
 UILayoutGuide *spaceBC = [[UILayoutGuide alloc] init]; // 创建间距BC
 [self.view addLayoutGuide:spaceBC]; // 加入所在视图
  
 [spaceAB.widthAnchor constraintEqualToAnchor:spaceBC.widthAnchor].active = YES; // 间距AB和间距BC等宽
 [self.testView.trailingAnchor constraintEqualToAnchor: spaceAB.leadingAnchor].active = YES; // A的后边与间距AB前边对齐
 [self.testView.leadingAnchor constraintEqualToAnchor: spaceAB.trailingAnchor].active = YES; // B的前边与间距AB后边对齐
 [self.testView.trailingAnchor constraintEqualToAnchor:spaceBC.leadingAnchor].active = YES; // B的后边与间距BC前边对齐
 [self.testView.leadingAnchor constraintEqualToAnchor:spaceBC.trailingAnchor].active = YES;
 
 // [NSLayoutConstraint activateConstraints:@[]];
 */
