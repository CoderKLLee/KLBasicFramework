//
/*******************************************************************************
        
        File name:     UIImageView+CYExtension.m
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/11/1: File created.
        
********************************************************************************/
    

#import "UIImageView+CYExtension.h"

@implementation UIImageView (CYExtension)

- (void)kl_setImgeBlurWithURL:(NSString *)url placeholder:(UIImage *)placeholder {
    
    [self yy_setImageWithURL:[NSURL URLWithString:url] placeholder:placeholder options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation completion:nil];
    
}
@end
