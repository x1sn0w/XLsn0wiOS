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
#import "AppDelegate+Extension.h"
#import "AppDelegate+RCIM.h"
#import "LoginViewController.h"
#import "GuidePageManager.h"
#import "AppFPSLabel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate (Extension)

+ (AppDelegate*)shared {
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

+ (UIApplication*)application {
    UIApplication *application = [UIApplication sharedApplication];
    return application;
}

- (void)delay:(NSTimeInterval)time {
    [NSThread sleepForTimeInterval:time];
}

#pragma mark ****** 初始化window ****
- (void)initWindow {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self addLoginStatusNotificationAndSetRootViewController];
    [[UserPlister shared] createUserPlist];
    [XLsn0wNetworking checkingNetworkResult:^(NetworkStatus status) {
        if (status == StatusNotReachable) {
            [TipShow showCenterText:@"网络断开"];
        }
        if (status == StatusUnknown) {
            [TipShow showCenterText:@"未知网络"];
        }
    }];
    [self initAppConfig];
    
    if ([ServerDomain isEqualToString:@"http://192.168.124.32:8080/chinesemedicine"]) {
        CGRect FPSLabelRect;
        if (iPhoneX || iPhoneXr || iPhoneXs_Max) {
            FPSLabelRect = CGRectMake(kScreenWidth/2-88/2, kStatusBarHeight-15, 88, 20);
        } else {
            FPSLabelRect = CGRectMake(kScreenWidth/2+30, 0, 88, 20);
        }
        AppFPSLabel *appFPSLabel = [[AppFPSLabel alloc] initWithFrame:FPSLabelRect];
        appFPSLabel.backgroundColor = AppLightGrayTextColor;
        [self.window addSubview:appFPSLabel];
    }
    
    [self addNetworkCheckObserver];
}

- (void)addNetworkCheckObserver {
       [[NSNotificationCenter defaultCenter] addObserver:self
                                                selector:@selector(networkChanged:)
                                                    name:ZYNetworkAccessibityChangedNotification
                                                  object:nil];
        NSLog(@"networkChanged : %@", NSStringFromZYNetworkAccessibleState(NetworkPermission.currentState));
    
}

static NSString * NSStringFromZYNetworkAccessibleState(ZYNetworkAccessibleState state) {
    return state == ZYNetworkChecking   ? @"ZYNetworkChecking"   :
           state == ZYNetworkUnknown    ? @"ZYNetworkUnknown"    :
           state == ZYNetworkAccessible ? @"ZYNetworkAccessible" :
           state == ZYNetworkRestricted ? @"ZYNetworkRestricted" : nil;
}

- (void)networkChanged:(NSNotification *)notification {
    
    ZYNetworkAccessibleState state = NetworkPermission.currentState;
    
    //self.label.text = NSStringFromZYNetworkAccessibleState(state);
    
    NSLog(@"networkChanged : %@",NSStringFromZYNetworkAccessibleState(state));
}


/*XLsn0w*
 ///接收登录状态通知
 */
- (void)addLoginStatusNotificationAndSetRootViewController {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNotificationLoginStateChange
                                               object:nil];///必须先添加观察者
    PostNotification(KNotificationLoginStateChange, @NO);///然后发通知才有执行者 NO为未登录 YES为登录
}

- (void)dealloc {
    [NotificationDefaultCenter removeObserver:self];
}

#pragma mark ————— 登录状态处理 —————
- (void)loginStateChange:(NSNotification *)notifiction {
    BOOL isLoginSuccess = [notifiction.object boolValue];
    if (isLoginSuccess) {/// 登陆成功加载主窗口控制器
        [self setRootViewControllerEqualToTabBarController];
    } else {
        [self setRootViewControllerEqualToLoginViewController];
    }
}

- (void)setRootViewControllerEqualToTabBarController {
    ///为避免自动登录成功刷新tabbar
    if (!self.tabBarController || ![self.window.rootViewController isKindOfClass:[RootTabBarController class]]) {
        self.tabBarController = [[RootTabBarController alloc]init];
        CATransition *anima = [CATransition animation];
        anima.type = TrAnimaType_Fade;//设置动画的类型
        anima.subtype = kCATransitionFromRight; //设置动画的方向
        anima.duration = 0.5f;
        self.window.rootViewController = self.tabBarController;
        [kAppWindow.layer addAnimation:anima forKey:@"revealAnimation"];
    }
}

- (void)setRootViewControllerEqualToLoginViewController {
    [UserDefaulter deleteValueForKey:@"token"];
    self.tabBarController = nil;
    LoginViewController *login_vc =[[LoginViewController alloc] init];
    BaseNavigationController *loginNav = [[BaseNavigationController alloc] initWithRootViewController:login_vc];
    CATransition *anima = [CATransition animation];
    anima.type = TrAnimaType_Fade;//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 0.3f;
    self.window.rootViewController = loginNav;
    [kAppWindow.layer addAnimation:anima forKey:@"revealAnimation"];
}

#pragma mark - 返回主线程刷新UI
- (void)mainQueueRefreshUI:(AppDelegateMainQueueRefreshUIAction)mainQueueRefreshUI {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        if (mainQueueRefreshUI) {///需要在主线程执行的代码
            mainQueueRefreshUI();
        }
    }];
}

#pragma mark - 添加引导页
- (void)addGuidePage {
    GuidePager.images = @[[UIImage imageNamed:@"0"],
                          [UIImage imageNamed:@"1"],
                          [UIImage imageNamed:@"2"]];
    
    //     GuidePager.dismissButtonImage = [UIImage imageNamed:@"dismissButtonImage"];
    //     GuidePager.dismissButtonCenter = CGPointMake(kScreenWidth / 2, kScreenHeight - 80);
    
    //方式二:
    GuidePager.shouldDismissWhenDragging = YES;
    [GuidePager begin];
}

#pragma mark ————— 初始化服务 —————

- (void)showPrivateAlert {
//    [self getPrivacyWebURL];
//    NSString* agreeCallback = [UserDefaulter selectValueFromKey:@"agreeCallback"];
//    if (!agreeCallback) {
//        NSArray* contents = @[@"        时间林会尽全力保护您的个人信息安全可靠，恪守以下原则，保护您的个人信息：权责一致原则、目的明确原则、选择同意原则、最少够用原则、确保安全原则、主体参与原则、公开透明原则等。同时，我们承诺，我们将按业界成熟的安全标准，采取相应的安全保护措施来保护您的个人信息。"];
//        PrivateAlertService* alert = [PrivateAlertService new];
//        ///取到NavigationController
//        BaseNavigationController * nav = (BaseNavigationController *)[self getNavigationController];
//        UIViewController * visibleVC = (UIViewController *)nav.visibleViewController;
//        ///显示隐私弹窗
//        [alert showWith:contents
//                     in:visibleVC.view
//          agreeCallback:^{
//              [UserDefaulter insertValue:@"agreeCallback" key:@"agreeCallback"];///同意
//          } disAgreeCallback:^{
//              UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"退出应用警告"
//                                                                             message:@"您不同意《隐私政策》将会退出应用"
//                                                                      preferredStyle:UIAlertControllerStyleAlert];
//              UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//              UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//                  [self exitApp];///不同意->退出App
//              }];
//              [alert addAction:cancelAction];
//              [alert addAction:okAction];
//              [visibleVC presentViewController:alert animated:YES completion:nil];
//          } privateProCallback:^{///跳转隐私协议
//              ProtocolsWebViewController *vc = [[ProtocolsWebViewController alloc] init];
//              vc.isHideNavigationBar = NO;
//              vc.canRefresh = NO;// 是否刷新
//              vc.title = @"隐私政策";
//              if (isNotNull(self.privacyWebUrl)) {
//                  vc.url = self.privacyWebUrl;
//              }
//              [[self getNavigationController] pushViewController:vc animated:true];
//          }];
//    }
}

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

- (void)exitApp {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
        show(@"正在退出...");
    } completion:^(BOOL finished) {
        exit(0);
    }];
}

- (void)initService {
    //注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNotificationLoginStateChange
                                               object:nil];
    
    //网络状态监听
    [NotificationDefaultCenter addObserver:self
                                  selector:@selector(netWorkStateChange:)
                                      name:KNotificationNetWorkStateChange
                                    object:nil];
}

#pragma mark ————— 初始化window —————
- (void)initAppConfig {
    [UIButton appearance].exclusiveTouch = YES;///ExclusiveTouch的作用是：避免在一个界面上同时点击多个UIButton导致同时响应多个方法。
    [UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:@[[MBProgressHUD class]]].color = KWhiteColor;;
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [self config_estimatedHeight];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kAppLightGrayColor} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#06ACE8"]} forState:UIControlStateSelected];
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"完成";
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    NSDictionary *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"User"];
    if (isNotNull(user)) {
        [self connectRCToken];
        PostNotification(KNotificationLoginStateChange, @YES);
    } else {
        PostNotification(KNotificationLoginStateChange, @NO);
    }
}

#pragma mark ————— 初始化网络配置 —————
-(void)NetWorkConfig{
    
}

-(void)config_estimatedHeight {
    [UITableView appearance].estimatedRowHeight = 0;
    [UITableView appearance].estimatedSectionHeaderHeight = 0;
    [UITableView appearance].estimatedSectionFooterHeight = 0;
}

- (void)addUncaughtException {
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);///捕获异常
}

void UncaughtExceptionHandler(NSException *exception) {
    XLsn0wLog(@"exception(异常信息) = %@", exception);
    //[UserDefaulter insertValue:exception key:@"exception"];
    ///存储 exception  上传服务器 或者保存本地
}

#pragma mark ————— 初始化用户系统 —————
- (void)configLogin {
    
}

#pragma mark ————— 网络状态变化 —————
- (void)netWorkStateChange:(NSNotification *)notification {

}

#pragma mark ————— 友盟 初始化 —————
-(void)initUMeng{
    /* 打开调试日志 */
//    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    //    [[UMSocialManager defaultManager] setUmSocialAppkey:UMengKey];
    
    [self configUSharePlatforms];
}
#pragma mark ————— 配置第三方 —————
-(void)configUSharePlatforms{
    /* 设置微信的appKey和appSecret */
    //    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:kAppKey_Wechat appSecret:kSecret_Wechat redirectURL:nil];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    //    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:kAppKey_Tencent/*设置QQ平台的appID*/  appSecret:nil redirectURL:nil];
}

#pragma mark ————— OpenURL 回调 —————
//// 支持所有iOS系统。注：此方法是老方法，建议同时实现 application:openURL:options: 若APP不支持iOS9以下，可直接废弃当前，直接使用application:openURL:options:
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
//    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
//    if (!result) {
//        // 其他如支付等SDK的回调
//    }
//    return result;
//}
//
//// NOTE: 9.0以后使用新API接口
//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
//{
//    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
//    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url options:options];
//    if (!result) {
//        // 其他如支付等SDK的回调
//        if ([url.host isEqualToString:@"safepay"]) {
//            //跳转支付宝钱包进行支付，处理支付结果
//            //            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            //                NSLog(@"result = %@",resultDic);
//            //            }];
//            return YES;
//        }
//        //        if  ([OpenInstallSDK handLinkURL:url]){
//        //            return YES;
//        //        }
//        //        //微信支付
//        //        return [WXApi handleOpenURL:url delegate:[PayManager sharedPayManager]];
//    }
//    return result;
//}

- (BaseNavigationController*)getNavFromTabBar {
    ///取到根控制器
    UIViewController* rootViewController = kAppWindow.rootViewController;
    
    ///取到TabBarController
    RootTabBarController *tabBarController = (RootTabBarController*)rootViewController;
    
    ///取到NavigationController
    BaseNavigationController * nav = (BaseNavigationController *)tabBarController.selectedViewController;
    
    return nav;
}

-(UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

-(UIViewController *)getCurrentUIVC
{
    UIViewController  *superVC = [self getCurrentVC];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    return superVC;
}

- (void)addAvoidCrash {

}

- (void)dealwithCrashMessage:(NSNotification *)note {
    //不论在哪个线程中导致的crash，这里都是在主线程
    
    //注意:所有的信息都在userInfo中
    //你可以在这里收集相应的崩溃信息进行相应的处理(比如传到自己服务器)
    //详细讲解请查看 https://github.com/chenfanfang/AvoidCrash
}

@end
