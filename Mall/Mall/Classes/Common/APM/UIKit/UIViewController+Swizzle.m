//
//  UIViewController+Swizzle.m
//  Mall
//
//  Created by midland on 2019/9/30.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "UIViewController+Swizzle.h"

// 页面加载速率最好完美的时间在0.3s左右
@interface UIViewController ()
@property(nonatomic,assign) CFAbsoluteTime viewLoadStartTime;

@end

static char *viewLoadStartTimeKey = "viewLoadStartTimeKey";
@implementation UIViewController (Swizzle)

-(void)setViewLoadStartTime:(CFAbsoluteTime)viewLoadStartTime{
    objc_setAssociatedObject(self, &viewLoadStartTimeKey, @(viewLoadStartTime), OBJC_ASSOCIATION_COPY);
    
}

-(CFAbsoluteTime)viewLoadStartTime{
    return [objc_getAssociatedObject(self, &viewLoadStartTimeKey) doubleValue];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL origSel = @selector(viewDidAppear:);
        SEL swizSel = @selector(swiz_viewDidAppear:);
        [UIViewController swizzleMethods:[self class] originalSelector:origSel swizzledSelector:swizSel];
        
        SEL vcWillAppearSel=@selector(viewWillAppear:);
        SEL swizWillAppearSel=@selector(swiz_viewWillAppear:);
        [UIViewController swizzleMethods:[self class] originalSelector:vcWillAppearSel swizzledSelector:swizWillAppearSel];
        
        SEL vcDidLoadSel=@selector(viewDidLoad);
        SEL swizDidLoadSel=@selector(swiz_viewDidLoad);
        [UIViewController swizzleMethods:[self class] originalSelector:vcDidLoadSel swizzledSelector:swizDidLoadSel];
        
        SEL vcDidDisappearSel=@selector(viewDidDisappear:);
        SEL swizDidDisappearSel=@selector(swiz_viewDidDisappear:);
        [UIViewController swizzleMethods:[self class] originalSelector:vcDidDisappearSel swizzledSelector:swizDidDisappearSel];
        
        SEL vcWillDisappearSel=@selector(viewWillDisappear:);
        SEL swizWillDisappearSel=@selector(swiz_viewWillDisappear:);
        [UIViewController swizzleMethods:[self class] originalSelector:vcWillDisappearSel swizzledSelector:swizWillDisappearSel];
    });
}

+ (void)swizzleMethods:(Class)class originalSelector:(SEL)origSel swizzledSelector:(SEL)swizSel {
    Method origMethod = class_getInstanceMethod(class, origSel);
    Method swizMethod = class_getInstanceMethod(class, swizSel);
    
    //class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(class, origSel, method_getImplementation(swizMethod), method_getTypeEncoding(swizMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizSel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        //origMethod and swizMethod already exist
        method_exchangeImplementations(origMethod, swizMethod);
    }
}

- (void)swiz_viewDidAppear:(BOOL)animated {
    [self swiz_viewDidAppear:animated];
    if (self.viewLoadStartTime) {
        CFAbsoluteTime linkTime = (CACurrentMediaTime() - self.viewLoadStartTime);
        
        NSLog(@" %f vl------------ %@: 耗时：\n%fs", self.viewLoadStartTime, self.class, linkTime);
        self.viewLoadStartTime = 0;
    }
}

-(void)swiz_viewWillAppear:(BOOL)animated {
    [self swiz_viewWillAppear:animated];
}

-(void)swiz_viewDidDisappear:(BOOL)animated {
    [self swiz_viewDidDisappear:animated];
}

-(void)swiz_viewWillDisappear:(BOOL)animated {
    [self swiz_viewWillDisappear:animated];
}

-(void)swiz_viewDidLoad {
    self.viewLoadStartTime =CACurrentMediaTime();
    // NSLog(@" %@  swiz_viewDidLoad startTime:%f", self.class, self.viewLoadStartTime );
    [self swiz_viewDidLoad];
}

@end
