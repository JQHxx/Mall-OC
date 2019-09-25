//
//  Node.h
//  trie树
//
//  Created by HJQ on 2019/5/18.
//  Copyright © 2019年 HJQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 字典树
@interface TrieNode : NSObject

@property (nonatomic, copy) NSString *string;
@property (nonatomic, copy) NSString *character;
@property (nonatomic, assign) BOOL isFinish;
@property (nonatomic, strong, nullable) NSMutableDictionary *children;

- (void)add:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
