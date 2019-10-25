//
//  CacheCleanerPlugin.m
//  Mall
//
//  Created by midland on 2019/10/16.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "CacheCleanerPlugin.h"

@implementation CacheCleanerPlugin

- (void)memoryProfilerDidMarkNewGeneration {
  [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
