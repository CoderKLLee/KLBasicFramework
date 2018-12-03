//
/*******************************************************************************
        
        File name:     KLAlertView.m
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/10/25: File created.
        
********************************************************************************/
    

#import "KLAlertView.h"

#import <SCLAlertView.h>

typedef NS_ENUM(NSInteger, KLAlertViewStyle)
{
    KLAlertViewStyleSuccess,
    KLAlertViewStyleQuestion,
    KLAlertViewStyleWarning,
    KLAlertViewStyleCustom
};

@implementation KLAlertView


#pragma mark    ---     SuccessAlertView

+ (void)kl_showWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle {
    
    [self kl_showPublicWithType:KLAlertViewStyleSuccess image:nil title:title message:message confirmTitle:confirmTitle cancelTitle:nil confirmAction:nil cancelAction:nil];
}

+ (void)kl_showWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirmAction:(KLAlertViewCompletionBlock)confirmAction {
    [self kl_showPublicWithType:KLAlertViewStyleSuccess image:nil title:title message:message confirmTitle:confirmTitle cancelTitle:nil confirmAction:confirmAction cancelAction:nil];

}


+ (void)kl_showWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle cancelTitle:(NSString *)cancelTitle confirmAction:(KLAlertViewCompletionBlock)confirmAction cancelAction:(KLAlertViewCompletionBlock)cancelAction {
    [self kl_showPublicWithType:KLAlertViewStyleSuccess image:nil title:title message:message confirmTitle:confirmTitle cancelTitle:cancelTitle confirmAction:confirmAction cancelAction:cancelAction];

}


#pragma mark    ---     QuestionAlertView

+ (void)kl_showQuestionWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle cancelTitle:(NSString *)cancelTitle confirmAction:(KLAlertViewCompletionBlock)confirmAction cancelAction:(KLAlertViewCompletionBlock)cancelAction {
    [self kl_showPublicWithType:KLAlertViewStyleQuestion image:nil title:title message:message confirmTitle:confirmTitle cancelTitle:cancelTitle confirmAction:confirmAction cancelAction:cancelAction];

}

#pragma mark    ---     WarningAlertView

+ (void)kl_showWarningWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle {
    
    [self kl_showPublicWithType:KLAlertViewStyleWarning image:nil title:title message:message confirmTitle:confirmTitle cancelTitle:nil confirmAction:nil cancelAction:nil];

}

+ (void)kl_showWarningWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirmAction:(KLAlertViewCompletionBlock)confirmAction {
    [self kl_showPublicWithType:KLAlertViewStyleWarning image:nil title:title message:message confirmTitle:confirmTitle cancelTitle:nil confirmAction:confirmAction cancelAction:nil];

}


#pragma mark    ---     CustomAlertView

+ (void)kl_showWithImage:(NSString *)image title:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle {
    [self kl_showPublicWithType:KLAlertViewStyleCustom image:image title:title message:message confirmTitle:confirmTitle cancelTitle:nil confirmAction:nil cancelAction:nil];

}


+ (void)kl_showWithImage:(NSString *)image title:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirmAction:(KLAlertViewCompletionBlock)confirmAction {
    [self kl_showPublicWithType:KLAlertViewStyleCustom image:image title:title message:message confirmTitle:confirmTitle cancelTitle:nil confirmAction:confirmAction cancelAction:nil];

}


+ (void)kl_showWithImage:(NSString *)image title:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle cancelTitle:(NSString *)cancelTitle confirmAction:(KLAlertViewCompletionBlock)confirmAction cancelAction:(KLAlertViewCompletionBlock)cancelAction {
    
    [self kl_showPublicWithType:KLAlertViewStyleCustom image:image title:title message:message confirmTitle:confirmTitle cancelTitle:nil confirmAction:confirmAction cancelAction:nil];

}

#pragma mark    ---     Public Methods


+ (void)kl_showPublicWithType:(KLAlertViewStyle )type image:(NSString *)image title:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle cancelTitle:(NSString *)cancelTitle confirmAction:(KLAlertViewCompletionBlock)confirmAction cancelAction:(KLAlertViewCompletionBlock)cancelAction {
    
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    alert.backgroundType = SCLAlertViewBackgroundBlur;
    alert.customViewColor = COLOR_GLOBAL;
    [alert setHorizontalButtons:YES];

    
    
    if (cancelTitle) {
        SCLButton *canclebutton = [alert addButton:cancelTitle actionBlock:^{
            !cancelAction ? : cancelAction();
        }];
        
        canclebutton.buttonFormatBlock = ^NSDictionary* (void)
        {
            NSMutableDictionary *buttonConfig = [[NSMutableDictionary alloc] init];
            
            buttonConfig[@"backgroundColor"] = COLOR_ALERT__ACTION_CANCLE_TEXT;
            buttonConfig[@"textColor"] = [UIColor flatWhiteColor];
            
            return buttonConfig;
        };
    }
    
    SCLButton *confirmbutton = [alert addButton:confirmTitle actionBlock:^{
        !confirmAction ? : confirmAction();

    }];
    
    confirmbutton.buttonFormatBlock = ^NSDictionary* (void)
    {
        NSMutableDictionary *buttonConfig = [[NSMutableDictionary alloc] init];
        
        buttonConfig[@"backgroundColor"] = COLOR_ALERT_ACTION_TEXT ;
        buttonConfig[@"textColor"] = [UIColor flatWhiteColor];
        
        return buttonConfig;
    };
    
    switch (type) {
        case KLAlertViewStyleSuccess: {
            dispatch_async(dispatch_get_main_queue(), ^{
                [alert showSuccess:title subTitle:message closeButtonTitle:nil duration:0.0f];
            });
            break;
        }
        case KLAlertViewStyleWarning: {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [alert showInfo:title subTitle:message closeButtonTitle:nil duration:0.0f];

            });
            break;
        }
        case KLAlertViewStyleQuestion: {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [alert showQuestion:title subTitle:message closeButtonTitle:nil duration:0.0f];
                
            });
            break;
        }
        case KLAlertViewStyleCustom: {
            dispatch_async(dispatch_get_main_queue(), ^{
                [alert showCustom:IMAGE_NAME(image) color:[UIColor flatWhiteColor] title:title subTitle:message closeButtonTitle:nil duration:0.0f];
            });
            break;
        }
    }
    
    
    
}

@end
