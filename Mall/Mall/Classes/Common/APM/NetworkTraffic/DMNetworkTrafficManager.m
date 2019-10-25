//
//  DMNetworkTrafficManager.m
//  Mall
//
//  Created by midland on 2019/9/27.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "DMNetworkTrafficManager.h"
#import "DMURLProtocol.h"

@interface DMNetworkTrafficManager ()

@end

@implementation DMNetworkTrafficManager

#pragma mark - Public

+ (DMNetworkTrafficManager *)manager {
    static DMNetworkTrafficManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[DMNetworkTrafficManager alloc] init];
    });
    return manager;
}

+ (void)startWithProtocolClasses:(NSArray *)protocolClasses {
    [self manager].protocolClasses = protocolClasses;
    [DMURLProtocol start];
}

+ (void)start {
     [self manager].protocolClasses = @[[DMURLProtocol class]];
    [DMURLProtocol start];
}

+ (void)end {
    [DMURLProtocol end];
}

@end
