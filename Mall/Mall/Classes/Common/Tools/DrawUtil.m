//
//  DrawUtil.m
//  DataStructureDemo
//
//  Created by hello on 2018/6/13.
//  Copyright © 2018年 wupeng. All rights reserved.
//

#import "DrawUtil.h"
#import <UIKit/UIKit.h>

@implementation DrawUtil

- (CAShapeLayer *)drawDotteArc:(CGRect)frame{
    /*
     *画虚线圆
     */
    CAShapeLayer *dotteLine =  [CAShapeLayer layer];
    CGMutablePathRef dottePath =  CGPathCreateMutable();
    dotteLine.lineWidth = 2.0f ;
    dotteLine.strokeColor = [UIColor orangeColor].CGColor;
    dotteLine.fillColor = [UIColor clearColor].CGColor;
    CGPathAddEllipseInRect(dottePath, nil, frame);
    dotteLine.path = dottePath;
    NSArray *arr = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:10],[NSNumber numberWithInt:5], nil];
    dotteLine.lineDashPhase = 1.0;
    dotteLine.lineDashPattern = arr;
    CGPathRelease(dottePath);
    
    return dotteLine;
}

- (CAShapeLayer *)drawSolidArc:(CGRect)frame{
    /*
     *画实线圆
     */
    CAShapeLayer *solidLine =  [CAShapeLayer layer];
    CGMutablePathRef solidPath =  CGPathCreateMutable();
    solidLine.lineWidth = 2.0f ;
    solidLine.strokeColor = [UIColor orangeColor].CGColor;
    solidLine.fillColor = [UIColor clearColor].CGColor;
    CGPathAddEllipseInRect(solidPath, nil, frame);
    solidLine.path = solidPath;
    CGPathRelease(solidPath);
    return solidLine;
}

- (CAShapeLayer *)drawSolidLine:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    /*
     *画实线
     */
    CAShapeLayer *solidShapeLayer = [CAShapeLayer layer];
    CGMutablePathRef solidShapePath =  CGPathCreateMutable();
    [solidShapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [solidShapeLayer setStrokeColor:[[UIColor orangeColor] CGColor]];
    solidShapeLayer.lineWidth = 2.0f ;
    CGPathMoveToPoint(solidShapePath, NULL, startPoint.x, startPoint.y);
    CGPathAddLineToPoint(solidShapePath, NULL, endPoint.x,endPoint.y);
    [solidShapeLayer setPath:solidShapePath];
    CGPathRelease(solidShapePath);
    return solidShapeLayer;
}
@end
