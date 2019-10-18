//
//  Config.h
//  Mall
//
//  Created by midland on 2019/8/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * Key管理
 */
@interface Config : NSObject

@property(class, nonatomic, copy, readonly) NSString *qqAppId;
@property(class, nonatomic, copy, readonly) NSString *qqAppKey;

@end
