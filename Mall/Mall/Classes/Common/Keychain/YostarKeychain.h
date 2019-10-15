//
//  YostarKeychain.h
//  Mall
//
//  Created by midland on 2019/10/15.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YostarKeychain : NSObject

// save ... to keychain
+ (void)save:(NSString *)service data:(id)data;

// take out ... from keychain
+ (id)load:(NSString *)service;

// delete ... from keychain
+ (void)delete:(NSString *)service;

@end

NS_ASSUME_NONNULL_END
