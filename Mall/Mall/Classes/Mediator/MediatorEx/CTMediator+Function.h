//
//  CTMediator+Function_Mediator.h
//  Mall
//
//  Created by HJQ on 2019/10/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "CTMediator.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (Function)

// 调用swift
- (UIViewController *)Function_Swift_ViewControllerWithCallback:(void (^)(NSString *))callback;

// 调用OC
- (UIViewController *)Function_Objc_ViewControllerWithCallback:(void (^)(NSString *))callback;

@end

NS_ASSUME_NONNULL_END
