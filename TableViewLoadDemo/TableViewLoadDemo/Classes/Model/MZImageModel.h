//
//  MZImageModel.h
//  TableViewLoadDemo
//
//  Created by midland on 2019/10/9.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MZImageModel : NSObject

@property(nonatomic, copy) NSString *picUrl; //图片

@property(nonatomic, assign) BOOL isLoad;

@property(nonatomic, assign) CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END
