//
//  NSObject+Codesign.h
//  Mall
//
//  Created by midland on 2019/9/30.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 安全防护： 防止重签名
@interface NSObject (Codesign)

// Termid
// checkCodesign(@"5KN6964MFR");
void checkCodesign(NSString *id);

@end

NS_ASSUME_NONNULL_END
