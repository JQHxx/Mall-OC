//
//  NSArray+Safe.m
//  Mall
//
//  Created by HJQ on 2019/12/24.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "NSArray+Safe.h"
#import "NSObject+Runtime.h"

@implementation NSArray (Safe)

+ (void)load{

static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{

        // NSArray 是一个类簇,具体有三个子类__NSArray0,__NSSingleObjectArrayI,__NSArrayI,

        // 还有一个__NSPlaceholderArray是占位的,不实际使用
        // 对__NSArray0,__NSSingleObjectArrayI来说,下面三种调用的同一个方法objectAtIndex

        /** 对__NSArrayI,__NSArrayM来说,objectAtIndex 和 objectAtIndexedSubscript 有不同的实现,
         array[22]调用了objectAtIndexedSubscript */

        //[array objectAtIndex:22];

        //[array objectAtIndexedSubscript:22];

        //array[22];

        [objc_getClass("__NSArray0") swizzleMethod:@selector(objectAtIndex:) swizzledSelector:@selector(emptyObjectIndex:)];

        [objc_getClass("__NSSingleObjectArrayI") swizzleMethod:@selector(objectAtIndex:) swizzledSelector:@selector(singleObjectIndex:)];

        [objc_getClass("__NSArrayI") swizzleMethod:@selector(objectAtIndex:) swizzledSelector:@selector(safe_arrObjectIndex:)];

        [objc_getClass("__NSArrayI") swizzleMethod:@selector(objectAtIndexedSubscript:) swizzledSelector:@selector(safe_objectAtIndexedSubscript:)];


        [objc_getClass("__NSArrayM") swizzleMethod:@selector(objectAtIndex:) swizzledSelector:@selector(safeObjectIndex:)];

        [objc_getClass("__NSArrayM") swizzleMethod:@selector(objectAtIndexedSubscript:) swizzledSelector:@selector(mutableArray_safe_objectAtIndexedSubscript:)];

        [objc_getClass("__NSArrayM") swizzleMethod:@selector(insertObject:atIndex:) swizzledSelector:@selector(safeInsertObject:atIndex:)];

        [objc_getClass("__NSArrayM") swizzleMethod:@selector(addObject:) swizzledSelector:@selector(safeAddObject:)];

    });

}

- (id)emptyObjectIndex:(NSInteger)index {

    NSLog(@"__NSArray0 取一个空数组 objectAtIndex , 崩溃") ;

    return nil;

}

- (id)singleObjectIndex:(NSInteger)index {

    if (index >= self.count || index < 0) {

        NSLog(@"__NSSingleObjectArrayI 取一个不可变单元素数组时越界 objectAtIndex , 崩溃") ;

        return nil;

    }

    return [self singleObjectIndex:index];

}

- (id)safe_arrObjectIndex:(NSInteger)index{

    if (index >= self.count || index < 0) {

        NSLog(@"__NSArrayI 取不可变数组时越界 objectAtIndex , 崩溃") ;

        return nil;

    }

    return [self safe_arrObjectIndex:index];
}

- (id)safe_objectAtIndexedSubscript:(NSInteger)index{

    if (index >= self.count || index < 0) {

        NSLog(@"__NSArrayI 取不可变数组时越界 objectAtIndexedSubscript , 崩溃") ;

        return nil;

    }

    return [self safe_objectAtIndexedSubscript:index];
}

- (id)mutableArray_safe_objectAtIndexedSubscript:(NSInteger)index{

    if (index >= self.count || index < 0) {

        NSLog(@"__NSArrayM 取可变数组时越界 objectAtIndexedSubscript , 崩溃") ;

        return nil;

    }

    return [self mutableArray_safe_objectAtIndexedSubscript:index];
}

- (id)safeObjectIndex:(NSInteger)index{

    if (index >= self.count || index < 0) {

        NSLog(@"__NSArrayM 取可变数组时越界 objectAtIndex , 崩溃") ;

        return nil;

    }

    return [self safeObjectIndex:index];

}

- (void)safeInsertObject:(id)object atIndex:(NSUInteger)index{

    if (index>self.count) {

        NSLog(@"__NSArrayM 添加元素越界 insertObject:atIndex: , 崩溃") ;

        return ;

    }

    if (object == nil) {

        NSLog(@"__NSArrayM 添加空元素 insertObject:atIndex: , 崩溃") ;

        return ;

    }

    [self safeInsertObject:object atIndex:index];

}

- (void)safeAddObject:(id)object {

    if (object == nil) {

        NSLog(@"__NSArrayM 添加空元素 addObject , 崩溃") ;

        return ;

    }
    [self safeAddObject:object];

}


@end
