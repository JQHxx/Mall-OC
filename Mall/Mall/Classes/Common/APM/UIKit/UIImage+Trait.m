//
//  UIImage+Trait.m
//  Mall
//
//  Created by midland on 2019/9/30.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "UIImage+Trait.h"

@implementation UIImage (Trait)

#pragma mark - 解决Image拉伸问题
+ (UITraitCollection *)lightTrait API_AVAILABLE(ios(13.0)) {
    static UITraitCollection *trait = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        trait = [UITraitCollection traitCollectionWithTraitsFromCollections:@[
                                                                              [UITraitCollection traitCollectionWithDisplayScale:UIScreen.mainScreen.scale],
                                                                              [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleLight]
                                                                              ]];
    });
    
    return trait;
}

+ (UITraitCollection *)darkTrait API_AVAILABLE(ios(13.0)) {
    static UITraitCollection *trait = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        trait = [UITraitCollection traitCollectionWithTraitsFromCollections:@[
                                                                              [UITraitCollection traitCollectionWithDisplayScale:UIScreen.mainScreen.scale],
                                                                              [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleDark]
                                                                              ]];
    });
    
    return trait;
}

+ (void)fixResizableImage API_AVAILABLE(ios(13.0)) {
    
    Class klass = UIImage.class;
    SEL selector = @selector(resizableImageWithCapInsets:resizingMode:);
    Method method = class_getInstanceMethod(klass, selector);
    if (method == NULL) {
        return;
    }
    
    IMP originalImp = class_getMethodImplementation(klass, selector);
    if (!originalImp) {
        return;
    }
    
    IMP dynamicColorCompatibleImp = imp_implementationWithBlock(^UIImage *(UIImage *_self, UIEdgeInsets insets, UIImageResizingMode resizingMode) {
        // 理论上可以判断UIColor 是否是 UIDynamicCatalogColor.class, 如果不是, 直接返回原实现; 但没必要.
        UITraitCollection *lightTrait = [self lightTrait];
        UITraitCollection *darkTrait = [self darkTrait];
        
        UIImage *resizable = ((UIImage * (*)(UIImage *, SEL, UIEdgeInsets, UIImageResizingMode))
                              originalImp)(_self, selector, insets, resizingMode);
        UIImage *resizableInLight = [_self.imageAsset imageWithTraitCollection:lightTrait];
        UIImage *resizableInDark = [_self.imageAsset imageWithTraitCollection:darkTrait];
        
        if (resizableInLight) {
            [resizable.imageAsset registerImage:((UIImage * (*)(UIImage *, SEL, UIEdgeInsets, UIImageResizingMode))
                                                 originalImp)(resizableInLight, selector, insets, resizingMode)
                            withTraitCollection:lightTrait];
        }
        if (resizableInDark) {
            [resizable.imageAsset registerImage:((UIImage * (*)(UIImage *, SEL, UIEdgeInsets, UIImageResizingMode))
                                                 originalImp)(resizableInDark, selector, insets, resizingMode)
                            withTraitCollection:darkTrait];
        }
        return resizable;
    });
    
    class_replaceMethod(klass, selector, dynamicColorCompatibleImp, method_getTypeEncoding(method));
}

@end
