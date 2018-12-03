//
/*******************************************************************************
        Copyright © 2018年 CoderKLLee. All rights reserved.
        
        File name:     CYCollectionViewController.m
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/7/4: File created.
        
********************************************************************************/


#import "KLCollectionViewController.h"
#import "UIScrollView+KLRefresh.h"

@interface KLCollectionViewController ()

@property (nonatomic, readwrite, weak)   UICollectionView *collectionView;

@property (nonatomic, readwrite, assign) UIEdgeInsets contentInset;

@property (nonatomic, readwrite, strong) NSMutableArray *dataSource;

/**
 是否显示空占位图
 */
@property (nonatomic, readwrite, assign) BOOL isShowEmptyDataSet;
@end

@implementation KLCollectionViewController
#pragma mark    ---     Lifecycle
- (void)dealloc {
    _collectionView.dataSource = nil;
    _collectionView.delegate = nil;
    KLLogInfo(@"%@", NSStringFromSelector(_cmd));
}

- (instancetype)init{
    if (self = [super init]) {
        _scrollDirection = UICollectionViewScrollDirectionVertical;
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
    
    if (self.collectionViewLayout == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumInteritemSpacing = 0;
        //行距
        flowLayout.minimumLineSpacing = 0;
        flowLayout.sectionInset=UIEdgeInsetsMake(0, 0, 0, 0);//item对象上下左右的距离
        flowLayout.scrollDirection = self.scrollDirection;
        self.collectionViewLayout = flowLayout;
    }
    
    /// CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:self.collectionViewLayout];
    collectionView.backgroundColor = COLOR_GLOBAL_BACKGROUND;
   
    self.collectionView = collectionView;
    [self.view addSubview:self.collectionView];
    self.collectionView.showsVerticalScrollIndicator = NO;

    
    self.collectionView.emptyDataSetDelegate = self;
    self.collectionView.emptyDataSetSource   = self;
    
    /// 设置显示区域
    collectionView.contentInset  = self.contentInset;
    
    
    // Fixed Bug: 这里需要强制布局一下界面，解决由于设置了collectionView的contentInset，然而contentOffset始终是（0，0）的bug 但是这样会导致 collectionView 刷新一次，从而导致子类在 viewDidLoad 无法及时注册的cell，从而会有Crash的隐患
//            [self.collectionView layoutIfNeeded];
//            [self.collectionView setNeedsLayout];
//            [self.collectionView updateConstraintsIfNeeded];
//            [self.collectionView setNeedsUpdateConstraints];
//            [self.view layoutIfNeeded];
    
    /// 添加加载和刷新控件
    if (self.shouldPullDownToRefresh) {
        /// 下拉刷新
        @weakObj(self);
        [self.collectionView kl_addHeaderRefresh:^(MJRefreshHeader *header) {
            /// 加载下拉刷新的数据
            @strongObj(self);
            [self collectionViewDidTriggerHeaderRefresh];
        }];
        if (self.shouldBeginRefreshing) {
            [self.collectionView.mj_header beginRefreshing];
        }
    }
    
    if (self.shouldPullUpToLoadMore) {
        /// 上拉加载
        @weakObj(self);
        [self.collectionView kl_addFooterRefresh:^(MJRefreshFooter *footer) {
            /// 加载上拉刷新的数据
            @strongObj(self);
            [self collectionViewDidTriggerFooterRefresh];
        }];
        
        /// CoderMikeHe Fixed Bug : 这里先隐藏，防止一进来用户看到上拉加载控件，影响美观
        self.collectionView.mj_footer.hidden = YES;
    }
    
#ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        /// CoderMikeHe: 适配 iPhone X + iOS 11，
        LAYOUT_ADJUSTS_SCROLLVIEW_INSETS_NEVER(collectionView);
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
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    if (self.shouldPullDownToRefresh) {
        [self.collectionView.mj_footer removeFromSuperview];
        self.collectionView.mj_footer = nil;
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
        [self.collectionView.mj_footer removeFromSuperview];
        self.collectionView.mj_footer = nil;
    }
    
    if (!self.isNotNetwork) {
        return nil;
    }
    
    return IMAGE_NAME(@"public_no_data");
    
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.shouldPullDownToRefresh) {
        [self.collectionView.mj_footer removeFromSuperview];
        self.collectionView.mj_footer = nil;
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
        [self.collectionView kl_addFooterRefresh:^(MJRefreshFooter *footer) {
            /// 加载上拉刷新的数据
            @strongObj(self);
            [self collectionViewDidTriggerFooterRefresh];
            
        }];
        self.collectionView.mj_footer.hidden = YES;
    }
    
    [self collectionViewDidTriggerHeaderRefresh];
}


#pragma mark    ---     Private Methods

#pragma mark    ---     Public Methods

/**
 刷新
 */
- (void)reloadData {
    self.isShowEmptyDataSet = YES;
    
    if (self.shouldPullUpToLoadMore) {
        self.collectionView.mj_footer.hidden = NO;
    }
    [self.collectionView reloadData];
}

/**
 下拉事件
 */
- (void)collectionViewDidTriggerHeaderRefresh{
    /// subclass override it
}

/**
 上拉事件
 */
- (void)collectionViewDidTriggerFooterRefresh{
    /// subclass override it
}

/**
 结束刷新

 */
- (void)collectionViewDidFinishAllTrigger {
    
    @weakObj(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongObj(self);
        [self reloadData];
        
        if (self.shouldPullUpToLoadMore) {
            if (!self.isHeaderRefreshFinish) {
                [self.collectionView.mj_footer endRefreshing];
                
            }
        }
        
        if (self.shouldPullDownToRefresh) {
            if (self.isHeaderRefreshFinish) {
                [self.collectionView.mj_header endRefreshing];
            }
        }
        
        
    });
}


/**
 显示无数据
 */
- (void)collectionViewEndRefreshingWithNoMoreData {
    
    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
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
            [self.collectionView kl_addHeaderRefresh:^(MJRefreshHeader *header) {
                /// 加载下拉刷新的数据
                @strongObj(self);
                [self collectionViewDidTriggerHeaderRefresh];
            }];
        }else{
            self.collectionView.mj_header = nil;
        }
    }
}

- (void)setShouldPullUpToLoadMore:(BOOL)shouldPullUpToLoadMore{
    if (_shouldPullUpToLoadMore != shouldPullUpToLoadMore) {
        _shouldPullUpToLoadMore = shouldPullUpToLoadMore;
        if (_shouldPullUpToLoadMore) {
            /// 上拉加载
            @weakObj(self);
            [self.collectionView kl_addFooterRefresh:^(MJRefreshFooter *footer) {
                /// 加载上拉刷新的数据
                @strongObj(self);
                [self collectionViewDidTriggerFooterRefresh];
            }];
        }else{
            self.collectionView.mj_footer = nil;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
