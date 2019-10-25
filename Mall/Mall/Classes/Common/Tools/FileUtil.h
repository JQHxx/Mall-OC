//
//  FileUtil.h
//  Mall
//
//  Created by midland on 2019/10/21.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileUtil : NSObject

+ (NSURL *)documentsURL;

+ (NSString *)documentsPath;

+ (NSURL *)cachesURL;

+ (NSString *)cachesPath;

+ (NSURL *)libraryURL;

- (NSString *)libraryPath;

@end

NS_ASSUME_NONNULL_END
