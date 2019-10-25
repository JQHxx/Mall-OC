//
//  UICollectionView+Logger.m
//  Mall
//
//  Created by midland on 2019/10/14.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "UICollectionView+Hook.h"
#import "BFHook.h"
#import "HookObjcLog.h"

@implementation UICollectionView (Hook)

+(void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originalSEL = @selector(setDelegate:);
        SEL changeSEL = @selector(hook_setDelegate:);
        [BFHook hookClass:self fromSelector:originalSEL toSelector:changeSEL];
    });
    
}

- (void)hook_setDelegate:(id<UICollectionViewDelegate>)delegate{
    [self hook_setDelegate:delegate];
    Method didSelectmethod = class_getInstanceMethod(delegate.class, @selector(collectionView:didSelectItemAtIndexPath:));
    IMP hookIMP = class_getMethodImplementation(self.class, @selector(hook_collectionView:didSelectRowAtIndexPath:));
    
    char const* type = method_getTypeEncoding(didSelectmethod);
    class_addMethod(delegate.class, @selector(hook_collectionView:didSelectRowAtIndexPath:), hookIMP, type);
    Method hookMethod = class_getInstanceMethod(delegate.class, @selector(hook_collectionView:didSelectRowAtIndexPath:));
    method_exchangeImplementations(didSelectmethod, hookMethod);
    
}

- (void)hook_collectionView:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // NSLog(@"%@ %@", self.class, [NSString stringWithFormat:@"%ld,%ld",indexPath.row,indexPath.section]);
    [[HookObjcLog shareInstance] recordHookClass:self.class identifier:[NSString stringWithFormat:@"%ld,%ld",(long)indexPath.row,(long)indexPath.section]];
    [self hook_collectionView:collectionView didSelectRowAtIndexPath:indexPath];
}

@end
