//
//  UIButton+Action.m
//  Mall
//
//  Created by midland on 2019/10/15.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "UIButton+Action.h"


@implementation UIButton (Action)
// 静态变量地址唯一不变性
static void *UIBUTTON_KEY = &UIBUTTON_KEY;

- (void)setBtn_block:(void (^)(UIButton *))btn_block {
    objc_setAssociatedObject(self, &UIBUTTON_KEY, btn_block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIButton *))btn_block {
    return objc_getAssociatedObject(self, &UIBUTTON_KEY);
}

- (void)handleEvent:(UIControlEvents)events block:(void (^)(UIButton *))block {
    self.btn_block = block;
    [self addTarget:self action:@selector(invoke:) forControlEvents:events];
}

- (void)invoke:(UIButton *)sender {
    if (self.btn_block) {
        self.btn_block(sender);
    }
}

@end
