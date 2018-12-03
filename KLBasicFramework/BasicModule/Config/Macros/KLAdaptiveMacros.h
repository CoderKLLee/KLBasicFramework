//
/*******************************************************************************
        Copyright © 2018年 CoderKLLee. All rights reserved.
        
        File name:     KLAdaptiveMacros.h
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
                关于屏幕相关,及其屏幕适配的宏定义文件
 
        History:
                2018/6/29: File created.
        
********************************************************************************/


#ifndef KLAdaptiveMacros_h
#define KLAdaptiveMacros_h
#pragma mark    ---     屏幕尺寸相关

#define SCREEN_WIDTH                      ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT                     ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_BOUNDS                     ([[UIScreen mainScreen] bounds])
#define SCREEN_MAX_LENGTH                 (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH                 (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

//  底部导航栏高度
#define TAB_BAR_HEIGHT                    (DEVICE_IS_IPHONE_X_SERIES ? 83 : 49)
//  导航栏高度
#define NAV_BAR_HEIGHT                    (DEVICE_IS_IPHONE_X_SERIES ? 88 : 64)
// 状态栏高度
#define STATUS_BAR_HEIGHT                 (DEVICE_IS_IPHONE_X_SERIES ? 44 : 20)
// 全局间距高度
#define GLOBAL_MARGIN_HEIGHT              (10)

#pragma mark    ---     UIScrollView 适配iPhone X + iOS 11
// UIScrollView适配
#define  LAYOUT_ADJUSTS_SCROLLVIEW_INSETS_NEVER(__scrollView)\
do {\
_Pragma("clang diagnostic push")\
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")\
if ([__scrollView respondsToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
NSMethodSignature *signature = [UIScrollView instanceMethodSignatureForSelector:@selector(setContentInsetAdjustmentBehavior:)];\
NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];\
NSInteger argument = 2;\
invocation.target = __scrollView;\
invocation.selector = @selector(setContentInsetAdjustmentBehavior:);\
[invocation setArgument:&argument atIndex:2];\
[invocation retainArguments];\
[invocation invoke];\
}\
_Pragma("clang diagnostic pop")\
} while (0)




// 暂时不用
#pragma mark    ---     屏幕、字体大小适配
// 宽度适配
#define LAYOUT_WIDTH(width)                (ADAPTIVE_LAYOUT_X(width))
// 高度适配
#define LAYOUT_HEIGHT(height)              (ADAPTIVE_LAYOUT_Y(height))

// 字体适配
#define LAYOUT_FONT_SIZE(size)             ([UIFont systemFontOfSize:ADAPTIVE_LAYOUT_FONT(size)])




#pragma mark    ---     只在本文件使用的宏定义

// 屏幕适配相关
// 设计图以 iPhone 6 plus 为基准  414 * 736
#define ADAPTIVE_IPHONE_WIDTH                414.0
#define ADAPTIVE_IPHONE_HEIGHT               736.0
// 计算比例
// x比例 1.293750 在iPhone7的屏幕上
#define ADAPTIVE_SCALE_X                    (SCREEN_WIDTH / ADAPTIVE_IPHONE_WIDTH)
// y比例 1.295775
#define ADAPTIVE_SCALE_Y                    (SCREEN_HEIGHT / ADAPTIVE_IPHONE_HEIGHT)
// X坐标
#define ADAPTIVE_LAYOUT_X(x)                (ceilf((x) * ADAPTIVE_SCALE_X))
// Y坐标
#define ADAPTIVE_LAYOUT_Y(y)                (ceilf((y) * ADAPTIVE_SCALE_Y))

// 字体适配相关
/// 计算比例  >= 414 为 iPhone 6 Plus, 6s Plus, 7 Plus , X     放大1.5倍
#define ADAPTIVE_FONT_SCALE                 (SCREEN_WIDTH >= 736 ? 1.5 : 1.3)
/// 适配大小
#define ADAPTIVE_LAYOUT_FONT(font)          ((font) * (ADAPTIVE_FONT_SCALE))

#endif /* KLAdaptiveMacros_h */
