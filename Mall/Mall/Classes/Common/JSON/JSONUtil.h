//
//  JSONUtil.h
//  Mall
//
//  Created by midland on 2019/10/14.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSONUtil : NSObject

+ (NSString *)queryStringFrom:(NSDictionary *)dic;

+ (NSString *)clearParams: (NSString *) query;

+ (NSString *)dictToJSON:(NSDictionary *)dic;

+ (NSString *)arrayToJSON:(NSArray *)array;

+ (NSString *) objToJSON:(id)obj;

@end

NS_ASSUME_NONNULL_END
