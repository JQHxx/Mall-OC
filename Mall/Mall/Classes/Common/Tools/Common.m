//
//  Common.m
//  Mall
//
//  Created by midland on 2019/8/27.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "Common.h"

@implementation Common

//十六进制转颜色
+ (UIColor *) hexStringToColor: (NSString *) colorNameString
{
    NSString *cString = [[colorNameString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 charactersif ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appearsif ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    UIColor *color = [[UIColor alloc] initWithRed:(float) r / 255.0f green:(float) g / 255.0f blue:(float) b / 255.0f alpha:1.0f];
    
    return color;
}

//获取文本尺寸
+ (CGSize) getExpectedContentSize:(NSString *)content fontSize:(CGFloat) fontSize width:(CGFloat)width
{
    width = width == 0 ? MAXFLOAT : width;
    CGSize maximumLabelSizeOne = CGSizeMake(width,MAXFLOAT);
    /*
     CGSize expectedLabelSizeOne = [content sizeWithFont:font
     constrainedToSize:maximumLabelSizeOne
     lineBreakMode:NSLineBreakByWordWrapping];
     */
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    
    CGSize size = [content boundingRectWithSize:maximumLabelSizeOne options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    return size;
}

//调整图片大小
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

//判断图片是否达到一定尺寸,达到则做处理(主要用于发送图片到服务器时使用, 如店铺编辑, 上传图片)
+ (NSData *) handleImageBySize:(UIImage *) image
{
    NSData * imageData = UIImageJPEGRepresentation(image,1);
    NSInteger imageSize = [imageData length] / 1024 + 30; //KB
    if(imageSize < 200)
    return imageData;
    
    CGFloat imageW = 800;
    CGFloat imageH = 800;
    UIImage *handImage = image;
    if(image.size.width > imageW || image.size.height > imageH)
    {
        CGFloat scale = image.size.width / image.size.height; //比例
        
        if(image.size.width > image.size.height)
        {
            //横向图片
            imageH = imageW / scale;
            handImage = [self scaleToSize:image size:CGSizeMake(imageW, imageH)];
        }
        else
        {
            imageW = imageH * scale;
            handImage = [self scaleToSize:image size:CGSizeMake(imageW, imageH)];
        }
    }
    
    return UIImageJPEGRepresentation(handImage, 0.3);
}

//颜色转图片
+ (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}





@end
