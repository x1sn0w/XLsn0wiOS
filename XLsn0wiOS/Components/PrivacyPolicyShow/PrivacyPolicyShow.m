
#import "PrivacyPolicyShow.h"
#import <UIKit/UIKit.h>

#define isFirstKey    @"isFirstYinSi"
#define isFirstValue  @"1"

@interface PrivacyPolicyShow ()

@property(nonatomic,strong)UIWindow * window;
@property (nonatomic, strong) UIView *frontView;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIButton *closeBtn;

@end
@implementation PrivacyPolicyShow

+ (void)load {
    [self shareManager];
}

+ (PrivacyPolicyShow *)shareManager {
    static PrivacyPolicyShow *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[PrivacyPolicyShow alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //在UIApplicationDidFinishLaunching时初始化开屏广告,做到对业务层无干扰,当然你也可以直接在AppDelegate didFinishLaunchingWithOptions方法中初始化
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:isFirstKey] intValue] == [isFirstValue intValue]) {}else{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self showPrivacyPolicy];
                });
            }
        }];
    }
    return self;
}

- (void)showPrivacyPolicy {
    _window = [UIApplication sharedApplication].keyWindow;
    [_window addSubview:self.frontView];
    [self.frontView addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-35);
        make.right.mas_equalTo(-30);
        make.width.mas_equalTo(140*scale_width);
        make.height.mas_equalTo(50*scale_width);
    }];
    
    UIView* line = [[UIView alloc] init];
    [self.frontView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(2);
        make.bottom.mas_equalTo(-118);
    }];
    line.backgroundColor = AppLineColor;
    [self webView];
    
    UIButton* refuseBtn = [[UIButton alloc] init];
    [refuseBtn setTitle:@"拒绝" forState:UIControlStateNormal];
    [refuseBtn xlsn0w_layerBorderWidth:1 borderColor:AppThemeColor cornerRadius:20];
    [refuseBtn setTitleColor:AppThemeColor forState:UIControlStateNormal];
    [refuseBtn addTarget:self action:@selector(refuseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    refuseBtn.backgroundColor = AppWhiteColor;
    [self.frontView addSubview:refuseBtn];
    [refuseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-35);
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(140*scale_width);
        make.height.mas_equalTo(50*scale_width);
    }];
}

- (void)refuseBtnClick {
    [self exitApp];///不同意->退出App
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

- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(10, 40, kScreenWidth - 20, kScreenHeight- 160) configuration:config];
        NSURL* url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"PrivacyPolicyShow" ofType:@"html"]];
        [_webView loadRequest:[NSURLRequest requestWithURL:url]];
        _webView.scrollView.bounces = NO;
        [self.frontView addSubview:_webView];
    }
    return _webView;
}

- (UIView *)frontView {
    if (!_frontView) {
        UIView * theView = [[UIView alloc] init];
        theView.backgroundColor = [UIColor whiteColor];
        theView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        _frontView = theView;
    }
    return _frontView;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] init];
        [_closeBtn setTitle:@"同意" forState:UIControlStateNormal];
        [_closeBtn xlsn0w_addCornerRadius:20];
        [_closeBtn setTitleColor:AppWhiteColor forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeButClick) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.backgroundColor = AppThemeColor;
    }
    return _closeBtn;
}

- (void)closeButClick {
    [[NSUserDefaults standardUserDefaults] setObject:isFirstValue forKey:isFirstKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.frontView removeFromSuperview];
}

@end
