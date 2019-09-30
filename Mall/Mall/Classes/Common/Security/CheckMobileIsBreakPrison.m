//
//  ChectMobileIsBreakPrison.m
//  CunYin
//
//  Created by 949699582 on 2019/2/26.
//  Copyright © 2019 裴三三. All rights reserved.
//

#import "CheckMobileIsBreakPrison.h"
#import <UIKit/UIKit.h>
@implementation CheckMobileIsBreakPrison

+ (BOOL)checkMobileIsBreakPrison{
    
    CheckMobileIsBreakPrison *check = [CheckMobileIsBreakPrison new];
    if ([check isJailBreak] || [check isJailBreak1] || [check isJailBreak2] ) {
        return YES;
    }else{
        return NO;
    }
    
    return NO;
}

//一:通过越狱后增加的文件判断
- (BOOL)isJailBreak {
    //越狱手机会增加的文件
    NSArray *jailbreak_tool_paths =  @[
                                       @"/Applications/Cydia.app",
                                       @"/Library/MobileSubstrate/MobileSubstrate.dylib",
                                       @"/bin/bash",
                                       @"/usr/sbin/sshd",
                                       @"/etc/apt"
                                       ];
    for (int i=0; i<jailbreak_tool_paths.count; i++) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:jailbreak_tool_paths[i]]) {
            NSLog(@"The device is jail broken!");
            return YES;
        }
    }
    NSLog(@"The device is NOT jail broken!");
    return NO;
}

//2.根据是否能打开cydia判断
- (BOOL)isJailBreak1 {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]) {
        NSLog(@"The device is jail broken!");
        return YES;
    }
    NSLog(@"The device is NOT jail broken!");
    return NO;
}

//3.根据是否能获取所有应用的名称判断
//没有越狱的设备是没有读取所有应用名称的权限的。
- (BOOL)isJailBreak2 {
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"User/Applications/"]) {
        NSLog(@"The device is jail broken!");
        NSArray *appList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"User/Applications/" error:nil];
        NSLog(@"appList = %@", appList);
        return YES;
    }
    NSLog(@"The device is NOT jail broken!");
    return NO;
}


@end
