//
//  StoryBoardName.h
//  Mall
//
//  Created by midland on 2019/9/9.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, StoryBoardName) {
    Main,
    Mine,
    Message,
};

@interface StoryBoardNameUtil : NSObject

/**
 * 获取StoryBoard name
 */
extern const NSString* StoryBoard(StoryBoardName name);

@end
