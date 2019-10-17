//
//  NSDate+Format.m
//  Mall
//
//  Created by midland on 2019/10/17.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "NSDate+Format.h"


@implementation NSDate (Format)

+ (NSDateFormatter *)shareDateFormatter {
    static NSDateFormatter *sharedDateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDateFormatter = [[NSDateFormatter alloc]init];
    });
    return sharedDateFormatter;
}

@end
