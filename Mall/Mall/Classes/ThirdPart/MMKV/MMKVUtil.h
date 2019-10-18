//
//  MMKVUtil.h
//  Mall
//
//  Created by midland on 2019/10/18.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMKVUtil : NSObject

+ (instancetype) shareInstance;

// BOOL
- (BOOL) setBool: (BOOL) value forKey: (NSString *) key;
- (BOOL) getBoolForKey: (NSString *) key;

// float
- (BOOL) setFloat: (float) value forKey: (NSString *) key;
- (float) getFloatForKey: (NSString *) key;

// double
- (BOOL) setDouble: (double) value forKey: (NSString *) key;
- (double) getDoubleForKey: (NSString *) key;

// NSString
- (BOOL) setString: (NSString *) value forKey: (NSString *) key;
- (NSString *) getStringForKey: (NSString *) key;

// NSData
- (BOOL) setData: (NSData *) value forKey: (NSString *) key;
- (NSData *) getDataForKey: (NSString *) key;

// NSObject
- (BOOL) setObject: (NSObject<NSCoding> *) value forKey: (NSString *) key;
- (id) getObjectOfClass: (Class) class forKey: (NSString *) key;

// NSDate
- (BOOL) setDate: (NSDate *) value forKey: (NSString *) key;
- (NSDate *) getDateForKey: (NSString *) key;

@end

NS_ASSUME_NONNULL_END
