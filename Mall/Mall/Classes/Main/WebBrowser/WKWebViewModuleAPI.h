//
//  Created by HJQ on 2017/8/11.
//  Copyright © 2017年 JQHee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKWebViewBase.h"

@interface WKWebViewModuleAPI : NSObject

+ (instancetype)shareInstance;

@property (nonatomic, strong, readonly) UIViewController *wkWebViewVC;

- (UIViewController *)getWKWebViewVC:(NSString *)content loadType:(WKWebViewLoadType)loadType title:(NSString *)title;

@end
