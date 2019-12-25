//                     _0_
//                   _oo0oo_
//                  o8888888o
//                  88" . "88
//                  (| -_- |)
//                  0\  =  /0
//                ___/`---'\___
//              .' \\|     |// '.
//             / \\|||  :  |||// \
//            / _||||| -:- |||||- \
//           |   | \\\  -  /// |   |
//           | \_|  ''\---/''  |_/ |
//           \  .-\__  '-'  ___/-. /
//         ___'. .'  /--.--\  `. .'___
//      ."" '<  `.___\_<|>_/___.' >' "".
//     | | :  `- \`.;`\ _ /`;.`/ - ` : | |
//     \  \ `_.   \_ __\ /__ _/   .-` /  /
// NO---`-.____`.___ \_____/___.-`___.-'---BUG
//                   `=---='

#import "BaseViewController.h"
#import "RootTabBarController.h"
#import "BaseWebViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MyViewController.h"

@interface BaseViewController ()

@property (nonatomic, assign, readwrite) float navHeight;
@property (nonatomic, assign, readwrite) float tabBarHeight;
@property (nonatomic, assign, readwrite) float statusBarHeight;
@property (nonatomic, assign, readwrite) float safeAreaBottomHeight;

@end

@implementation BaseViewController

/// 入口
- (void)viewDidLoad {
    [super viewDidLoad];
    [self config];
    [self navBackBtn];
}

- (void)config {
    self.view.backgroundColor = AppViewBackgroundColor;
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.pageIndex = 1;
    
    self.modalPresentationStyle = UIModalPresentationOverFullScreen;
}

- (void)endRefreshFromTableView:(UITableView*)tableView {
    [tableView.mj_header endRefreshing];
    [tableView.mj_footer endRefreshing];
}

- (void)addRefreshFromTableView:(UITableView*)tableView
                       loadData:(BaseViewControllerRefreshAction)loadData
                   loadMoreData:(BaseViewControllerRefreshAction)loadMoreData { //添加刷新
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageIndex = 1;
        if (loadData) {
            loadData(self.pageIndex);
        }
    }];
    MJRefreshAutoNormalFooter* footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.pageIndex = self.pageIndex + 1;
        if (loadMoreData) {
            loadMoreData(self.pageIndex);
        }
    }];
    [footer setTitle:@"" forState:MJRefreshStateIdle];//设置闲置状态下不显示“点击或上拉加载更多”
    tableView.mj_footer = footer;
}

///获取当前AppDelegate
- (id)AppDelegate {
    id appDelegate = [UIApplication sharedApplication].delegate;
    return appDelegate;
}

- (id)previousViewControllerAtIndex:(NSUInteger)index {
    NSArray* viewControllers = self.navigationController.viewControllers;
    NSUInteger viewControllersCount = viewControllers.count;
    if (index < viewControllersCount) {
        id previousViewController = [self.navigationController.viewControllers objectAtIndex:index];
        return previousViewController;
    } else {
        NSAssert(index >= viewControllersCount, @"index超出viewControllersCount-数组越界");
        return nil;
    }
}

- (id)popToViewController:(Class)viewControllerClass {
    NSInteger index = 0;
    for (int i = 0; i < self.navigationController.viewControllers.count; i ++) {
        UIViewController* vc = self.navigationController.viewControllers[i];
        if ([vc isKindOfClass:[viewControllerClass class]]) {
            index = i;
        }
    }
    id popToVC = [self previousViewControllerAtIndex:index];
    return popToVC;
}

- (void)scrollToBottom:(UITableView*)tableView {
    [tableView beginUpdates];
    [tableView scrollToBottom:YES];
    [tableView endUpdates];
}

- (void)delay:(CGFloat)time delayAction:(BaseViewControllerDelayAction)delayAction {
    dispatch_time_t delay_time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delay_time, dispatch_get_main_queue(), ^{
        if (delayAction) {
            delayAction();
        }
    });
}

- (void)scrollToTop:(UIScrollView*)scrollView {
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)keyboardEndEditing {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void)resignAnyObjFirstResponder {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (UITabBarController *)rootTabBarController {
    UIViewController* rootViewController = kAppWindow.rootViewController;///取到根控制器
    RootTabBarController *rootTabBarController = (RootTabBarController*)rootViewController;///取到TabBarController
    return rootTabBarController;
}

- (void)whiteNavBackBtn {
    UIButton *navButton = [UIButton buttonWithType:UIButtonTypeCustom];
    navButton.frame = CGRectMake(0, 0, 40, 40);
    navButton.contentEdgeInsets =UIEdgeInsetsMake(0, -30, 0, 0);
    [navButton setImage:whiteNavImage forState:UIControlStateNormal];
    [navButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navButton];
}

- (void)blackNavBackBtn {
    UIButton *navButton = [UIButton buttonWithType:UIButtonTypeCustom];
    navButton.frame = CGRectMake(0, 0, 40, 40);
    navButton.contentEdgeInsets =UIEdgeInsetsMake(0, -30, 0, 0);
    [navButton setImage:[UIImage imageNamed:@"blackNav"] forState:UIControlStateNormal];
    [navButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navButton];
}

- (void)restoreNavBar {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage xlsn0w_imageWithColor:AppThemeColor]
                                                 forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:AppWhiteColor,
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17]}];
}

- (void)resetWhiteNavBar {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage xlsn0w_imageWithColor:UIColor.whiteColor]
                                                 forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:AppBlackTextColor,
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17]}];
}

- (void)resetNavBarFromBgColor:(UIColor*)bgColor titleColor:(UIColor*)titleColor {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage xlsn0w_imageWithColor:UIColor.whiteColor]
    forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor,
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17]}];
}

- (void)resetBlackNavBar {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage xlsn0w_imageWithColor:UIColor.whiteColor]
    forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:AppWhiteColor,
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17]}];
}

- (void)navBackBtn {
//    XLsn0wLog(@"导航栏层级数 = %ld", self.navigationController.viewControllers.count);
    if (self.navigationController.viewControllers.count != 1) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:whiteNavImage
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self
                                                                                action:@selector(backAction)];
    }
}

- (void)clipRoundCornersFromView:(UIView*)view {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(6, 6)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    
    maskLayer.frame = view.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    view.layer.mask = maskLayer;
}

- (void)popNav {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)popRootNav {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//获得某个范围内的屏幕图像
- (UIImage* )imageFromRect:(CGRect)rect {
    UIGraphicsBeginImageContext([[UIScreen mainScreen] bounds].size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate; //获取app的appdelegate，便于取到当前的window用来截屏
    [app.window.layer renderInContext:context];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    

    CGRect myImageRect = rect;
    UIImage* bigImage= img;
    CGImageRef imageRef = bigImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
    CGSize size;
    size.width = 150;
    size.height = 150;
    UIGraphicsBeginImageContext(size);
    CGContextRef context2 = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context2, myImageRect, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    return smallImage;
}

- (void)call:(NSString *)phoneNumber {
    UIWebView *callWebView = [[UIWebView alloc] init];
    [self.view addSubview:callWebView];
    NSURL* callURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phoneNumber]];
    [callWebView loadRequest:[NSURLRequest requestWithURL:callURL]];
}

- (void)presentLoginViewController {
    LoginViewController *loginVC = [LoginViewController new];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIViewController*)getVisibleViewControllerFromNavigationController:(BaseNavigationController*)nav {
    return nav.visibleViewController;
}

- (BaseNavigationController*)getNavigationControllerInTabBar {
    ///取到根控制器
    UIViewController* rootViewController = kAppWindow.rootViewController;
    
    ///取到TabBarController
    RootTabBarController *tabBarController = (RootTabBarController*)rootViewController;
    
    ///取到NavigationController
    BaseNavigationController * nav = (BaseNavigationController *)tabBarController.selectedViewController;
    
    return nav;
}

- (BaseNavigationController*)getNavigationControllerInLogin {
    ///取到根控制器
    UIViewController* rootViewController = kAppWindow.rootViewController;
    ///取到NavigationController
    BaseNavigationController * nav = (BaseNavigationController *)rootViewController;
    
    return nav;
}

- (float)navHeight {
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    CGRect rectNav = self.navigationController.navigationBar.frame;
    _navHeight = rectStatus.size.height + rectNav.size.height;
    return _navHeight;
}

- (float)tabBarHeight {
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    if (self.navHeight>64) {
        _tabBarHeight = tabBarVC.tabBar.frame.size.height +34;
    }else {
        _tabBarHeight = tabBarVC.tabBar.frame.size.height;
    }
    return _tabBarHeight;
}

- (float)safeAreaBottomHeight {
    if (self.navHeight > 64) {
        _safeAreaBottomHeight = 34;
    }else {
        _safeAreaBottomHeight = 0;
    }
    return _safeAreaBottomHeight;
}

- (float)statusBarHeight {
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    _statusBarHeight = rectStatus.size.height;
    return _statusBarHeight;
}

/// 获取Nav
- (UINavigationController *)getNavigationController {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    if ([window.rootViewController isKindOfClass:[UINavigationController class]]) {
        
        return (UINavigationController *)window.rootViewController;
        
    } else if ([window.rootViewController isKindOfClass:[UITabBarController class]]) {
        
        UIViewController *selectedVC = [((UITabBarController *)window.rootViewController)selectedViewController];
        
        if ([selectedVC isKindOfClass:[UINavigationController class]]) {
            
            return (UINavigationController *)selectedVC;
        }
    }
    return nil;
}

- (void)navRightBtnWithTitle:(NSString *)title
                     imgName:(NSString *)imgName
        buttonImageTitleType:(ButtonImgViewStyle)type
            buttontitleColor:(UIColor *)color {
    UIButton* navRightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [navRightBtn setTitle:title forState:UIControlStateNormal];
    [navRightBtn setImage:[[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    navRightBtn.titleLabel.font = SYSTEMFONT(15);
    [navRightBtn setTitleColor:color forState:UIControlStateNormal];
    [navRightBtn addTarget:self action:@selector(navRightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [navRightBtn setImgViewStyle:type imageSize:CGSizeMake(20, 20) space:5.f];
    [navRightBtn sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navRightBtn];
}

- (void)navRightButtonClick:(UIButton *)navRightBtn {
    
}

- (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]){
        result = nextResponder;
    }else{
        result = window.rootViewController;
    }
    return result;
}

#pragma mark - 提示
- (void)showTipHUD:(NSString *)tip delay:(NSTimeInterval)delay {
    TipHUD *tipHUD = [TipHUD showHUDAddedTo:self.view animated:YES];
    tipHUD.mode = RQMBProgressHUDModeCustomView;
    tipHUD.detailsLabelFont = [UIFont systemFontOfSize:15];
    tipHUD.removeFromSuperViewOnHide = YES;
    tipHUD.detailsLabelText = tip;
    [tipHUD hide:YES afterDelay:delay];
}

#pragma mark - 以控制添加多个控制器
- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController {
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0.0f options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
        [newController didMoveToParentViewController:self];
        [oldController willMoveToParentViewController:nil];
        [oldController removeFromParentViewController];
        self.currentVC = newController;
    }];
}

- (void)startLocation {
    [XLsn0wLocationSharedManager startLocation];
    XLsn0wLocationSharedManager.locationAction = ^(NSString *country, NSString *province, NSString *city, NSString *area, CLLocationDegrees latitude, CLLocationDegrees longitude) {
//        XLsn0wLog(@"纬度 = %f", latitude);
//        XLsn0wLog(@"经度 = %f", longitude);
        if (self.locationAction) {
            self.locationAction(country, province, city, area, latitude, longitude);
        }
    };
}

/// 跳转到指定的前面跳来的页面
- (void)pushTargetViewController:(NSString *)targetClass {
    // 类名
    NSString *class = [NSString stringWithFormat:@"%@", targetClass];
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    
    // 从一个字串返回一个类
    Class newClass = objc_getClass(className);
    if (!newClass) {
        // 创建一个类
        Class superClass = [NSObject class];
        newClass = objc_allocateClassPair(superClass, className, 0);
        // 注册你创建的这个类
        objc_registerClassPair(newClass);
    }
    // 创建对象
    id vc = [[newClass alloc] init];
   
    
    // 获取导航控制器
    UITabBarController *tabVC = self.rootTabBarController;
    UINavigationController *pushClassStance = (UINavigationController *)tabVC.viewControllers[tabVC.selectedIndex];
    // 跳转到对应的控制器
    [pushClassStance pushViewController:vc animated:YES];
}

@end
