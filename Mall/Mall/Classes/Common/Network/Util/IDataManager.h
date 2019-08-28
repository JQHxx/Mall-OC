//
//  IDataManager.h
//  Mall
//
//  Created by midland on 2019/8/28.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IDataManager : NSObject

+ (NSDictionary *) dataToDict: (NSData *) data;

+ (NSData *) objToData: (id) obj;

+ (NSData *)getData:(id) responseObject;

@end

