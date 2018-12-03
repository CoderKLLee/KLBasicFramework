//
/*******************************************************************************
        Copyright © 2018年 CoderKLLee. All rights reserved.
        
        File name:     CYTableViewController.h
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/7/2: File created.
        
********************************************************************************/


#import "KLViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
@interface KLTableViewController : KLViewController  <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

/**
 tableView
 */
@property (nonatomic, readonly, weak) UITableView *tableView;

/**
 数据源数组
 */
@property (nonatomic, readonly, strong) NSMutableArray *dataSource;

/**
 内容缩进
 默认是 66 or 88.
 */
@property (nonatomic, readonly, assign) UIEdgeInsets contentInset;

/**
 tableView 的类型
 默认 UITableViewStylePlain
 */
@property (nonatomic, readwrite, assign) UITableViewStyle style;

/**
 是否支持 下拉刷新
 默认是 YES
 */
@property (nonatomic, readwrite, assign) BOOL shouldPullDownToRefresh;

/**
 是否开启自动刷新
 默认是 YES
 YES : 自动调用`tableViewDidTriggerHeaderRefresh`
 NO  : 手动调用 `tableViewDidTriggerHeaderRefresh`
 */
@property (nonatomic, readwrite, assign) BOOL shouldBeginRefreshing;

/**
 是否支持上拉加载
 默认是 YES
 */
@property (nonatomic, readwrite, assign) BOOL shouldPullUpToLoadMore;

/**
 当前页
 默认是 1
 */
@property (nonatomic, readwrite, assign) NSUInteger page;

/**
 每一页的数据
 默认是 20
 */
@property (nonatomic, readwrite, assign) NSUInteger perPage;


/**
 是否是结束下拉刷新
 */
@property (nonatomic, readwrite, assign) BOOL isHeaderRefreshFinish;

/**
 是使用 空占位符
 默认  YES
 */
@property (nonatomic, readwrite, assign) BOOL isUseEmpty;


/**
 空占位符的字符串
 */
@property (nonatomic, readwrite , strong) NSString *emptyDataSring;

/**
 是否没有网络
 默认有
 */
@property (nonatomic, readwrite, assign) BOOL isNotNetwork;


#pragma mark    ---     required  必须实现

/**
 下拉刷新事件
 无需调用父类, 直接重写覆盖

 */
- (void)tableViewDidTriggerHeaderRefresh;

/**
 上拉加载事件
 无需调用父类, 直接重写覆盖

 */
- (void)tableViewDidTriggerFooterRefresh;
#pragma mark    ---     optional  可选方法
/**
 tableView 刷新
 等效于 [self.tableView reloadData];
 */
- (void)reloadData;

/**
 加载结束

 */
- (void)tableViewDidFinishAllTrigger;



/**
 提示没有更多的数据
 */
- (void)tableViewEndRefreshingWithNoMoreData;

@end
