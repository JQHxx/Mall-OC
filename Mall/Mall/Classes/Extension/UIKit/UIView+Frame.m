//
//  UIView+Frame.m
//  Mall
//
//  Created by midland on 2019/10/10.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setBf_centerX:(CGFloat)bf_centerX {
    CGPoint center = self.center;
    center.x = bf_centerX;
    self.center = center;
}

    
-(CGFloat)bf_centerX {
    return self.center.x;
}

- (void)setBf_centerY:(CGFloat)bf_centerY {
    CGPoint center = self.center;
    center.y = bf_centerY;
    self.center = center;
}
      
-(CGFloat)bf_centerY {
    return self.center.y;
}
    
    
-(CGFloat)bf_x{
    return self.frame.origin.x;
}
    
-(void)setBf_x:(CGFloat)bf_x {
    CGRect temp = self.frame;
    temp.origin.x = bf_x;
    self.frame = temp;
}
    
-(CGFloat)bf_y{
    return self.frame.origin.y;
}
    
-(void)setBf_y:(CGFloat)bf_y {
    CGRect temp = self.frame;
    temp.origin.y = bf_y;
    self.frame = temp;
}
    
-(CGFloat)bf_width{
    return self.frame.size.width;
}
    
-(void)setBf_width:(CGFloat)bf_width {
    CGRect temp = self.frame;
    temp.size.width = bf_width;
    self.frame = temp;
}
    
    
-(CGFloat)bf_height{
    return self.frame.size.height;
}
    
-(void)setBf_height:(CGFloat)bf_height {
    CGRect temp = self.frame;
    temp.size.height = bf_height;
    self.frame = temp;
}

-(CGSize)bf_size{
    return self.frame.size;
}
    
-(void)setBf_size:(CGSize)bf_size {
    CGRect temp = self.frame;
    temp.size = bf_size;
    self.frame = temp;
}

@end
