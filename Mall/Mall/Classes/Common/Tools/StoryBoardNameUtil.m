//
//  StoryBoardName.m
//  Mall
//
//  Created by midland on 2019/9/9.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "StoryBoardNameUtil.h"

const NSString *StoryBoardNamesMap[] = {
    [StoryBoardNameMain] = @"Main",
};

@implementation StoryBoardNameUtil

const NSString* StoryBoarName(StoryBoardName name) {
    return StoryBoardNamesMap[name];
}

@end
