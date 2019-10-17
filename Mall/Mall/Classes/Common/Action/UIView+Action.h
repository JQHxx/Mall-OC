//
//  UIView+Action.h
//  Mall
//
//  Created by midland on 2019/10/17.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^BFGestureActionBlock)(UIGestureRecognizer * _Nullable gestureRecoginzer);

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Action)

/**
 *  @brief  添加tap手势
 *
 *  @param block 代码块
 */
- (void)bf_addTapActionWithBlock:(BFGestureActionBlock)block;
/**
 *  @brief  添加长按手势
 *
 *  @param block 代码块
 */
- (void)bf_addLongPressActionWithBlock:(BFGestureActionBlock)block;

@end

NS_ASSUME_NONNULL_END
