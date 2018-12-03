//
/*******************************************************************************
        Copyright © 2018年 CoderKLLee. All rights reserved.
        
        File name:     CYViewController.m
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
        
        Description:
        
        History:
                2018/7/2: File created.
        
********************************************************************************/


#import "KLViewController.h"
#import "KLNavigationController.h"


#import <IQKeyboardManager/IQKeyboardManager.h>
#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>

NSString *const CYViewControllerIDKey = @"CYViewControllerIDKey";                        // 传递唯一ID的key：例如：商品id 用户id...
NSString *const CYViewControllerModelKey = @"CYViewControllerModelKey";                     // 传递数据模型的key：例如 商品模型的传递 用户模型的传递...

NSString *const CYViewControllerNameKey = @"CYViewControllerNameKey";                     // 传递数据名称



@interface KLViewController ()
/**
 自定义初始化 `initWithParams:` 传过来的值字典
 对应的key为 :    CYViewControllerIDKey
 CYViewControllerModelKey
 */
@property (nonatomic, readwrite, copy) NSDictionary *params;
@end

@implementation KLViewController
#pragma mark    ---     Lifecycle
- (void)dealloc {
    KLLogInfo(@"%@", NSStringFromSelector(_cmd));
}

- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [self init]) {
        _params = params;
    }
    return self;
}


- (instancetype)init {
    self = [super init];
    if (self) {

        // 基础设置默认值        
        // FDFullscreenPopGesture
        _interactivePopDisabled = NO;
        _prefersNavigationBarHidden = NO;
        
        // custom
        _prefersNavigationBarBottomLineHidden = NO;
        
        // 允许IQKeyboardMananger接管键盘弹出事件
        _keyboardEnable = YES;
        _shouldResignOnTouchOutside = YES;
        _keyboardDistanceFromTextField = 10.0f;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // 隐藏导航栏细线
    KLNavigationController *nav = (KLNavigationController *)self.navigationController;
    if ([nav isKindOfClass:[KLNavigationController class]]) { // 容错
        // 显示或隐藏
        self.prefersNavigationBarBottomLineHidden ? [nav hideNavigationBottomLine] : [nav showNavigationBottomLine];
    }
    
    // 配置键盘
    IQKeyboardManager.sharedManager.enable = self.keyboardEnable;
    IQKeyboardManager.sharedManager.shouldResignOnTouchOutside = self.shouldResignOnTouchOutside;
    IQKeyboardManager.sharedManager.keyboardDistanceFromTextField = self.keyboardDistanceFromTextField;
    
    if (nav) {
        /**
         原因：
         viewController.navigationItem.backBarButtonItem = nil;
         [viewController.navigationItem setHidesBackButton:YES];
         Fixed Bug 上面这个方法，会导致侧滑取消时，导航栏出现三个蓝点，系统层面的BUG
         这种方法也不是最完美的，第一次侧滑取消 也会复现
         */
        for (UIView *subView in nav.navigationBar.subviews) {
            /// 隐藏掉蓝点
            if ([subView isKindOfClass:NSClassFromString(@"_UINavigationItemButtonView")]) {
                subView.size_sd = CGSizeZero;
                subView.hidden = YES;
            }
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.navigationController) {
        /**
         viewController.navigationItem.backBarButtonItem = nil;
         [viewController.navigationItem setHidesBackButton:YES];
         Fixed Bug 上面这个方法，会导致侧滑取消时，导航栏出现三个蓝点，系统层面的BUg
         */
        for (UIView *subView in self.navigationController.navigationBar.subviews) {
            /// 隐藏掉蓝点
            if ([subView isKindOfClass:NSClassFromString(@"_UINavigationItemButtonView")]) {
                subView.size_sd = CGSizeZero;
                subView.hidden = YES;
            }
        }
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     适配 iOS 11.0 , iOS11以后，控制器的automaticallyAdjustsScrollViewInsets已经废弃，所以默认就会是YES
     iOS 11新增：adjustContentInset 和 contentInsetAdjustmentBehavior 来处理滚动区域
     Fixed : __IPHONE_11_0 只是说明Xcode定义了这个宏，但不能说明这个支持11.0，所以需要@available(iOS 11.0, *)
     */
    
#ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
#else
    self.automaticallyAdjustsScrollViewInsets = NO;
#endif
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    self.view.backgroundColor = COLOR_GLOBAL_BACKGROUND;
    
    /// 导航栏隐藏 只能在ViewDidLoad里面加载，无法动态
    self.fd_prefersNavigationBarHidden = self.prefersNavigationBarHidden;
    
    //     pop手势
    self.fd_interactivePopDisabled = self.interactivePopDisabled;
    
}

#pragma mark    ---     Initialize Methods

#pragma mark    ---     OverwriteSuperClass
#pragma mark - Orientation
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
    
}
- (BOOL)shouldAutorotate {
    return YES;
    
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
    
}

#pragma mark - Status bar
- (BOOL)prefersStatusBarHidden {
    return NO;
    
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
    
}
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
    
}

#pragma mark    ---     Notification Methods

#pragma mark    ---     Response Mehtods

#pragma mark    ---     Delegate

#pragma mark    ---     Private Methods

#pragma mark    ---     Public Methods


#pragma mark    ---     Getters and Setters


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
