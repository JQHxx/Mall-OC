//
//  IDataBase.h
//  Mall
//
//  Created by midland on 2019/8/28.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IDataBase : NSObject

+ (instancetype) shareDataBase;

- (void) saveData: (NSString *) url data: (NSData *) data cacheTime: (double) cacheTime;

- (NSData *) queryData: (NSString *) url;

- (void) deleteData: (NSString *) url;

@end
