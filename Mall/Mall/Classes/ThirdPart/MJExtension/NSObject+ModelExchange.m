//
//  NSObject+ModelExchange.m
//  Mall
//
//  Created by midland on 2019/9/30.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "NSObject+ModelExchange.h"
#import <MJExtension.h>
#import <objc/runtime.h>

@implementation NSObject (ModelExchange)

+ (void)load {
    Method method1 = class_getInstanceMethod([self class], @selector(mj_keyValuesWithKeys:));
    Method method2 = class_getInstanceMethod([self class], @selector(my_modelSetWithDictionary:));
    method_exchangeImplementations(method1, method2);
}

- (BOOL)my_modelSetWithDictionary:(NSDictionary *)dic {
    NSMutableDictionary *mDictionary = [NSMutableDictionary dictionary];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            NSNumber *num = (NSNumber *)obj;
            NSNumberFormatter *formatter = [NSNumberFormatter new];
            formatter.numberStyle = NSNumberFormatterDecimalStyle;
            [formatter setGroupingSeparator:@""];
            NSString *str = [formatter stringFromNumber:num];
            [mDictionary setValue:str forKey:key];
        } else {
            [mDictionary setValue:obj forKey:key];
        }
    }];
    return [self my_modelSetWithDictionary:mDictionary];
}

@end
