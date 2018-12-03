//
/*******************************************************************************
        Copyright © 2018年 CoderKLLee. All rights reserved.
        
        File name:     CYViewController.h
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
                所有自定义视图控制器的基类
 
        History:
                2018/7/2: File created.
        
********************************************************************************/


#import <UIKit/UIKit.h>


@interface KLViewController : UIViewController

#pragma mark    ---     Method

#pragma mark    ---     Property

/**
 基于 `FDFullscreenPopGesture`第三方
 是否取消掉左滑pop到上一层的功能
 栈底控制器无效，默认为 NO
 */
@property (nonatomic, readwrite, assign) BOOL interactivePopDisabled;

/**
 是否隐藏该控制器的导航栏
 默认为 NO
 */
@property (nonatomic, readwrite, assign) BOOL prefersNavigationBarHidden;

/**
 是否隐藏该控制器的导航栏底部的分割线
 默认为 NO
 */
@property (nonatomic, readwrite, assign) BOOL prefersNavigationBarBottomLineHidden;

/**
 是否让IQKeyboardManager的管理键盘的事件
 默认是 YES
 */
@property (nonatomic, readwrite, assign) BOOL keyboardEnable;

/**
 是否键盘弹起的时候，点击其他区域键盘掉下
 默认是 YES
 */
@property (nonatomic, readwrite, assign) BOOL shouldResignOnTouchOutside;

/**
 键盘离输入框的距离
 默认是 10.0
 */
@property (nonatomic, readwrite, assign) CGFloat keyboardDistanceFromTextField;

@end
