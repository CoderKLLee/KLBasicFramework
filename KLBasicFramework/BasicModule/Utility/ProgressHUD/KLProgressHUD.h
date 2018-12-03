//
/*******************************************************************************
        Copyright © 2018年 CoderKLLee. All rights reserved.
        
        File name:     KLProgressHUD.h
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/6/29: File created.
        
********************************************************************************/


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KLProgressHUD : NSObject

#pragma mark    ---     In Window

/**
 提示信息
 
 @param tipStr 信息
 */
+ (void)kl_showTips:(NSString *)tipStr;


/**
 进度条, 不带提示信息
 
 */
+ (void)kl_showProressHUD;
/**
 进度HUD, 带提示信息
 
 @param titleStr 进度信息
 */
+ (void)kl_showProgressHUD:(NSString *)titleStr;

/**
 隐藏hud
 */
+ (void)kl_hideHUD;


#pragma mark    ---     In special view

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


#pragma mark    ---  custom HUD in special view
/**
 自定义进度HUD, 不带提示信息
 
 @param view 添加的view
 */
+ (void)kl_showGIFProgressHUDAddedToView:(UIView *)view;



@end
