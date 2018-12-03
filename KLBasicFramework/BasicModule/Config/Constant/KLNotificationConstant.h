//
/*******************************************************************************
        Copyright © 2018年 CoderKLLee. All rights reserved.
        
        File name:     KLNotificationConstant.h
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
                    全局通知的静态变量文件
                    命名规则：k + [触发通知的类名] + [Did | Will] + [动作] + Notification
 
        History:
                2018/6/29: File created.
        
********************************************************************************/


#import <Foundation/Foundation.h>

// 切换根控制器的通知 新特性
FOUNDATION_EXTERN NSString * const kAppDelegateDidChangeRootControllerNotification;


// 更新用户资料的通知
FOUNDATION_EXTERN NSString * const kAccountDidUpdateNotification;

// 支付成功的通知
FOUNDATION_EXTERN NSString * const kPayDidSuccessNotification;

// 评论成功
FOUNDATION_EXTERN NSString * const kCommentDidSuccessNotification;



