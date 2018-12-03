//
/*******************************************************************************
        Copyright © 2018年 CoderKLLee. All rights reserved.
        
        File name:     UIScrollView+KLRefresh.h
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/7/4: File created.
        
********************************************************************************/


#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>

@interface UIScrollView (KLRefresh)
/// 添加下拉刷新控件
- (MJRefreshHeader *)kl_addHeaderRefresh:(void(^)(MJRefreshHeader *header))refreshingBlock;
/// 添加上拉加载控件
- (MJRefreshFooter *)kl_addFooterRefresh:(void(^)(MJRefreshFooter *footer))refreshingBlock;
@end
