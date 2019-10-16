//
//  UIButton+Indicator.h
//  Mall
//
//  Created by midland on 2019/10/16.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Indicator)

/**
 This method will show the activity indicator in place of the button text.
 */
- (void) showIndicator;

/**
 This method will remove the indicator and put thebutton text back in place.
 */
- (void) hideIndicator;

@end

NS_ASSUME_NONNULL_END
