//
/*******************************************************************************
        Copyright © 2018年 CoderKLLee. All rights reserved.
        
        File name:     CYNavigationController.h
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/7/2: File created.
        
********************************************************************************/


#import <UIKit/UIKit.h>

@interface KLNavigationController : UINavigationController

/**
 显示导航栏的细线
 */
- (void)showNavigationBottomLine;

/**
 隐藏导航栏的细线
 */
- (void)hideNavigationBottomLine;
@end
