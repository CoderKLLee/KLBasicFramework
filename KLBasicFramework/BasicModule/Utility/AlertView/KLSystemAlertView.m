//
/*******************************************************************************
        Copyright © 2018年 CoderKLLee. All rights reserved.
        
        File name:     KLSystemAlertView.m
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/6/29: File created.
        
********************************************************************************/


#import "KLSystemAlertView.h"
#import "UIAlertController+KLColor.h"

@implementation KLSystemAlertView
+ (void)kl_showWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle {
    
    [self kl_showWithTitle:title message:message confirmTitle:confirmTitle confirmAction:NULL];
}

+ (void)kl_showWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirmAction:(KLSystemAlertViewCompletionBlock)confirmAction {
    
    [self kl_showWithTitle:title message:message confirmTitle:confirmTitle cancelTitle:nil confirmAction:confirmAction cancelAction:NULL];
}

+ (void)kl_showWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle cancelTitle:(NSString *)cancelTitle confirmAction:(KLSystemAlertViewCompletionBlock)confirmAction cancelAction:(KLSystemAlertViewCompletionBlock)cancelAction {
    if (message) {
        message = [NSString stringWithFormat:@"\n%@",message];
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    /// 配置alertController
    alertController.titleColor = COLOR_ALERT_SYSTEM_TITLE;
    alertController.messageColor = COLOR_ALERT_SYSTEM_MSG;
    
    /// 左边按钮
    if(cancelTitle.length>0){
        UIAlertAction *cancel= [UIAlertAction actionWithTitle:cancelTitle?cancelTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { !cancelAction?:cancelAction(); }];
        cancel.textColor = COLOR_ALERT_SYSTEM_ACTION_CANCLE_TEXT;
        [alertController addAction:cancel];
    }
    
    
    if (confirmTitle.length>0) {
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:confirmTitle?confirmTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { !confirmAction?:confirmAction();}];
        confirm.textColor = COLOR_ALERT_SYSTEM_ACTION_TEXT;
        [alertController addAction:confirm];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:NULL];
        
    });
}
@end
