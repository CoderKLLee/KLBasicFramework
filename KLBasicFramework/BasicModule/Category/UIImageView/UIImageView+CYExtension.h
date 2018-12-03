//
/*******************************************************************************
        
        File name:     UIImageView+CYExtension.h
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/11/1: File created.
        
********************************************************************************/
    

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (CYExtension)
/**
 加载网络图片, 模糊效果
 
 @param url url description
 @param placeholder placeholder description
 */
- (void)kl_setImgeBlurWithURL:(NSString *)url placeholder:(UIImage *)placeholder;
@end

NS_ASSUME_NONNULL_END
