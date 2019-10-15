//
//  UIButton+Action.h
//  Mall
//
//  Created by midland on 2019/10/15.
//  Copyright © 2019 JQHxx. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Action)

- (void)handleEvent:(UIControlEvents)events block:(void (^)(UIButton *))block;

@end

NS_ASSUME_NONNULL_END
