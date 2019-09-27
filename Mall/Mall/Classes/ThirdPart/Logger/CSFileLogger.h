//
//  CSFileLogger.h
//  Mall
//
//  Created by midland on 2019/9/27.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 重定义d日志存放的目录
 */
@interface CSFileLogger : DDFileLogger
@property (nonatomic, assign) NSUInteger flag;
- (instancetype)initWithFlag:(NSUInteger)flag;
@end

@interface CSFileManagerDefault : DDLogFileManagerDefault
- (instancetype)initWithLogsDirectory:(NSString *)logsDirectory
                             fileName:(NSString *)name;
@end
