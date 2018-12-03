//
/*******************************************************************************
        Copyright © 2018年 CoderKLLee. All rights reserved.
        
        File name:     UIAlertController+KLExtension.h
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
                通过类别, 改变系统弹出框的颜色
 
        History:
                2018/6/29: File created.
        
********************************************************************************/


#import <UIKit/UIKit.h>

@interface UIAlertController (KLColor)

/**
 统一按钮样式 不写系统默认的蓝色
 
 */
@property (nonatomic , readwrite, strong) UIColor *tintColor;

/**
 标题的颜色
 */
@property (nonatomic , readwrite, strong) UIColor *titleColor;

/**
 信息的颜色
 */
@property (nonatomic , readwrite, strong) UIColor *messageColor;

@end

@interface UIAlertAction (KLColor)

/**
 按钮title字体颜色
 */
@property (nonatomic , readwrite, strong) UIColor *textColor;

@end
