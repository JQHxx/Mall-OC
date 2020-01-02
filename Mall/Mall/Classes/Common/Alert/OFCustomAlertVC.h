//
//  OFCustomAlertVC.h
//  BFAlertViewController
//
//  Created by OFweek01 on 2019/12/31.
//  Copyright © 2019 OFweek01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OFAlertConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface OFCustomAlertVC : UIViewController

+ (instancetype) alertWithConfig: (OFAlertConfig *) config;

@end

NS_ASSUME_NONNULL_END
