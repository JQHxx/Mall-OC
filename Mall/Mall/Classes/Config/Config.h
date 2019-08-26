//
//  Config.h
//  Mall
//
//  Created by midland on 2019/8/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Config : NSObject

SingletonH(Config)

@property(nonatomic, copy, getter=getQqAppId) NSString *qqAppId;
@property(nonatomic, copy, getter=getQqAppKey) NSString *qqAppKey;

@end
