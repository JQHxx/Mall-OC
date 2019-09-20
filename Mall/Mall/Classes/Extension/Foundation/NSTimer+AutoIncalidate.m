//
//  NSTimer+AutoIncalidate.m
//  Mall
//
//  Created by midland on 2019/9/20.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "NSTimer+AutoIncalidate.h"

@interface ZDTimerTarget ()
@property (nonatomic ,weak)NSTimer *timer;  //注意是weak
@property (nonatomic,copy) ZDTimeTargetBlock block;
@property (nonatomic,weak) id existObj;  //注意是weak
@end

@implementation ZDTimerTarget

- (id)initWithTimerTargetBlock:(ZDTimeTargetBlock)block timer:(NSTimer *)timer existObj:(id)existObj {
    if (self = [super init]) {
        _block = block;
        _timer = timer;
        _existObj = existObj;
    }
    return self;
}

- (void)incocaiton {
    if (_existObj) {
        if ((_block)) {
            _block(_timer);
        }
    }else {
        [_timer invalidate];
        _timer = nil;
    }
}

@end

@implementation NSTimer (AutoIncalidate)
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)intervval
                                      block:(ZDTimeTargetBlock)block
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)isRepeats
                                existObject:(id)existObj
{
    
    ZDTimerTarget *target = [[ZDTimerTarget alloc] initWithTimerTargetBlock:block timer:nil existObj:existObj];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:intervval target:target selector:@selector(incocaiton) userInfo:userInfo repeats:isRepeats];
    target.timer = timer;
    return timer;
}

-(void)pauseTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}


-(void)resumeTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}


@end
