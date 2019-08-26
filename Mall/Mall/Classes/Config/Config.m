//
//  Config.m
//  Mall
//
//  Created by midland on 2019/8/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "Config.h"

@implementation Config
SingletonM(Config)
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSString *)getQqAppId {
    return @"";
}

- (NSString *)getQqAppKey {
    return @"";
}

@end
