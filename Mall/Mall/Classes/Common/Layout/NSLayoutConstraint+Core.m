//
//  NSLayoutConstraint+Core.m
//  BFAlertViewController
//
//  Created by OFweek01 on 2020/1/2.
//  Copyright © 2020 OFweek01. All rights reserved.
//

#import "NSLayoutConstraint+Core.h"

@implementation NSLayoutConstraint (Core)

+ (NSLayoutConstraint *)widthConstraintWithItem:(UIView *)item constant:(CGFloat)constant {
    item.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:constant];
    return constraint;
}
 
+ (NSLayoutConstraint *)heightConstraintWithItem:(UIView *)item constant:(CGFloat)constant {
    item.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:constant];
    return constraint;
}

+ (NSLayoutConstraint *)widthConstraintWithItem:(UIView *)item toItem:(UIView *)toItem multiplier:(CGFloat)multiplier constant:(CGFloat)constant {
    item.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:toItem attribute:NSLayoutAttributeWidth multiplier:multiplier constant:constant];
    return constraint;
}
 
+ (NSLayoutConstraint *)heightConstraintWithItem:(UIView *)item toItem:(UIView *)toItem multiplier:(CGFloat)multiplier constant:(CGFloat)constant {
    item.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:toItem attribute:NSLayoutAttributeHeight multiplier:multiplier constant:constant];
    return constraint;
}

+ (NSArray<NSLayoutConstraint *> *)edgeInsetsConstraintWithItem:(UIView *)item toItem:(UIView *)toItem edgeInsets:(UIEdgeInsets)edgeInsets {
    item.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *topCons = [self topConstraintWithItem:item toItem:toItem constant:edgeInsets.top];
    NSLayoutConstraint *leftCons = [self leftConstraintWithItem:item toItem:toItem constant:edgeInsets.top];
    NSLayoutConstraint *rightCons = [self rightConstraintWithItem:item toItem:toItem constant:edgeInsets.top];
    NSLayoutConstraint *bottomCons = [self bottomContraintWithItem:item toItem:toItem constant:edgeInsets.top];
    return @[topCons, rightCons, bottomCons, leftCons];
}
 
+ (NSLayoutConstraint *)topConstraintWithItem:(UIView *)item toItem:(UIView *)toItem constant:(CGFloat)constant {
    item.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:toItem attribute:NSLayoutAttributeTop multiplier:1.0 constant:constant];
    return topConstraint;
}
 
+ (NSLayoutConstraint *)leftConstraintWithItem:(UIView *)item toItem:(UIView *)toItem constant:(CGFloat)constant {
    item.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:toItem attribute:NSLayoutAttributeLeft multiplier:1.0 constant:constant];
    return leftConstraint;
}
 
+ (NSLayoutConstraint *)rightConstraintWithItem:(UIView *)item toItem:(UIView *)toItem constant:(CGFloat)constant {
    item.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:toItem attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    return rightConstraint;
}
 
+ (NSLayoutConstraint *)bottomContraintWithItem:(UIView *)item toItem:(UIView *)toItem constant:(CGFloat)constant {
    item.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *bottomContraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:toItem attribute:NSLayoutAttributeBottom multiplier:1.0 constant:constant];
    return bottomContraint;
}
 
+ (NSLayoutConstraint *)centerXContraintWithItem:(UIView *)item toItem:(UIView *)toItem constant:(CGFloat)constant {
    item.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *xConstraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:toItem attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:constant];
    return xConstraint;
}
 
+ (NSLayoutConstraint *)centerYContraintWithItem:(UIView *)item toItem:(UIView *)toItem constant:(CGFloat)constant {
    item.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *yConstraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:toItem attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:constant];
    return yConstraint;
}
 
+ (NSLayoutConstraint *)rightLeftContraintWithItem:(UIView *)item toItem:(UIView *)toItem constant:(CGFloat)constant {
    item.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *rightLeftConstraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:toItem attribute:NSLayoutAttributeLeft multiplier:1.0 constant:constant];
    return rightLeftConstraint;
}
 
+ (NSLayoutConstraint *)leftRightContraintWithItem:(UIView *)item toItem:(UIView *)toItem constant:(CGFloat)constant {
    item.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *leftRightConstraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:toItem attribute:NSLayoutAttributeRight multiplier:1.0 constant:constant];
    return leftRightConstraint;
}

@end
