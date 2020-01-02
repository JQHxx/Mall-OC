//
//  OFAlertConfig.h
//  BFAlertViewController
//
//  Created by OFweek01 on 2019/12/31.
//  Copyright © 2019 OFweek01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^OFCancelBlock)(void);
typedef void(^OFSureBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface OFAlertConfig : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *sureButtonTitle;
@property (nonatomic, copy) NSString *cancleButtonTitle;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *messageColor;
@property (nonatomic, strong) UIColor *sureButtonTitleColor;
@property (nonatomic, strong) UIColor *cancleButtonTitleColor;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIFont *messageFont;
@property (nonatomic, strong) UIFont *sureButtonTitleFont;
@property (nonatomic, strong) UIFont *cancleButtonTitleFont;
@property (nonatomic, assign) NSTextAlignment titleAlignment;
@property (nonatomic, assign) NSTextAlignment messageAlignment;

// 是否单个按钮
@property (nonatomic, assign) BOOL isSingleButton;
@property (nonatomic, copy) OFSureBlock sureBlock;
@property (nonatomic, copy) OFCancelBlock cancelBlock;

@end

NS_ASSUME_NONNULL_END
