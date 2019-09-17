//
//  StoryBoardName.m
//  Mall
//
//  Created by midland on 2019/9/9.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "StoryBoardNameUtil.h"

NSString * const StoryBoardNamesMap[] = {
    [Function] = @"Function",
    [Mine] = @"Mine",
    [Message] = @"Message",
};

@implementation StoryBoardNameUtil

  NSString * const StoryBoard(StoryBoardName name) {
    return StoryBoardNamesMap[name];
}

@end
