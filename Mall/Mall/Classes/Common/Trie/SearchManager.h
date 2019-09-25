//
//  searchManager.h
//  trie树
//
//  Created by 郝帅 on 2019/5/18.
//  Copyright © 2019年 蒲公英. All rights reserved.
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
 */
@interface SearchManager : NSObject

- (void)insert:(NSString *)word;
- (NSArray *)find:(NSString *)word;
- (void)optimization;

@end

NS_ASSUME_NONNULL_END
