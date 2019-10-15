//
//  DarkModel.m
//  Mall
//
//  Created by midland on 2019/10/15.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "DarkModel.h"

@implementation DarkModel

/**
 是否 暗景模式
*/
+ (BOOL)isDarkMode {
    if (@available(iOS 13.0, *)) {
        if (UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

@end
