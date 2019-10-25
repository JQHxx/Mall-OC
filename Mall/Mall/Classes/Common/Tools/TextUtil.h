//
//  TextUtil.h
//  Mall
//
//  Created by midland on 2019/10/15.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextUtil : NSObject

/**
 获取label 中每一行的显示内容
 数组count 就是可以显示的行数
 */
- (NSArray *)getLinesArrayOfStringInLabel:(UILabel *)label;

@end

NS_ASSUME_NONNULL_END
