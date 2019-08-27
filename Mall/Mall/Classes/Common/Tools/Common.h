//
//  Common.h
//  Mall
//
//  Created by midland on 2019/8/27.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Common : NSObject

//十六进制转颜色
+ (UIColor *) hexStringToColor: (NSString *) colorNameString;

//获取文本尺寸
+ (CGSize) getExpectedContentSize:(NSString *)content fontSize:(CGFloat) fontSize width:(CGFloat)width;

//调整图片大小
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

//判断图片是否达到一定尺寸,达到则做处理(主要用于发送图片到服务器时使用, 如店铺编辑, 上传图片)
+ (NSData *) handleImageBySize:(UIImage *) image;

//颜色转图片
+ (UIImage*) createImageWithColor: (UIColor*) color;

@end

