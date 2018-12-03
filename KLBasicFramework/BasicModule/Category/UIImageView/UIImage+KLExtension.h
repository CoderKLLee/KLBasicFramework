//
/*******************************************************************************
        Copyright © 2018年 Ferryman. All rights reserved.
        
        File name:     UIImage+KLExtension.h
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/7/27: File created.
        
********************************************************************************/


#import <UIKit/UIKit.h>

@interface UIImage (KLExtension)
/**
 颜色生成图片
 
 @param color 颜色
 @param size 大小
 @return 图片
 */
+ (UIImage *)kl_imageWithColor:(UIColor *)color size:(CGSize)size;


/**
 通过URL生成二维码
 
 @param url url
 @return 二维码图片
 */
+ (UIImage *)kl_createQRCodeWithURL:(NSString *)url;
@end
