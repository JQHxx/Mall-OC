//
//  BFLayoutConstraint.m
//  Mall
//
//  Created by midland on 2019/10/8.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "BFLayoutConstraint.h"

@implementation BFLayoutConstraint

- (void)awakeFromNib {
    [super awakeFromNib];
    self.constant = UIApplication.sharedApplication.statusBarFrame.size.height + 44.0;
}

@end
