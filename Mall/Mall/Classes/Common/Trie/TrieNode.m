//
//  Node.m
//  trie树
//
//  Created by HJQ帅 on 2019/5/18.
//  Copyright © 2019年 HJQ. All rights reserved.
//

#import "TrieNode.h"

@implementation TrieNode

+ (TrieNode *)initWithValue:(NSString *)str parent:(TrieNode *)node
{
    TrieNode *n = [[TrieNode alloc] init];
    n.character = str;
    n.string = [NSString stringWithFormat:@"%@%@", node.string, node.character];
    return n;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.children = [NSMutableDictionary dictionary];
        self.character = @"";
        self.string = @"";
    }
    
    return self;
}

- (void)add:(NSString *)str
{
    if (!self.children[str]) {
        self.children[str] = [TrieNode initWithValue:str parent:self];
    }
}

@end
