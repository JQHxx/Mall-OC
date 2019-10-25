//
//  UIScrollView+MJ.h
//  Mall
//
//  Created by midland on 2019/10/14.
//  Copyright © 2019 JQHxx. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MJHeaderBlock)(void);
typedef void(^MJFooterBlock)(void);

@interface UIScrollView (MJ)

/**
 @brief 下拉刷新回调
 */
- (void) headerRefresh: (MJHeaderBlock) block;

/**
@brief 上拉刷新回调
*/
- (void) footerRefresh: (MJHeaderBlock) block;

@end

NS_ASSUME_NONNULL_END
