//
//  IDataManager.m
//  Mall
//
//  Created by midland on 2019/8/28.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "IDataManager.h"

@implementation IDataManager

+ (NSDictionary *) dataToDict: (NSData *) data {
    if (!data) {
        return [NSDictionary dictionary];
    }
    // NSData *data = [result dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    return jsonDict;
    
}

+ (NSData *) objToData: (id) obj {
    if (!obj) {
        return [NSData new];
    }
    return [NSJSONSerialization dataWithJSONObject:obj options:0 error:nil];
}
@end
