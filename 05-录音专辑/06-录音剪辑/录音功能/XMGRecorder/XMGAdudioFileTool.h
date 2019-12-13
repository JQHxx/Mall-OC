//
//  XMGAdudioFileTool.h
//  录音功能
//
//  Created by 小码哥 on 2017/2/19.
//  Copyright © 2017年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGAdudioFileTool : NSObject

+ (void)addAudio:(NSString *)fromPath toAudio:(NSString *)toPath outputPath:(NSString *)outputPath;


+ (void)cutAudio:(NSString *)audioPath fromTime:(NSTimeInterval)fromTime toTime:(NSTimeInterval)toTime outputPath:(NSString *)outputPath;


@end
