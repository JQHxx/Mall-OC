//
//  searchManager.m
//  trie树
//
//  Created by HJQ on 2019/5/18.
//  Copyright © 2019年 HJQ. All rights reserved.
//

#import "SearchManager.h"
#import "TrieNode.h"

@interface SearchManager ()

@property (nonatomic, strong) TrieNode *root;

@end

@implementation SearchManager

- (instancetype)init
{
    if (self = [super init]) {
        self.root = [[TrieNode alloc] init];
    }
    
    return self;
}

- (void)insert:(NSString *)word
{
    if (word.length == 0) {
        return;
    }
    word = [word lowercaseString];
    
    TrieNode *node = self.root;
    
    int index = 0;
    NSString *str = @"";
    while (index < word.length) {
        str = [word substringWithRange:NSMakeRange(index, 1)];
        
        if (!node.children[str]) {
            [node add:str];
        }
        
        node = node.children[str];
        index++;
    }
    node.isFinish = YES;
}

- (void)optimization
{
    TrieNode *node = self.root;
    
    NSArray *arrKey = node.children.allKeys;
    for (int i = 0; i < arrKey.count; i++) {
        [self optimization:node.children[arrKey[i]]];
    }
}

- (BOOL)optimization:(TrieNode *)node
{
    NSArray *arrKey = node.children.allKeys;
    if (arrKey.count == 0) {
        return YES;
    }
    for (int i = 0; i < arrKey.count; i++) {
        TrieNode *n = node.children[arrKey[i]];
        if ([self optimization:n]) {
            if (n.children.count == 0 && arrKey.count == 1 && !node.isFinish) {
                TrieNode *n2 = [node.children.allValues lastObject];
                node.character = [NSString stringWithFormat:@"%@%@", node.character, n2.character];
                node.children = nil;
                return YES;
            }
        }
    }
    
    return NO;
}

- (NSArray *)find:(NSString *)word
{
    if (word.length == 0) {
        return @[];
    }
    word = [word lowercaseString];
    
    TrieNode *node = self.root;
    
    int index = 0;
    NSString *str = @"";
    while (index < word.length) {
        str = [word substringWithRange:NSMakeRange(index, 1)];
        
        if (node.children[str]) {
            node = node.children[str];
            index++;
        } else {
            break;
        }
    }
    
    if (index == word.length) {
        NSMutableArray *arr = [NSMutableArray array];
        [self addAllData:node arr:arr];
        return arr;
    }
    return @[];
}

- (void)addAllData:(TrieNode *)node arr:(NSMutableArray *)arr
{
    if (node.isFinish) {
        [arr addObject:[NSString stringWithFormat:@"%@%@", node.string, node.character]];
    }
    
    NSArray *arrKey = node.children.allKeys;
    
    for (int i = 0; i < arrKey.count; i++) {
        TrieNode *n = node.children[arrKey[i]];
        
        if (n.children.count > 0) {
            [self addAllData:n arr:arr];
        } else {
            [arr addObject:[NSString stringWithFormat:@"%@%@", n.string, n.character]];
        }
    }
}

@end
