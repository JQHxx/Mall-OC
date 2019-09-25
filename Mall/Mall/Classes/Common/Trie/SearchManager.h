//
//  searchManager.h
//  trie树
//
//  Created by HJQ on 2019/5/18.
//  Copyright © 2019年 HJQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/**
 trie 树搜索
 
 SearchManager *model = [[SearchManager alloc] init];
 for (int i = 0; i < array.count; i++) {
    [model insert:array[i]];
 }
 
 NSMutableArray *arr = [NSMutableArray array];
 [arr addObjectsFromArray:[model find:@"java"]];
 
 // 增加字段可参考：https://www.jianshu.com/p/a2a8a4f2fd7b
 */
@interface SearchManager : NSObject

- (void)insert:(NSString *)word;
- (NSArray *)find:(NSString *)word;
- (void)optimization;

@end

NS_ASSUME_NONNULL_END
