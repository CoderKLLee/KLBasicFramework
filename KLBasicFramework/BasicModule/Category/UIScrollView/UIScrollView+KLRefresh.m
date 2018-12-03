//
/*******************************************************************************
        Copyright © 2018年 CoderKLLee. All rights reserved.
        
        File name:     UIScrollView+KLRefresh.m
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/7/4: File created.
        
********************************************************************************/


#import "UIScrollView+KLRefresh.h"
#import "KLRefreshHeader.h"
#import "KLRefreshFooter.h"
@implementation UIScrollView (KLRefresh)

/**
 添加下拉刷新控件

 @param refreshingBlock 回调
 @return return value description
 */
- (MJRefreshHeader *)kl_addHeaderRefresh:(void(^)(MJRefreshHeader *header))refreshingBlock {
    
    __weak typeof(&*self) weakSelf = self;
    
    MJRefreshNormalHeader *mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof(&*weakSelf) strongSelf = weakSelf;
        !refreshingBlock? : refreshingBlock((MJRefreshNormalHeader *)strongSelf.mj_header);
    }];
    
    mj_header.automaticallyChangeAlpha = YES;
    
    // Configure normal mj_header
    self.mj_header = mj_header;
    return mj_header;
}

/**
 添加上拉加载控件

 @param refreshingBlock 回调
 @return return value description
 */
- (MJRefreshFooter *)kl_addFooterRefresh:(void(^)(MJRefreshFooter *footer))refreshingBlock {
    __weak typeof(&*self) weakSelf = self;
    MJRefreshAutoNormalFooter *mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __strong typeof(&*weakSelf) strongSelf = weakSelf;
        !refreshingBlock?:refreshingBlock((MJRefreshAutoNormalFooter *)strongSelf.mj_footer);
    }];

    [mj_footer setTitle:@"亲, 我们也是有底线的~" forState:MJRefreshStateNoMoreData];
    
    self.mj_footer = mj_footer;
    return mj_footer;
}
@end
