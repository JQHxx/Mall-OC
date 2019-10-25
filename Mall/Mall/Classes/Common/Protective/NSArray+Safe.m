//
//  NSArray+Pro.m
//  Mall
//
//  Created by midland on 2019/10/16.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "NSArray+Safe.h"

@implementation NSArray (Safe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class __NSArrayI = NSClassFromString(@"__NSArrayI");
        Method originalMethod1 = class_getInstanceMethod(__NSArrayI, @selector(objectAtIndexedSubscript:));
        Method swizzledMethod1 = class_getInstanceMethod(__NSArrayI, @selector(my_objectAtIndexedSubscript:));
        method_exchangeImplementations(originalMethod1, swizzledMethod1);
    });
}

- (id)my_objectAtIndexedSubscript:(NSUInteger)idx {
    if (idx < 0 || idx >= self.count) {
        NSLog(@"数组越界了~~~~~");
        return self[0];
    }
    return [self my_objectAtIndexedSubscript:idx];
}

@end
