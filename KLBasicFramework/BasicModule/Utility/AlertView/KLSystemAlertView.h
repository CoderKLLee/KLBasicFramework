//
/*******************************************************************************
        Copyright © 2018年 CoderKLLee. All rights reserved.
        
        File name:     KLSystemAlertView.h
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
                系统格式的AlertView
        History:
                2018/6/29: File created.
        
********************************************************************************/


#import <Foundation/Foundation.h>

typedef  void(^KLSystemAlertViewCompletionBlock)(void);

@interface KLSystemAlertView : NSObject
/**
 弹出alertController，并且只有一个action按钮，切记只是警示作用，无事件处理
 
 @param title title
 @param message message
 @param confirmTitle confirmTitle 按钮的title
 */
+ (void)kl_showWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle;


/**
 弹出alertController，并且只有一个action按钮，有处理事件
 
 @param title title
 @param message message
 @param confirmTitle confirmTitle 按钮title
 @param confirmAction 按钮的点击事件处理
 */
+ (void)kl_showWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirmAction:(KLSystemAlertViewCompletionBlock)confirmAction;


/**
 弹出alertController，并且有两个个action按钮，分别有处理事件
 
 @param title title
 @param message Message
 @param confirmTitle 右边按钮的title
 @param cancelTitle 左边按钮的title
 @param confirmAction 右边按钮的点击事件
 @param cancelAction 左边按钮的点击事件
 */
+ (void)kl_showWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle cancelTitle:(NSString *)cancelTitle confirmAction:(KLSystemAlertViewCompletionBlock)confirmAction cancelAction:(KLSystemAlertViewCompletionBlock)cancelAction;
@end
