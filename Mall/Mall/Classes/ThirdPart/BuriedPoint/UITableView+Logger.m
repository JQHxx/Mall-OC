//
//  UITableView+Logger.m
//  Mall
//
//  Created by midland on 2019/10/9.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "UITableView+Logger.h"
#import "WYEHook.h"

@implementation UITableView (Logger)

+(void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originalSEL = @selector(setDelegate:);
        SEL changeSEL = @selector(hook_setDelegate:);
        [WYEHook hookClass:self fromSelector:originalSEL toSelector:changeSEL];
    });
    
}

- (void)hook_setDelegate:(id<UITableViewDelegate>)delegate{
    [self hook_setDelegate:delegate];
    Method didSelectmethod = class_getInstanceMethod(delegate.class, @selector(tableView:didSelectRowAtIndexPath:));
    IMP hookIMP = class_getMethodImplementation(self.class, @selector(hook_tableView:didSelectRowAtIndexPath:));
    
    char const* type = method_getTypeEncoding(didSelectmethod);
    class_addMethod(delegate.class, @selector(hook_tableView:didSelectRowAtIndexPath:), hookIMP, type);
    Method hookMethod = class_getInstanceMethod(delegate.class, @selector(hook_tableView:didSelectRowAtIndexPath:));
    method_exchangeImplementations(didSelectmethod, hookMethod);
    
}

- (void)hook_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@ %@", self.class, [NSString stringWithFormat:@"%ld,%ld",indexPath.row,indexPath.section]);
    [self hook_tableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end
