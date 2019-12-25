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
#import "AppDelegate.h"

typedef void(^AppDelegateMainQueueRefreshUIAction)(void);

@interface AppDelegate (Extension)

+ (AppDelegate*)shared;
+ (UIApplication*)application;

- (void)showPrivateAlert;
- (void)mainQueueRefreshUI:(AppDelegateMainQueueRefreshUIAction)mainQueueRefreshUI;
- (UINavigationController *)getNavigationController;///获取nav

- (void)delay:(NSTimeInterval)time;///启动页延迟时间

//初始化 window
- (void)initWindow;

//初始化服务
- (void)initService;

//初始化 window
- (void)initAppConfig;

//初始化 UMeng
- (void)initUMeng;

- (void)config_estimatedHeight;
- (void)addUncaughtException;

//初始化用户系统
-(void)configLogin;

//初始化网络配置
-(void)NetWorkConfig;

- (void)addGuidePage;

- (void)addAvoidCrash;
- (void)dealwithCrashMessage:(NSNotification *)note;

/**
 当前顶层控制器
 */
-(UIViewController*) getCurrentVC;

-(UIViewController*) getCurrentUIVC;

- (BaseNavigationController*)getNavFromTabBar;

@end
