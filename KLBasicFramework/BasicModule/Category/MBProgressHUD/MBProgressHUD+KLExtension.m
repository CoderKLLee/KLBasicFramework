//
/*******************************************************************************
        Copyright © 2018年 CoderKLLee. All rights reserved.
        
        File name:     MBProgressHUD+KLExtension.m
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/6/29: File created.
        
********************************************************************************/


#import "MBProgressHUD+KLExtension.h"

@implementation MBProgressHUD (CYExtension)
#pragma mark    ---     Public Methods

+ (void)kl_showTips:(NSString *)tipStr addedToView:(UIView *)view {
    [self showHUDWithTips:tipStr isHideTitle:NO isAutomaticHide:YES addedToView:view];
}

+ (void)kl_showProgressHUD:(NSString *)titleStr addedToView:(UIView *)view {
    [self showHUDWithTips:titleStr isHideTitle:NO isAutomaticHide:NO addedToView:view];
}

+ (void)kl_showProgressHUDAddedToView:(UIView *)view {
    
    [self showHUDWithTips:nil isHideTitle:YES isAutomaticHide:NO addedToView:view];
}

+ (void)kl_hideHUDForView:(UIView *)view {
    [self hideHUDForView:[self willShowingToViewWithSourceView:view] animated:YES];
}

#pragma mark    ---     Private Methods
+ (void)showHUDWithTips:(NSString *)tipStr isHideTitle:(BOOL)isHideTitle isAutomaticHide:(BOOL)isAutomaticHide addedToView:(UIView *)view
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
      UIView  *tempView = [self willShowingToViewWithSourceView:view];
        
        /// 也可以show之前 hid掉之前的
        [self kl_hideHUDForView:tempView];
        
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
        HUD.animationType = MBProgressHUDAnimationZoom;
        HUD.removeFromSuperViewOnHide = YES;
        HUD.bezelView.backgroundColor = [UIColor blackColor];
        
        
        if (isHideTitle) {
            
            HUD.bezelView.layer.cornerRadius = 8.0f;;
            HUD.bezelView.layer.masksToBounds = YES;
            HUD.contentColor = [UIColor whiteColor];
        }
        else {
            HUD.mode = isAutomaticHide ? MBProgressHUDModeText : MBProgressHUDModeIndeterminate;
            HUD.label.font = isAutomaticHide ? [UIFont systemFontOfSize:16] : [UIFont systemFontOfSize:14];
            HUD.label.textColor = [UIColor whiteColor];
            HUD.contentColor = [UIColor whiteColor];
            HUD.label.text = tipStr;
            HUD.label.numberOfLines = 0;
            HUD.bezelView.layer.cornerRadius = 8.0f;
            HUD.bezelView.layer.masksToBounds = YES;
            HUD.margin = 18.2f;
            
            if (isAutomaticHide) [HUD hideAnimated:YES afterDelay:1.5f];
        }
    });
  
}

/// 获取将要显示的view
+ (UIView *)willShowingToViewWithSourceView:(UIView *)sourceView
{
    
    if (sourceView) return sourceView;
    
    sourceView =  [[UIApplication sharedApplication].delegate window];
    if (!sourceView) sourceView = [[[UIApplication sharedApplication] windows] lastObject];
    
    return sourceView;
}

#pragma mark    ---     自定义
/**
 自定义进度HUD, 不带提示信息
 
 @param view 添加的view
 */
+ (void)kl_showGIFProgressHUDAddedToView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.backgroundView.backgroundColor = [UIColor whiteColor];
    hud.removeFromSuperViewOnHide = YES;
    hud.bezelView.backgroundColor = [UIColor clearColor];
    hud.label.text = @"loading...";
    UIImage *image = [[UIImage imageNamed:@"public_loading1"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    UIImageView* mainImageView= [[UIImageView alloc] initWithImage:image];
    mainImageView.animationImages = [NSArray arrayWithObjects:
                                     [UIImage imageNamed:@"public_loading1"],
                                     [UIImage imageNamed:@"public_loading2"],
                                     [UIImage imageNamed:@"public_loading3"],nil];
    [mainImageView setAnimationDuration:0.5f];
    [mainImageView setAnimationRepeatCount:0];
    [mainImageView startAnimating];
    hud.customView = mainImageView;
    hud.animationType = MBProgressHUDAnimationFade;

    
}

@end
