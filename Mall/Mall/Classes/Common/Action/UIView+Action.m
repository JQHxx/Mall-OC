//
//  UIView+Action.m
//  Mall
//
//  Created by midland on 2019/10/17.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "UIView+Action.h"
#import <objc/runtime.h>

@implementation UIView (Action)

static char jk_kActionHandlerTapBlockKey;
static char jk_kActionHandlerTapGestureKey;
static char jk_kActionHandlerLongPressBlockKey;
static char jk_kActionHandlerLongPressGestureKey;

- (void)bf_addTapActionWithBlock:(BFGestureActionBlock)block {
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &jk_kActionHandlerTapGestureKey);
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bf_handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &jk_kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    objc_setAssociatedObject(self, &jk_kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)bf_handleActionForTapGesture:(UITapGestureRecognizer*)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        BFGestureActionBlock block = objc_getAssociatedObject(self, &jk_kActionHandlerTapBlockKey);
        if (block) {
            block(gesture);
        }
    }
}

- (void)bf_addLongPressActionWithBlock:(BFGestureActionBlock)block {
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &jk_kActionHandlerLongPressGestureKey);
    if (!gesture) {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(bf_handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &jk_kActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    objc_setAssociatedObject(self, &jk_kActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)bf_handleActionForLongPressGesture:(UITapGestureRecognizer*)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        BFGestureActionBlock block = objc_getAssociatedObject(self, &jk_kActionHandlerLongPressBlockKey);
        if (block) {
            block(gesture);
        }
    }
}

@end
