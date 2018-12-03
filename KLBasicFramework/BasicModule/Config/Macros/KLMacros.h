//
/*******************************************************************************
        Copyright © 2018年 CoderKLLee. All rights reserved.
        
        File name:     KLMacros.h
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
                    管理全局宏定义的头文件
                    无法分类的全局宏定义,放置于此
 
        History:
                2018/6/29: File created.
        
********************************************************************************/


#ifndef KLMacros_h
#define KLMacros_h

#import <UIKit/UIKit.h>
#pragma mark    ---     系统相关
// AppDelegate
#define APP_DELEGATE                                   ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define APP_WINDOW                                     ([UIApplication sharedApplication].keyWindow)
// 应用版本号
#define APP_VERSION                                    ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])

// 系统版本号
#define APP_SYSTEM_VERSION                             ([[[UIDevice currentDevice] systemVersion] floatValue])

// 类型相关
// 是否是手机
#define DEVICE_IS_IPHONE                               ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone))

// 手机类型相关
#define DEVICE_IS_IPHONE_4_OR_LESS                     (DEVICE_IS_IPHONE && SCREEN_MAX_LENGTH  < 568.0)
#define DEVICE_IS_IPHONE_5_SE_OR_LESS                  (DEVICE_IS_IPHONE && SCREEN_MAX_LENGTH <= 568.0)
#define DEVICE_IS_IPHONE_6_7_8                         (DEVICE_IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define DEVICE_IS_IPHONE_PLUS                          (DEVICE_IS_IPHONE && SCREEN_MAX_LENGTH >= 736.0)


#define DEVICE_IS_IPHONE_X_SERIES                       isIPhoneXSeries()

static inline BOOL isIPhoneXSeries() {
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    
    return iPhoneXSeries;
}

//  通知中心
#define NOTIFICATION_CENTER                            ([NSNotificationCenter defaultCenter])

//  NSUserDefaults
#define USER_DEFAULTS                                   ([NSUserDefaults standardUserDefaults])


// 防止循环引用宏
#define weakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define strongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

#pragma mark    ---     字符串相关的宏 前缀为 STRING_
#define STRING_IS_EMPTY(str)                           ([NSString kl_isEmpty:str])

#pragma mark    ---     图片相关的宏 前缀为 IMAGE_
// 设置图片
#define IMAGE_NAME(imageName)                          ([UIImage imageNamed:imageName])

// 默认用户头像占位图
#define IMAGE_GLOBAL_ACCOUNT_PLACEHOLDER               (IMAGE_NAME(@"public_account"))

// 默认垂直全局占位图
#define IMAGE_GLOBAL_VERTICAL_PLACEHOLDER              (IMAGE_NAME(@"public_vertical_palceholder"))

// 默认水平全局占位图
#define IMAGE_GLOBAL_HORIZONTAL_PLACEHOLDER            (IMAGE_NAME(@"public_horizontal_palceholder"))

// 默认小型的全局占位图
#define IMAGE_GLOBAL_MIN_PLACEHOLDER                   (IMAGE_NAME(@"public_min_palceholder"))



#import "KLColorMacros.h"
#import "KLAdaptiveMacros.h"

#endif /* KLMacros_h */
