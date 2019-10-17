//
//  AudioServicesManager.h
//  ML
//
//  Created by 杨帅 on 2019/5/28.
//  Copyright © 2019 杨帅. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger){
    AudioServicesTypeAudioOnly = 1,  // 声音提示
    AudioServicesTypeVibrateOnly,    // 振动提示
    AudioServicesTypeAudioAndVibrate // 声音&振动
}AudioServicesType;
@interface AudioServicesManager : NSObject
@property (nonatomic ,assign) AudioServicesType audioServicesType;
+ (instancetype)sharedManager;
- (void)play;
@end

NS_ASSUME_NONNULL_END
