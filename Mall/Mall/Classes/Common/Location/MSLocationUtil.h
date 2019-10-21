//
//  MSLocationUtil.h
//  Mall
//
//  Created by midland on 2019/10/21.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^ResultCityBlock)(CLLocation *location,CLPlacemark *pl,NSString *error);


@interface MSLocationUtil : NSObject

+ (instancetype) sharedInstance;

-(void)getCurrentLOcation:(ResultCityBlock)block;

@end

