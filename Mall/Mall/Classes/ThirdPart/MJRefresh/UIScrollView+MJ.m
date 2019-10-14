//
//  UIScrollView+MJ.m
//  Mall
//
//  Created by midland on 2019/10/14.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "UIScrollView+MJ.h"
#import "BFRefreshNormalHeader.h"
#import "BFRefreshBackNormalFooter.h"

@implementation UIScrollView (MJ)

- (void) headerRefresh: (MJHeaderBlock) block  {
    self.mj_header = [BFRefreshNormalHeader headerWithRefreshingBlock:^{
        if(block) {
            block();
        }
    }];
}

- (void) footerRefresh: (MJHeaderBlock) block  {
    self.mj_footer = [BFRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if(block) {
             block();
         }
    }];
}


@end
