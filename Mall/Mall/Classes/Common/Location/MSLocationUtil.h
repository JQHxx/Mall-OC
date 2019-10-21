//
//  MSLocationUtil.h
//  Mall
//
//  Created by midland on 2019/10/21.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/**
 <key>NSLocationWhenInUseUsageDescription</key>
 <string>若不开启定位将无法获取商品的定位信息</string>
 
 <key>NSLocationAlwaysUsageDescription</key>
 <string>若不开启定位将无法获取商品的定位信息</string>
 
 <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
 <string>若不开启定位将无法获取商品的定位信息</string>
 */

typedef void(^ResultCityBlock)(CLLocation *location,CLPlacemark *pl,NSString *error);

@interface MSLocationUtil : NSObject

+ (instancetype) sharedInstance;

-(void)getCurrentLOcation:(ResultCityBlock)block;

@end

