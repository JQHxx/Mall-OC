//
//  ChectAppComplete.h
//  CunYin
//
//  Created by 949699582 on 2019/2/27.
//  Copyright © 2019 裴三三. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 安全防护： 是否二次打包
@interface CheckAppComplete : NSObject


+ (BOOL)isSecondIPA;

@end

NS_ASSUME_NONNULL_END
