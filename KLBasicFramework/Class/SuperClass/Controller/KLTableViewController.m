//
/*******************************************************************************
        Copyright © 2018年 CoderKLLee. All rights reserved.
        
        File name:     CYTableViewController.m
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/7/2: File created.
        
********************************************************************************/


#import "KLTableViewController.h"
#import "UIScrollView+KLRefresh.h"

@interface KLTableViewController ()

@property (nonatomic, readwrite, weak)   UITableView *tableView;

@property (nonatomic, readwrite, assign) UIEdgeInsets contentInset;

@property (nonatomic, readwrite, strong) NSMutableArray *dataSource;

/**
 是否显示空占位图
 */
@property (nonatomic, readwrite, assign) BOOL isShowEmptyDataSet;
@end

@implementation KLTableViewController
#pragma mark    ---     Lifecycle
- (void)dealloc {
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
    KLLogInfo(@"%@", NSStringFromSelector(_cmd));
}

- (instancetype)init{
    if (self = [super init]) {
        _style = UITableViewStylePlain;
        _shouldBeginRefreshing = YES;
        _shouldPullUpToLoadMore = YES;
        _shouldPullDownToRefresh = YES;
        _page = 1;
        _perPage = 20;
        _isShowEmptyDataSet = NO;
        _isUseEmpty = YES;
        _emptyDataSring = @"Sorry, 去别处瞅瞅吧~ \n这里, 寸草不生~";
        _isNotNetwork = NO;
    }
    return self;
}

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    [self setupSubViews];

    
}

#pragma mark    ---     Initialize Methods
/**
 视图初始化
 */
- (void)setupSubViews {

    // FIXED: 纯代码布局，子类如果重新布局，建议用Masonry重新设置约束
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:self.style];
    tableView.backgroundColor = self.view.backgroundColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:tableView];
    
    
    self.tableView = tableView;
    self.tableView.showsHorizontalScrollIndicator = NO;

    self.tableView.showsVerticalScrollIndicator = NO;

    if (self.isUseEmpty) {
        self.tableView.emptyDataSetDelegate = self;
        self.tableView.emptyDataSetSource   = self;
    }

    tableView.contentInset  = self.contentInset;

    
    // Fixed Bug: 这里需要强制布局一下界面，解决由于设置了tableView的contentInset，然而contentOffset始终是（0，0）的bug 但是这样会导致 tableView 刷新一次，从而导致子类在 viewDidLoad 无法及时注册的cell，从而会有Crash的隐患
    //        [self.tableView layoutIfNeeded];
    //        [self.tableView setNeedsLayout];
    //        [self.tableView updateConstraintsIfNeeded];
    //        [self.tableView setNeedsUpdateConstraints];
    //        [self.view layoutIfNeeded];
    
    /// 添加加载和刷新控件
    if (self.shouldPullDownToRefresh) {
        /// 下拉刷新
        @weakObj(self);
        [self.tableView kl_addHeaderRefresh:^(MJRefreshHeader *header) {
            /// 加载下拉刷新的数据
            @strongObj(self);
            [self tableViewDidTriggerHeaderRefresh];
        }];
        if (self.shouldBeginRefreshing) {
            [self.tableView.mj_header beginRefreshing];
        }
    }
    
    if (self.shouldPullUpToLoadMore) {
        /// 上拉加载
        @weakObj(self);
        [self.tableView kl_addFooterRefresh:^(MJRefreshFooter *footer) {
            /// 加载上拉刷新的数据
            @strongObj(self);
            [self tableViewDidTriggerFooterRefresh];
            
        }];
        self.tableView.mj_footer.hidden = YES;
    }
    
#ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        /// CoderMikeHe: 适配 iPhone X + iOS 11，
        LAYOUT_ADJUSTS_SCROLLVIEW_INSETS_NEVER(tableView);
        /// iOS 11上发生tableView顶部有留白，原因是代码中只实现了heightForHeaderInSection方法，而没有实现viewForHeaderInSection方法。那样写是不规范的，只实现高度，而没有实现view，但代码这样写在iOS 11之前是没有问题的，iOS 11之后应该是由于开启了估算行高机制引起了bug。
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
    }
#endif
}
#pragma mark    ---     OverwriteSuperClass
- (UIEdgeInsets)contentInset{
    return UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, 0, 0);
}
#pragma mark    ---     Response Mehtods

#pragma mark    ---     Delegate
#pragma mark    ---     DZNEmptyDataSetSource
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = COLOR_TEXT_GRAY;
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    if (self.shouldPullDownToRefresh) {
        [self.tableView.mj_footer removeFromSuperview];
        self.tableView.mj_footer = nil;
    }
    
    if (self.isNotNetwork) {
        self.emptyDataSring = @"网络迷路啦, 请检查网络后, 点击重新加载~";
    }

    NSAttributedString *str = [[NSAttributedString alloc] initWithString:self.emptyDataSring attributes:attributes];
        return str;


}


/**
 *  返回图片按钮
 */
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    if (self.shouldPullDownToRefresh) {
        [self.tableView.mj_footer removeFromSuperview];
        self.tableView.mj_footer = nil;
    }
    
    if (!self.isNotNetwork) {
        return nil;
    }
    
    return IMAGE_NAME(@"public_no_data");
    
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.shouldPullDownToRefresh) {
        [self.tableView.mj_footer removeFromSuperview];
        self.tableView.mj_footer = nil;
    }
    if (self.isNotNetwork) {
        return nil;
    }
    return IMAGE_NAME(@"public_no_data");
}


#pragma mark    ---     DZNEmptyDataSetDelegate
/**
 *  数据源为空时是否渲染和显示 (默认为 YES)
 */
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return self.isShowEmptyDataSet;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    // 无网络下可点击
    return self.isNotNetwork;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return NO;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    
    if (self.shouldPullUpToLoadMore) {
        /// 上拉加载
        @weakObj(self);
        [self.tableView kl_addFooterRefresh:^(MJRefreshFooter *footer) {
            /// 加载上拉刷新的数据
            @strongObj(self);
            [self tableViewDidTriggerFooterRefresh];
            
        }];
        self.tableView.mj_footer.hidden = YES;
    }
    
    [self tableViewDidTriggerHeaderRefresh];
}


#pragma mark    ---     Private Methods

#pragma mark    ---     Public Methods

/**
 刷新
 */
- (void)reloadData {
    if (self.isUseEmpty) {
        self.isShowEmptyDataSet = YES;

    }
    
    if (self.shouldPullUpToLoadMore) {
        self.tableView.mj_footer.hidden = NO;
    }
    [self.tableView reloadData];
}

/**
 下拉事件
 */
- (void)tableViewDidTriggerHeaderRefresh{
    /// subclass override it
    
}

/**
 上拉事件
 */
- (void)tableViewDidTriggerFooterRefresh{
    /// subclass override it
}

/**
 结束刷新

 */
- (void)tableViewDidFinishAllTrigger {
    
    @weakObj(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongObj(self);
        
            [self reloadData];
        
        if (self.shouldPullUpToLoadMore) {
            if (!self.isHeaderRefreshFinish) {
                [self.tableView.mj_footer endRefreshing];

            }
        }
        
        if (self.shouldPullDownToRefresh) {
            if (self.isHeaderRefreshFinish) {
                [self.tableView.mj_header endRefreshing];
            }
        }
        
        
        
       
        
   
    });
}
- (void)tableViewEndRefreshingWithNoMoreData {
    
    if (self.tableView.mj_footer == nil) {
        /// 上拉加载
        @weakObj(self);
        [self.tableView kl_addFooterRefresh:^(MJRefreshFooter *footer) {
            /// 加载上拉刷新的数据
            @strongObj(self);
            [self tableViewDidTriggerFooterRefresh];
            
        }];
    }
    
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

#pragma mark    ---     Getters and Setters
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource  = [[NSMutableArray alloc] init];
    }
    return _dataSource ;
}

- (void)setShouldPullDownToRefresh:(BOOL)shouldPullDownToRefresh{
    if (_shouldPullDownToRefresh != shouldPullDownToRefresh) {
        _shouldPullDownToRefresh = shouldPullDownToRefresh;
        
        if (_shouldPullDownToRefresh) {
            @weakObj(self);
            [self.tableView kl_addHeaderRefresh:^(MJRefreshHeader *header) {
                /// 加载下拉刷新的数据
                @strongObj(self);
                [self tableViewDidTriggerHeaderRefresh];
            }];
        }else{
            self.tableView.mj_header = nil;
        }
    }
}

- (void)setShouldPullUpToLoadMore:(BOOL)shouldPullUpToLoadMore{
    if (_shouldPullUpToLoadMore != shouldPullUpToLoadMore) {
        _shouldPullUpToLoadMore = shouldPullUpToLoadMore;
        if (_shouldPullUpToLoadMore) {
            /// 上拉加载
            @weakObj(self);
            [self.tableView kl_addFooterRefresh:^(MJRefreshFooter *footer) {
                /// 加载上拉刷新的数据
                @strongObj(self);
                [self tableViewDidTriggerFooterRefresh];
            }];
        }else{
            self.tableView.mj_footer = nil;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
