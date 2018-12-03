//
/*******************************************************************************
        Copyright © 2018年 CoderKLLee. All rights reserved.
        
        File name:     UIButton+KLExtension.h
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/6/29: File created.
        
********************************************************************************/


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, KLButtonEdgeInsetsStyle) {
    KLButtonEdgeInsetsStyleTop, // image在上，label在下
    KLButtonEdgeInsetsStyleLeft, // image在左，label在右
    KLButtonEdgeInsetsStyleBottom, // image在下，label在上
    KLButtonEdgeInsetsStyleRight // image在右，label在左
};


@interface UIButton (KLExtension)

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)kl_layoutButtonWithEdgeInsetsStyle:(KLButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;


/**
 倒计时
 
 @param timeout 倒计时时间
 @param tittle 倒计时前的title
 @param waitTittle 倒计时后的title
 */
-(void)kl_setCountdownWithStartTime:(NSInteger )timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle;

/**
 设置圆角
 
 @param cornerRadius 圆角大小
 */
- (void)kl_setCornerRadius:(CGFloat )cornerRadius;

@end
