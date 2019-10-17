//
//  DarkModel.h
//  Mall
//
//  Created by midland on 2019/10/15.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DarkModel : NSObject

/**
 是否 暗景模式
*/
+ (BOOL)isDarkMode;

/**
 解决Image拉伸问题
 */
+ (void)fixResizableImage;

@end

NS_ASSUME_NONNULL_END
