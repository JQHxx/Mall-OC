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

@interface ViewController ()

@end

@implementation ViewController


- (IBAction)beginRecord:(id)sender {
    [[XMGAudioTool shareInstance] beginRecordWithRecordPath:@"/Users/xiaomage/Desktop/test.m4a"];
}

- (IBAction)endRecord:(id)sender {

    [[XMGAudioTool shareInstance] endRecord];

}
- (IBAction)deleteRecord:(id)sender {
    [[XMGAudioTool shareInstance] deleteRecord];

}
- (IBAction)playRecord:(id)sender {
    [[XMGMusicTool shareInstance] playAudioWith:@"/Users/xiaomage/Desktop/test.m4a"];
    
}


@end
