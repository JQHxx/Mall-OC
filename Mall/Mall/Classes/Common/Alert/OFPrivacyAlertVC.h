//
//  PrivacyAlertVC.h
//  BFAlertViewController
//
//  Created by OFweek01 on 2019/12/31.
//  Copyright © 2019 OFweek01. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OFPrivacyAlertVC : UIViewController

@property (nonatomic, copy)  void (^tapActionBlock)(void);
@property (nonatomic, copy)  void (^agreementActionBlock)(NSString *title);

@end

NS_ASSUME_NONNULL_END
