//
/*******************************************************************************
        Copyright © 2018年 CoderKLLee. All rights reserved.
        
        File name:     KLColorMacros.h
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
                    颜色相关的全局宏定义
                    整个应用的全局颜色配置, GLOBAL 代表全局都可以使用 使用前须知
                    颜色相关的宏定义前缀为：COLOR_
 
        History:
                2018/6/29: File created.
        
********************************************************************************/


#ifndef KLColorMacros_h
#define KLColorMacros_h

#define COLOR_WITH_RGB(r, g, b)                     ([UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0])

#define COLOR_WITH_RGB_ALPHA(r, g, b, a)            ([UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a])

// 随机颜色
#define COLOR_GLOBAL_RANDOM                          COLOR_WITH_RGB_ALPHA(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

/// 根据hex 获取颜色
#define COLOR_WITH_HEX_STRING(hexString)         ([UIColor colorWithHexString:hexString])

// 应用主题颜色
#define COLOR_GLOBAL                             COLOR_WITH_HEX_STRING(@"#19b9c8")

// 全局背景颜色 (灰色)
#define COLOR_GLOBAL_BACKGROUND                  COLOR_WITH_HEX_STRING(@"#e7e7e7")


// 全局占位图背景色
#define COLOR_GLOBAL_PLACEHOLER                  ([UIColor colorWithRed:252 / 255.0 green:238 / 255.0 blue:241 / 255.0 alpha:1]

// 全局分割线颜色
#define COLOR_GLOBAL_MARGIN_LINE                 ([UIColor colorFromHexString:@"#D9D8D9"])

#define COLOR_TEXTFIELD_GRAY                     COLOR_WITH_RGB(240, 240, 240)

#pragma mark    ---     文本相关颜色           前缀为: COLOR_TEXT
// 灰色
#define COLOR_TEXT_GRAY                           COLOR_WITH_RGB(135, 135, 135)

// 黑色
#define COLOR_TEXT_BLACK                           COLOR_WITH_RGB(66, 63, 66)

// 橘色
#define COLOR_TEXT_ORANGE                           COLOR_WITH_RGB(255, 161, 12)

// 深橘色
#define COLOR_TEXT_LIGHT_ORANGE                     COLOR_WITH_RGB(254, 72, 1)


#pragma mark    ---     Alert 警告框相关颜色           前缀为: COLOR_ALERT

// 标题的颜色
#define COLOR_ALERT_TITLE                         (COLOR_WITH_HEX_STRING(@"#3C3E44"))

// 信息的颜色
#define COLOR_ALERT_MSG                           (COLOR_WITH_HEX_STRING(@"#9A9A9C"))

// 按钮标题的颜色
#define COLOR_ALERT_ACTION_TEXT                   COLOR_GLOBAL

// 取消按钮标题的颜色
#define COLOR_ALERT__ACTION_CANCLE_TEXT            (COLOR_WITH_HEX_STRING(@"#8E929D"))

// 标题的颜色
#define COLOR_ALERT_SYSTEM_TITLE                         (COLOR_WITH_HEX_STRING(@"#3C3E44"))

// 信息的颜色
#define COLOR_ALERT_SYSTEM_MSG                           (COLOR_WITH_HEX_STRING(@"#9A9A9C"))

// 按钮标题的颜色
#define COLOR_ALERT_SYSTEM_ACTION_TEXT                   COLOR_GLOBAL


// 取消按钮标题的颜色
#define COLOR_ALERT_SYSTEM_ACTION_CANCLE_TEXT            (COLOR_WITH_HEX_STRING(@"#8E929D"))



#endif /* KLColorMacros_h */
