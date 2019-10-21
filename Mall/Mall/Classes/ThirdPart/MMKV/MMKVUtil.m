//
//  MMKVUtil.m
//  Mall
//
//  Created by midland on 2019/10/18.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "MMKVUtil.h"
#import "MMKV.h"

@interface MMKVUtil()
{
    MMKV *_mmkv;
}

@end

@implementation MMKVUtil

static MMKVUtil *_instance = nil;

+ (instancetype) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:nil] init];
    });
    return _instance;
}

+(id)allocWithZone:(NSZone *)zone{
    return [self sharedInstance];
}

-(id)copyWithZone:(NSZone *)zone{
    return [[self class] sharedInstance];
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    return [[self class] sharedInstance];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _mmkv = [MMKV defaultMMKV];
    }
    return self;
}

// BOOL
- (BOOL) setBool: (BOOL) value forKey: (NSString *) key {
   return [_mmkv setBool:value forKey:key];
}

- (BOOL) getBoolForKey: (NSString *) key {
    return [_mmkv getBoolForKey:key];
}

// float
- (BOOL) setFloat: (float) value forKey: (NSString *) key {
    return [_mmkv setFloat:value forKey:key];
}

- (float) getFloatForKey: (NSString *) key {
    return [_mmkv getFloatForKey:key];
}

// double
- (BOOL) setDouble: (double) value forKey: (NSString *) key {
    return [_mmkv setDouble:value forKey:key];
}

- (double) getDoubleForKey: (NSString *) key {
    return [_mmkv getDoubleForKey:key];
}

// NSString
- (BOOL) setString: (NSString *) value forKey: (NSString *) key {
    return [_mmkv setString:value forKey:key];
}

- (NSString *) getStringForKey: (NSString *) key {
    return [_mmkv getStringForKey:key];
}

// NSData
- (BOOL) setData: (NSData *) value forKey: (NSString *) key {
   return [_mmkv setData:value forKey:key];
}

- (NSData *) getDataForKey: (NSString *) key {
    return [_mmkv getDataForKey:key];
}

// NSObject
- (BOOL) setObject: (NSObject<NSCoding> *) value forKey: (NSString *) key {
    return [_mmkv setObject:value forKey:key];
}

- (id) getObjectOfClass: (Class) class forKey: (NSString *) key {
    return [_mmkv getObjectOfClass:class forKey:key];
}

// NSDate
- (BOOL) setDate: (NSDate *) value forKey: (NSString *) key {
    return [_mmkv setDate:value forKey:key];
}

- (NSDate *) getDateForKey: (NSString *) key {
    return [_mmkv getDateForKey:key];
}


@end
