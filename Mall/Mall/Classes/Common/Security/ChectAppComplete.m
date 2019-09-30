//
//  ChectAppComplete.m
//  CunYin
//
//  Created by 949699582 on 2019/2/27.
//  Copyright © 2019 裴三三. All rights reserved.
//

#import "ChectAppComplete.h"

@implementation ChectAppComplete
+ (BOOL)isSecondIPA{
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *info = [bundle infoDictionary];
    if ([info objectForKey: @"SignerIdentity"] != nil){
        //存在这个key，则说明被二次打包了
        return YES;
    }
    
    return NO;
}

@end
