//
//  NSTimer+AutoIncalidate.h
//  Mall
//
//  Created by midland on 2019/9/20.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ZDTimeTargetBlock)(NSTimer *timer);

/**
 自动释放的定时器
 */
@interface ZDTimerTarget : NSObject
@end

@interface NSTimer (AutoIncalidate)
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti
                                      block:(ZDTimeTargetBlock)block
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)isRepeats
                                existObject:(id)existObj;
- (void)pauseTimer;
- (void)resumeTimer;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;
@end
