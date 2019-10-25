//
//  RetainCycleLoggerPlugin.h
//  Mall
//
//  Created by midland on 2019/10/16.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBMemoryProfiler/FBMemoryProfiler.h>

NS_ASSUME_NONNULL_BEGIN

@interface RetainCycleLoggerPlugin : NSObject <FBMemoryProfilerPluggable>

@end

NS_ASSUME_NONNULL_END
