//
//  ONLMoudleA.m
//  Mall
//
//  Created by midland on 2019/10/17.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "ONLMoudleA.h"
#import "ONLDynamicLoader.h"

@implementation ONLMoudleA

+ (instancetype)shareMoudeleA {
    static id shareMoudeleA = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        // alloc & init work
        shareMoudeleA = [[self alloc]init];
    });
    
    return shareMoudeleA;
}

- (void)setUP{
    NSLog(@"ONLMoudleA 启动了");
}

// 根据实际的项目需求做到可插拔、解耦合、可复用等等等的问题
CRDYML_FUNCTIONS_EXPORT_BEGIN(LEVEL_B)
[[ONLMoudleA shareMoudeleA]setUP];
CRDYML_FUNCTIONS_EXPORT_END(LEVEL_B)

@end
