//
//  BFRefreshNormalHeader.m
//  Mall
//
//  Created by midland on 2019/10/14.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "BFRefreshNormalHeader.h"

@implementation BFRefreshNormalHeader

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    
    if (self.state == MJRefreshStatePulling) {
        [self feedbackGenerator];
    }
    
}

- (void)feedbackGenerator {
    if (@available(iOS 10.0, *)) {
        UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
        [generator prepare];
        [generator impactOccurred];
    }
}

@end
