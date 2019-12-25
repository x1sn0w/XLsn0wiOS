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
/*
1、viewDidLoad载入完成，可以进行自定义数据以及动态创建其他控件

2、viewWillAppear视图将出现在屏幕之前，马上这个视图就会被展现在屏幕上了

3、viewDidAppear视图已在屏幕上渲染完成 当一个视图被移除屏幕并且销毁的时候的执行顺序，这个顺序差不多和上面的相反

4、viewWillDisappear视图将被从屏幕上移除之前执行

5、viewDidDisappear视图已经被从屏幕上移除，用户看不到这个视图了

6、dealloc视图被销毁，此处需要对你在init和viewDidLoad中创建的对象进行释放
*/
#import <UIKit/UIKit.h>
#import "BaseNavigationController.h"
#import <CoreLocation/CoreLocation.h>
#import "ImportHeader.h"

typedef void(^BaseViewControllerDelayAction)(void);
typedef void(^BaseViewControllerRefreshAction)(NSInteger pageIndex);
typedef void(^BaseViewControllerLocationManagerAction)(NSString *country,
                                                       NSString* province,
                                                       NSString* city,
                                                       NSString* county,
                                                       CLLocationDegrees latitude,
                                                       CLLocationDegrees longitude);

@interface BaseViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *userTypeArray;
@property (nonatomic, assign, readonly) float navHeight;//导航栏的高度
@property (nonatomic, assign, readonly) float tabBarHeight;
@property (nonatomic, assign, readonly) float statusBarHeight;
@property (nonatomic, assign, readonly) float safeAreaBottomHeight;
@property (nonatomic, strong) UIButton *navRightBtn;//导航右侧按钮
@property (nonatomic, strong) UIViewController *currentVC;//一个视图控制器上有多个视图控制器用到
@property (nonatomic, assign) NSInteger pageIndex;

- (void)pushTargetViewController:(NSString *)targetClass;

- (id)AppDelegate;///获取当前AppDelegate
- (id)popToViewController:(Class)viewControllerClass;
- (void)backAction;
- (id)previousViewControllerAtIndex:(NSUInteger)index;
- (void)keyboardEndEditing;
- (void)resignAnyObjFirstResponder;
- (float)safeAreaBottomHeight;
- (void)navBackBtn;
- (UINavigationController *)getNavigationController;///获取当前活动的navigationcontroller
- (BaseNavigationController*)getNavigationControllerInTabBar;
- (UITabBarController *)rootTabBarController;
- (UIImage *)imageFromRect:(CGRect)rect;//获得某个范围内的屏幕图像
- (void)presentLoginViewController;
- (void)delay:(CGFloat)time delayAction:(BaseViewControllerDelayAction)delayAction;

- (void)addRefreshFromTableView:(UITableView*)tableView
                       loadData:(BaseViewControllerRefreshAction)loadData
                   loadMoreData:(BaseViewControllerRefreshAction)loadMoreData;
- (void)endRefreshFromTableView:(UITableView*)tableView;

- (void)scrollToBottom:(UITableView*)tableView;
- (void)scrollToTop:(UIScrollView*)scrollView;///滚动到顶部
- (void)resetWhiteNavBar;
- (void)resetBlackNavBar;
- (void)restoreNavBar;
- (void)blackNavBackBtn;
- (void)whiteNavBackBtn;
- (void)popNav;
- (void)popRootNav;
- (void)call:(NSString *)phoneNumber;
- (void)clipRoundCornersFromView:(UIView*)view;
- (void)resetNavBarFromBgColor:(UIColor*)bgColor
                    titleColor:(UIColor*)titleColor;
/**
 导航栏添加文本按钮
 titles 、 image 文本 图片名称
 ButtonImgViewStyle 图片显示的位置
 color 字体的颜色
 */
- (void)navRightBtnWithTitle:(NSString *)title
                     imgName:(NSString *)imgName
        buttonImageTitleType:(ButtonImgViewStyle)type
            buttontitleColor:(UIColor *)color;

//导航栏右按钮点击事件
- (void)navRightButtonClick:(UIButton *)navRightBtn;

//信息提示
- (void)showTipHUD:(NSString *)tip delay:(NSTimeInterval)delay;

- (UIViewController *)getCurrentVC;

/*
 一个控制器上有多个控制器的方法
 currenVC         创建一个UIViewController *currenVC
 oldController
 newController
 */
- (void)replaceController:(UIViewController *)oldController
            newController:(UIViewController *)newController;

@property (nonatomic, copy) BaseViewControllerLocationManagerAction locationAction;
- (void)startLocation;

@end
