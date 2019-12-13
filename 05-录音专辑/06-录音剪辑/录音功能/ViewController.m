//
//  ViewController.m
//  录音功能
//
//  Created by 王顺子 on 16/12/9.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "ViewController.h"
#import "XMGAudioTool.h"
#import "XMGMusicTool.h"
#import "XMGAdudioFileTool.h"

@interface ViewController ()

@end

@implementation ViewController


- (IBAction)beginRecord:(id)sender {
    [[XMGAudioTool shareInstance] beginRecordWithRecordPath:@"/Users/xiaomage/Desktop/test2.m4a"];
}

- (IBAction)endRecord:(id)sender {

    [[XMGAudioTool shareInstance] endRecord];

}
- (IBAction)deleteRecord:(id)sender {
    [[XMGAudioTool shareInstance] deleteRecord];

}
- (IBAction)playRecord:(id)sender {
    [[XMGMusicTool shareInstance] playAudioWith:@"/Users/xiaomage/Desktop/test2.m4a"];
    
}
- (IBAction)editAduio:(id)sender {
    
//    [XMGAdudioFileTool addAudio:@"/Users/xiaomage/Desktop/test1.m4a" toAudio:@"/Users/xiaomage/Desktop/test2.m4a" outputPath:@"/Users/xiaomage/Desktop/hecheng.m4a"];
    
    [XMGAdudioFileTool cutAudio:@"/Users/xiaomage/Desktop/test1.m4a" fromTime:2 toTime:3  outputPath:@"/Users/xiaomage/Desktop/cut.m4a"];
    
    
}


@end
