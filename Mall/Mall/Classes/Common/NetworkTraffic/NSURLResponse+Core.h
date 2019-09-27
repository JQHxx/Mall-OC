//
//  NSURLResponse+Core.h
//  Mall
//
//  Created by midland on 2019/9/27.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLResponse (Core)

- (NSString *)statusLineFromCF;
- (NSUInteger)dm_getLineLength;
- (NSUInteger)dm_getHeadersLength;

@end

