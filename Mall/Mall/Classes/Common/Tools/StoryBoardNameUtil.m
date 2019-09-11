//
//  StoryBoardName.m
//  Mall
//
//  Created by midland on 2019/9/9.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "StoryBoardNameUtil.h"

const NSString *StoryBoardNamesMap[] = {
    [Main] = @"Main",
    [Mine] = @"Mine",
    [Message] = @"Message",
};

@implementation StoryBoardNameUtil

const NSString* StoryBoard(StoryBoardName name) {
    return StoryBoardNamesMap[name];
}

@end
