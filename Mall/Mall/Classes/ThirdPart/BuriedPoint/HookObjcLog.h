//
//  HookObjcLog.h
//  Mall
//
//  Created by midland on 2019/10/9.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HookObjcLog : NSObject

+ (HookObjcLog *)shareInstance;

/**
 记录hook的方法
 @param cls 当前类
 @param identifier 标识符
 */
- (void)recordHookClass:(Class)cls
             identifier:(NSString *)identifier;
/**
 记录Buton点击的方法
 
 @param cls 当前类
 @param identifier 标识符
 */
- (void)recordLogActionHookClass:(Class)cls
                          action:(SEL)action
                      identifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
