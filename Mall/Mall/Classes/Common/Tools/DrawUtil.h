//
//  DrawUtil.h
//  DataStructureDemo
//
//  Created by hello on 2018/6/13.
//  Copyright © 2018年 wupeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DrawUtil : NSObject
- (CAShapeLayer *)drawSolidArc:(CGRect)frame;
- (CAShapeLayer *)drawDotteArc:(CGRect)frame;
- (CAShapeLayer *)drawSolidLine:(CGPoint)startPoint endPoint:(CGPoint)endPoint;
@end
