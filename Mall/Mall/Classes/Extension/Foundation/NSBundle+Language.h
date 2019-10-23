//
//  NSBundle+Language.h
//  Mall
//
//  Created by midland on 2019/10/22.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 使用[NSBundle setLanguage:@"zh-Hans"];
@interface NSBundle (Language)

+ (void)setLanguage:(NSString *)language;

@end

NS_ASSUME_NONNULL_END
