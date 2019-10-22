//
//  AudioServicesManager.m
//  ML
//
//  Created by 杨帅 on 2019/5/28.
//  Copyright © 2019 杨帅. All rights reserved.
//

#import "AudioServicesManager.h"
#import <AudioToolbox/AudioToolbox.h>
NSString *const kFileUrl = @"live.wav";
@interface AudioServicesManager()
@property (nonatomic ,assign) SystemSoundID soundID;
@end
@implementation AudioServicesManager
+ (instancetype)sharedManager{
    static AudioServicesManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AudioServicesManager alloc]init];
    });
    return manager;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        NSString *audioFile=[[NSBundle mainBundle] pathForResource:kFileUrl ofType:nil];
        NSURL *fileUrl=[NSURL fileURLWithPath:audioFile];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &_soundID);
    }
    return self;
}
#pragma mark -
#pragma mark - play
-(void)play{
    NSLog(@"%u",(unsigned int)_soundID);
    switch (_audioServicesType) {
        case AudioServicesTypeAudioOnly:
            [self audioOnly];
            break;
        case AudioServicesTypeVibrateOnly:
            [self vibrateOnly];
            break;
        case AudioServicesTypeAudioAndVibrate:
            [self audioAndVibrate];
            break;

        default:
            break;
    }
}

- (void)audioOnly{
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
    AudioServicesPlaySystemSound(_soundID);
#else
    AudioServicesPlaySystemSoundWithCompletion(_soundID, nil);
#endif
}
- (void)vibrateOnly{
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
#else
    AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate, nil);
#endif
}
- (void)audioAndVibrate{
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
    AudioServicesPlayAlertSound(_soundID);
#else
    AudioServicesPlayAlertSoundWithCompletion(_soundID,nil);
#endif
}

#pragma mark -
#pragma mark - dealloc
- (void)dealloc{
    AudioServicesRemoveSystemSoundCompletion(_soundID);
    AudioServicesDisposeSystemSoundID(_soundID);
}
@end
