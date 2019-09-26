//
//  UIView+Animation.h
//  Mall
//
//  Created by midland on 2019/9/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Animation)
    
- (void)animateShake;
    
- (void)animateFadeIn:(CFTimeInterval)duration;
    
- (void)animateFadeOut:(CFTimeInterval)duration;

@end

NS_ASSUME_NONNULL_END
