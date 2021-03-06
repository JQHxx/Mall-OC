//
//  XMGAudioTool.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/25.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "Sington.h"

typedef void(^Success)(BOOL ret);

@interface XMGAudioTool : NSObject
singtonInterface;

/**
 *  开始录音
 */
- (void)beginRecordWithRecordPath: (NSString *)recordPath;
/**
 *  结束录音
 */
- (void)endRecord;
/**
 *  暂停录音
 */
- (void)pauseRecord;

/**
 *  删除录音
 */
- (void)deleteRecord;

/**
 *  重新录音
 */
- (void)reRecord;

/**
 *  录音文件路径
 */
@property (nonatomic, copy, readonly) NSString *recordPath;

- (void)updateMeters;

- (float)peakPowerForChannel0;

@end
