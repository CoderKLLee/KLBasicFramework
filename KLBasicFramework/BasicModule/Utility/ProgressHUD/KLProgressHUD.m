//
/*******************************************************************************
        Copyright © 2018年 CoderKLLee. All rights reserved.
        
        File name:     klProgressHUD.m
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/6/29: File created.
        
********************************************************************************/


#import "KLProgressHUD.h"
#import "MBProgressHUD+klExtension.h"
@implementation KLProgressHUD
+ (void)kl_showTips:(NSString *)tipStr {
    [MBProgressHUD kl_showTips:tipStr addedToView:APP_WINDOW.rootViewController.view];
}


+ (void)kl_showProressHUD {
    [MBProgressHUD kl_showProgressHUDAddedToView:APP_WINDOW.rootViewController.view];

}

+ (void)kl_showProgressHUD:(NSString *)titleStr {
    [MBProgressHUD kl_showProgressHUD:titleStr addedToView:APP_WINDOW.rootViewController.view];
}


+ (void)kl_hideHUD {
    [MBProgressHUD kl_hideHUDForView:APP_WINDOW.rootViewController.view];
}


/// in special view
+ (void)kl_showTips:(NSString *)tipStr addedToView:(UIView *)view {
    [MBProgressHUD kl_showTips:tipStr addedToView:view];
}

+ (void)kl_showProgressHUD:(NSString *)titleStr addedToView:(UIView *)view {
    [MBProgressHUD kl_showProgressHUD:titleStr addedToView:view];
}


+ (void)kl_showProgressHUDAddedToView:(UIView *)view {
    [MBProgressHUD kl_showProgressHUDAddedToView:view];
}

+ (void)kl_hideHUDForView:(UIView *)view {
    [MBProgressHUD kl_hideHUDForView:view];
}

+ (void)kl_showGIFProgressHUDAddedToView:(UIView *)view {
    [MBProgressHUD kl_showGIFProgressHUDAddedToView:view];
}
@end
