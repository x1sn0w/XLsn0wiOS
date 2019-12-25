
#import "BaseNavigationController.h"
#import "ViewControllerTransitionProtocol.h"
#import "ViewControllerTransition.h"
@interface BaseNavigationController () <UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, weak) id popDelegate;
@property (nonatomic,strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;
@property (nonatomic,strong) UIScreenEdgePanGestureRecognizer *popRecognizer;
@property(nonatomic,assign) BOOL isSystemSlidBack;//是否开启系统右滑返回

@end

@implementation BaseNavigationController

//APP生命周期中 只会执行一次
+ (void)initialize {
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBarTintColor:NavBgColor];
    [navBar setTintColor:NavTitleColor];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName :NavTitleColor,
                                     NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(-SCREEN_WIDTH-200, 0) forBarMetrics:UIBarMetricsDefault];
    [navBar setBackgroundImage:[UIImage xlsn0w_imageWithColor:NavBgColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:[UIImage new]];///隐藏底部黑线
    
//    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, autoNavBarHeight)];
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(1, 1);
//    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:195/255.0 green:14/255.0 blue:34/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:255/255.0 green:95/255.0 blue:0/255.0 alpha:1.0].CGColor];
//    gradientLayer.locations = @[@(0.0),@(1.0f)];
//
//    gradientLayer.frame = backView.frame;
//    [backView.layer addSublayer:gradientLayer];
//
//    CGSize s = backView.bounds.size;
//    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需  要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
//    UIGraphicsBeginImageContextWithOptions(s, YES, [UIScreen mainScreen].scale);
//    [backView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}
    
-(UIImage*)convertViewToImage:(UIView*)v{
        CGSize s = v.bounds.size;
        // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需  要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
        UIGraphicsBeginImageContextWithOptions(s, YES, [UIScreen mainScreen].scale);
        [v.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
    //默认开启系统右划返回
    self.interactivePopGestureRecognizer.enabled = YES;
    self.interactivePopGestureRecognizer.delegate = self;
    _popRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleNavigationTransition:)];
    _popRecognizer.edges = UIRectEdgeLeft;
    [_popRecognizer setEnabled:NO];
    [self.view addGestureRecognizer:_popRecognizer];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}

//解决手势失效问题
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (_isSystemSlidBack) {
        self.interactivePopGestureRecognizer.enabled = YES;
        [_popRecognizer setEnabled:NO];
    }else{
        self.interactivePopGestureRecognizer.enabled = NO;
        [_popRecognizer setEnabled:YES];
    }
}

//根视图禁用右划返回
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.childViewControllers.count == 1 ? NO : YES;
}

/**
 *  返回到指定的类视图
 *  ClassName 类名
 *  animated  是否动画
 */
-(BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated {
    id vc = [self getCurrentViewControllerClass:ClassName];
    if(vc != nil && [vc isKindOfClass:[UIViewController class]]) {
        [self popToViewController:vc animated:animated];
        return YES;
    }
    return NO;
}

/*!
 *  获得当前导航器显示的视图
 *  ClassName 要获取的视图的名称
 *  成功返回对应的对象，失败返回nil;
 */
-(instancetype)getCurrentViewControllerClass:(NSString *)ClassName {
    Class classObj = NSClassFromString(ClassName);
    NSArray * szArray =  self.viewControllers;
    for (id vc in szArray) {
        if([vc isMemberOfClass:classObj]) {
            return vc;
        }
    }
    return nil;
}

-(UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

#pragma mark - 转场动画区
#pragma clang diagnostic push
#pragma clang diagnostic ignored  "-Wincompatible-pointer-types"
//navigation切换是会走这个代理
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    self.isSystemSlidBack = YES;
    //如果来源VC和目标VC都实现协议，那么都做动画
    if ([fromVC conformsToProtocol:@protocol(ViewControllerTransitionProtocol)] && [toVC conformsToProtocol:@protocol(ViewControllerTransitionProtocol)]) {
        BOOL pinterestNedd = [self isNeedTransition:fromVC:toVC];
        ViewControllerTransition *transion = [ViewControllerTransition new];
        if (operation == UINavigationControllerOperationPush && pinterestNedd) {
            transion.isPush = YES;
            //暂时屏蔽带动画的右划返回
            self.isSystemSlidBack = NO;
            //            self.isSystemSlidBack = YES;
        }else if(operation == UINavigationControllerOperationPop && pinterestNedd){
            //暂时屏蔽带动画的右划返回
            //            return nil;
            transion.isPush = NO;
            self.isSystemSlidBack = NO;
        }else{
            return nil;
        }
        return transion;
    }else if([toVC conformsToProtocol:@protocol(ViewControllerTransitionProtocol)]){
        //如果只有目标VC开启动画，那么isSystemSlidBack也要随之改变
        BOOL pinterestNedd = [self isNeedTransition:toVC];
        self.isSystemSlidBack = !pinterestNedd;
        return nil;
    }
    return nil;
}
#pragma clang diagnostic pop

//判断fromVC和toVC是否需要实现pinterest效果
-(BOOL)isNeedTransition:(UIViewController<ViewControllerTransitionProtocol> *)fromVC :(UIViewController<ViewControllerTransitionProtocol> *)toVC {
    BOOL a = NO;
    BOOL b = NO;
    if ([fromVC respondsToSelector:@selector(isNeedTransition)] && [fromVC isNeedTransition]) {
        a = YES;
    }
    if ([toVC respondsToSelector:@selector(isNeedTransition)] && [toVC isNeedTransition]) {
        b = YES;
    }
    return (a && b) ;
}

//判断toVC是否需要实现pinterest效果
-(BOOL)isNeedTransition:(UIViewController<ViewControllerTransitionProtocol> *)toVC
{
    BOOL b = NO;
    if ([toVC respondsToSelector:@selector(isNeedTransition)] && [toVC isNeedTransition]) {
        b = YES;
    }
    return b;
}

#pragma mark - NavitionContollerDelegate
-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    if (!self.interactivePopTransition) {
        return nil;
    }
    return self.interactivePopTransition;
}
#pragma mark UIGestureRecognizer handlers
- (void)handleNavigationTransition:(UIScreenEdgePanGestureRecognizer*)recognizer {
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width);
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self popViewControllerAnimated:YES];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        CGPoint velocity = [recognizer velocityInView:recognizer.view];
        
        if (progress > 0.5 || velocity.x >100) {
            [self.interactivePopTransition finishInteractiveTransition];
        }
        else {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        self.interactivePopTransition = nil;
    }
}

@end
