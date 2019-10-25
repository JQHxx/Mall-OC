//
//  FingerDrawLineView.h
//  BaiDuMapDemo
//
//  Created by 朱佳男 on 2018/5/1.
//  Copyright © 2018年 朱佳男. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol FingerDrawLineViewDelegate<NSObject>
-(void)fingerDrawLineViewEndTouchWithPointArray:(NSArray*)pointArray;
@end;

/**
 画线，然后将坐标转换到地图上坐标，再通过地图Overlays（覆盖画线）
 */
@interface FingerDrawLineView : UIView
@property (nonatomic ,weak)id<FingerDrawLineViewDelegate>delegate;
/**
 线段颜色
 */
@property (nonatomic ,strong)UIColor *lineColor;

/**
 线段宽度
 */
@property (nonatomic ,assign)CGFloat lineWidth;

/**
 清空所画线段
 */
-(void)clearLine;
@end
