//
/*******************************************************************************
        Copyright © 2018年 Ferryman. All rights reserved.
        
        File name:     UILabel+KLExtension.m
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/7/19: File created.
        
********************************************************************************/


#import "UILabel+KLExtension.h"

@implementation UILabel (KLExtension)
- (void)kl_setTextColor:(UIColor *)color fontSize:(CGFloat)size {
    
    self.textColor = color;
    self.font = [UIFont systemFontOfSize:size];
}
@end
