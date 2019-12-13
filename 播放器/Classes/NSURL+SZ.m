//
//  NSURL+SZ.m
//  播放器
//
//  Created by 小码哥 on 2017/1/14.
//  Copyright © 2017年 xmg. All rights reserved.
//

#import "NSURL+SZ.h"

@implementation NSURL (SZ)

- (NSURL *)streamingURL {
    // http://xxxx
    NSURLComponents *compents = [NSURLComponents componentsWithString:self.absoluteString];
    compents.scheme = @"sreaming";
    return compents.URL;
    
    
}


- (NSURL *)httpURL {
    NSURLComponents *compents = [NSURLComponents componentsWithString:self.absoluteString];
    compents.scheme = @"http";
    return compents.URL;

    
}

@end
