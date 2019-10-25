//
//  UIGestureRecognizer+Logger.h
//  Mall
//
//  Created by midland on 2019/10/9.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIGestureRecognizer (Hook)

@property(nonatomic, strong) NSString *methodName;

@end

NS_ASSUME_NONNULL_END
