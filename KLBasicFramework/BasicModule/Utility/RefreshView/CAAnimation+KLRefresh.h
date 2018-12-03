//
/*******************************************************************************
        Copyright © 2018年 CoderKLLee. All rights reserved.
        
        File name:     CAAnimation+KLRefresh.h
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/7/3: File created.
        
********************************************************************************/


#import <QuartzCore/QuartzCore.h>

@interface CAAnimation (KLRefresh)

/**
 旋转动画

 @return return value description
 */
+ (CABasicAnimation *)kl_rotationAnimation;

/**
 旋转

 @param startAngle 开始角度
 @param endAngle 结束角度
 @return return value description
 */
+ (CABasicAnimation *)kl_rotaAnimStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle;
@end
