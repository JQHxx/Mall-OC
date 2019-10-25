//
//  UIApplication+Add.h
//  Mall
//
//  Created by midland on 2019/10/21.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (Add)

- (NSString *)appBundleName;

- (NSString *)appBundleID;

- (NSString *)appVersion;

- (NSString *)appBuildVersion;

@end

NS_ASSUME_NONNULL_END
