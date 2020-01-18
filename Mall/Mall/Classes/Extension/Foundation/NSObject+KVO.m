//
//  NSObject+KVO.m
//  BFAlertViewController
//
//  Created by  on 2019/12/28.
//  Copyright © 2019 . All rights reserved.
//

#import "NSObject+KVO.h"
#import <objc/runtime.h>

@implementation NSObject (KVO)

+ (void)load{
    [self switchMethod];
}

+ (void)switchMethod{

    SEL removeSel = @selector(removeObserver:forKeyPath:);
    SEL myRemoveSel = @selector(removeDasen:forKeyPath:);
    
    Method systemRemoveMethod = class_getClassMethod([self class],removeSel);
    Method DasenRemoveMethod = class_getClassMethod([self class], myRemoveSel);
    method_exchangeImplementations(systemRemoveMethod, DasenRemoveMethod);
}

/**
 防止kvo多次移除引发的问题
 */
- (void)removeDasen:(NSObject *)observer forKeyPath:(NSString *)keyPath{
    @try {
        [self removeDasen:observer forKeyPath:keyPath];
    } @catch (NSException *exception) {
    }
}
@end
