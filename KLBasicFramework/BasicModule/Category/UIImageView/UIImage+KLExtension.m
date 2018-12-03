//
/*******************************************************************************
        Copyright © 2018年 Ferryman. All rights reserved.
        
        File name:     UIImage+KLExtension.m
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/7/27: File created.
        
********************************************************************************/


#import "UIImage+KLExtension.h"

@implementation UIImage (KLExtension)
+ (UIImage *)kl_imageWithColor:(UIColor *)color size:(CGSize)size {
    
    if (!color || size.width <=0 || size.height <=0) return nil;
    
    CGRect rect =CGRectMake(0.0f,0.0f, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(rect.size,NO, 0);
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    CGContextFillRect(context, rect);
    
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}


+ (UIImage*)kl_createQRCodeWithURL:(NSString*)url
{
    // 实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 恢复滤镜默认属性，因为滤镜有可能保存了上一次的属性
    [filter setDefaults];
    // 将字符串转换成NSData
    NSData *data = [url dataUsingEncoding:NSUTF8StringEncoding];
    // 设置滤镜,传入Data，
    [filter setValue:data forKey:@"inputMessage"];
    // 生成二维码
    CIImage *qrCode = [filter outputImage];
    
    return [self adjustQRImageSize:qrCode QRSize:100];
}

+ (UIImage*)adjustQRImageSize:(CIImage*)ciImage QRSize:(CGFloat)qrSize
{
    // 获取CIImage图片的的Frame
    CGRect ciImageRect = CGRectIntegral(ciImage.extent);
    CGFloat scale = MIN(qrSize / CGRectGetWidth(ciImageRect), qrSize / CGRectGetHeight(ciImageRect));
    
    // 创建bitmap
    size_t width = CGRectGetWidth(ciImageRect) * scale;
    size_t height = CGRectGetHeight(ciImageRect) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(YES)}];
    CGImageRef bitmapImage = [context createCGImage:ciImage fromRect:ciImageRect];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, ciImageRect, bitmapImage);
    
    // 保存Bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
}




@end
