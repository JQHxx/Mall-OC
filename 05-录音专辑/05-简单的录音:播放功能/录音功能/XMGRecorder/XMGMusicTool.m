//
//  XMGMusicTool.m
//  录音实验
//
//  Created by 王顺子 on 16/8/26.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGMusicTool.h"

@interface XMGMusicTool()

/** 音乐播放器 */
@property (nonatomic ,strong) AVAudioPlayer *player;

@end

@implementation XMGMusicTool

singtonImplement(XMGMusicTool)

/**
 *  播放歌曲
 */
- (AVAudioPlayer *)playAudioWith:(NSString *)audioPath
{
    NSURL *url = [NSURL URLWithString:audioPath];
    if (url == nil) {
        url = [[NSBundle mainBundle] URLForResource:audioPath.lastPathComponent withExtension:nil];
    }
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [self.player prepareToPlay];
    [self.player play];
    return self.player;
}

/**
 *  恢复当前歌曲
 */
- (void)resumeCurrentAudio
{
    [self.player play];
}

/**
 *  暂停歌曲
 */
- (void)pauseCurrentAudio
{
    [self.player pause];
}

/**
 *  停止歌曲
 */
- (void)stopCurrentAudio
{
    [self.player stop];
}

-(void)setVolumn:(float)volumn
{
    self.player.volume = volumn;
}

-(float)volumn
{
    return self.player.volume;
}

-(float)progress {
    return self.player.currentTime / self.player.duration;
}

@end
