//
//  UIImage+Category.m
//  VarietyDelivery
//
//  Created by zsy on 2016/12/2.
//  Copyright © 2016年 zsy. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)
+ (UIImage *)createImageWithColor:(UIColor *)color {
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return theImage;
}
+ (UIImage *)vd_imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef))drawBlock {
    if (!drawBlock) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) return nil;
    drawBlock(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage *)vd_maskRoundCornerRadiusImageWithColor:(UIColor *)color cornerRadii:(CGSize)cornerRadii size:(CGSize)size corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    return [UIImage vd_imageWithSize:size drawBlock:^(CGContextRef  _Nonnull context) {
        CGContextSetLineWidth(context, 0);
        [color set];
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:CGRectInset(rect, -0.3, -0.3)];
        UIBezierPath *roundPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 0.3, 0.3) byRoundingCorners:corners cornerRadii:cornerRadii];
        [rectPath appendPath:roundPath];
        CGContextAddPath(context, rectPath.CGPath);
        CGContextEOFillPath(context);
        if (!borderColor || !borderWidth) return;
        [borderColor set];
        UIBezierPath *borderOutterPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:cornerRadii];
        UIBezierPath *borderInnerPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:corners cornerRadii:cornerRadii];
        [borderOutterPath appendPath:borderInnerPath];
        CGContextAddPath(context, borderOutterPath.CGPath);
        CGContextEOFillPath(context);
    }];
}
+ (UIImage *)convertViewToImage{
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, StatusHeight+NaviH)];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)ColorHex(0xEE6B00).CGColor, (__bridge id)ColorHex(0xEA460E).CGColor];
    gradientLayer.locations = @[@0.3, @0.8];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = backView.frame;
    [backView.layer addSublayer:gradientLayer];
    
    CGSize s = backView.bounds.size;
    // 参数一：区域大小。参数二：是否是非透明（半透明效果传NO，否则传YES）。参数三：屏幕密度
    UIGraphicsBeginImageContextWithOptions(s, YES, [UIScreen mainScreen].scale);
    [backView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
// 参数一：原图    参数二：压缩后的最大尺寸   参数三：指定压缩到的大小
+ (NSData *)reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat)maxSize {
    
    if (maxSize <= 0.0) maxSize = 1024.0;
    
    if (maxImageSize <= 0.0) maxImageSize = 1024.0;
    
    // 调整分辨率
    CGSize newSize = CGSizeMake(sourceImage.size.width, sourceImage.size.height);
    // 比例压缩
    CGFloat tempHeight = newSize.height / maxImageSize;
    CGFloat tempWidth = newSize.width / maxImageSize;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempWidth, sourceImage.size.height / tempWidth);
    } else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(sourceImage.size.width / tempHeight, sourceImage.size.height / tempHeight);
    }
    
    //等比缩放
    UIGraphicsBeginImageContext(newSize);
    [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    CGFloat sizeOriginKB = imageData.length / 1024.0;
    //压缩质量
    CGFloat resizeRate = 0.9;
    while (sizeOriginKB > maxSize && resizeRate > 0.1) {
        imageData = UIImageJPEGRepresentation(newImage,resizeRate);
        sizeOriginKB = imageData.length / 1024.0;
        resizeRate -= 0.1;
    }
    
    return imageData;
}

@end
