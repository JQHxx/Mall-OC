//
//  CacheConfig.h
//  Mall
//
//  Created by midland on 2019/8/28.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICacheConfig : NSObject

/**
 * Many users cache
 */
@property (nonatomic, copy) NSString *userId;

/**
 * 缓存的有效时长（-1 为无限期 单位为秒 默认缓存7天 7 * 60 * 60 * 60）
 */
@property (nonatomic, assign) NSTimeInterval effectiveTime;

/**
 * 是否保存到本地
 */
@property (nonatomic, assign) BOOL isSave;

/**
 * 是否从本地读取
 */
@property (nonatomic, assign) BOOL isRead;

@end
