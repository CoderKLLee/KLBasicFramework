//
/*******************************************************************************
        Copyright © 2018年 CoderKLLee. All rights reserved.
        
        File name:     MBProgressHUD+KLExtension.h
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
                MBProgressHUD 的拓展类
 
        History:
                2018/6/29: File created.
        
********************************************************************************/


#import "MBProgressHUD.h"

@interface MBProgressHUD (CYExtension)


/// in special view
/**
 提示信息
 
 @param tipStr 信息
 @param view 添加的view
 */
+ (void)kl_showTips:(NSString *)tipStr addedToView:(UIView *)view;


/**
 进度HUD, 带提示信息
 
 @param titleStr 提示信息
 @param view 添加的view
 */
+ (void)kl_showProgressHUD:(NSString *)titleStr addedToView:(UIView *)view;


/**
 进度HUD, 不带提示信息
 
 @param view 添加的view
 */
+ (void)kl_showProgressHUDAddedToView:(UIView *)view;

/**
 隐藏hud
 
 @param view view description
 */
+ (void)kl_hideHUDForView:(UIView *)view;

#pragma mark    ---     自定义
/**
 自定义进度HUD, 不带提示信息
 
 @param view 添加的view
 */
+ (void)kl_showGIFProgressHUDAddedToView:(UIView *)view;

@end
