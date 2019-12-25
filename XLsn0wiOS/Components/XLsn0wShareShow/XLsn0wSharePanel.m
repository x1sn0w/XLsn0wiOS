
#import "XLsn0wSharePanel.h"

typedef NS_ENUM(NSInteger, BossShareType) {
    BossShareTypeWXFriend,
    BossShareTypeWXTimeLine,
    BossShareTypeSM
};

static const CGFloat panelHeight = 160;

@interface XLsn0wSharePanel ()
// mask
@property (nonatomic, strong) UIView *alphaMaskView;
// panel
@property (nonatomic, strong) UIVisualEffectView* shareBtnVisualEffectView;

@end

@implementation XLsn0wSharePanel

- (instancetype)initWithDelegate:(id<XLsn0wShareKitDelegate>)delegate {
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        [self addSubview:self.alphaMaskView];
        self.delegate = delegate;
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        [self addSubview:self.alphaMaskView];
    }
    return self;
}

- (void)show {
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.shareBtnVisualEffectView.frame;
        frame.origin.y = kScreenHeight - frame.size.height;
        self.shareBtnVisualEffectView.frame = frame;
        self.alphaMaskView.alpha = 0.8;
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(sharePanelDidShow:)]) {
            [self.delegate sharePanelDidShow:self];
        }
        [kAppWindow addSubview:self];///show
        if ([self canOpenWXApp] == NO) {
            show(@"请安装微信客户端!");
        }
    }];
}

- (BOOL)isWXAppInstalled{
    
    // 判断是否安装微信
    
    if ([WXApi isWXAppInstalled] ){
        
        //判断当前微信的版本是否支持OpenApi
        
        if ([WXApi isWXAppSupportApi]) {
            
            NSLog(@"安装了");
            
            return YES;
            
        }else{
            
            NSLog(@"请升级微信至最新版本！");
            
            return NO;
            
        }
        
    }else{
        
        NSLog(@"请安装微信客户端");
        
        return NO;
        
    }
    
}

- (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.shareBtnVisualEffectView.frame;
        frame.origin.y = kScreenHeight;
        self.shareBtnVisualEffectView.frame = frame;
        self.alphaMaskView.alpha = 0;
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(sharePanelDidDismiss:)]) {
            [self.delegate sharePanelDidDismiss:self];
        }
        [self removeFromSuperview];
    }];
}

#pragma mark - Getters

- (UIView *)alphaMaskView {
    if (!_alphaMaskView) {
        _alphaMaskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-panelHeight-kHomeIndicatorH)];
        _alphaMaskView.backgroundColor = [UIColor darkGrayColor];
        _alphaMaskView.alpha = 0.f;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [_alphaMaskView addGestureRecognizer:tap];
    }
    return _alphaMaskView;
}

- (UIVisualEffectView *)shareBtnVisualEffectView {
    if (!_shareBtnVisualEffectView) {

        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _shareBtnVisualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        [self addSubview:self.shareBtnVisualEffectView];
        _shareBtnVisualEffectView.backgroundColor = AppWhiteColor;
        [_shareBtnVisualEffectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(panelHeight);
            make.width.mas_equalTo(kScreenWidth);
            if (@available(iOS 11.0, *)) {///底部适配X
                make.bottom.equalTo(self.mas_safeAreaLayoutGuideBottom);
            } else {
                make.bottom.equalTo(self.mas_bottom);
            }
        }];
        
        if (iPhoneX || iPhoneXr || iPhoneXs_Max) {///适配
            UIView* whiteView = [UIView new];
            [self addSubview:whiteView];
            [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.height.mas_equalTo(34);
                make.bottom.mas_equalTo(0);
            }];
            whiteView.backgroundColor = AppWhiteColor;
        }
        
        // cancel button
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, panelHeight-40, kScreenWidth, 40)];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:App333333TitleColor forState:UIControlStateNormal];
        [cancelButton setBackgroundImage:[UIImage xlsn0w_imageWithColor:AppLineColor] forState:(UIControlStateHighlighted)];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightThin];
        [cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [_shareBtnVisualEffectView.contentView addSubview:cancelButton];
        
        UIButton *wechatTimeLine = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtnVisualEffectView.contentView addSubview:wechatTimeLine];
        [wechatTimeLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(103);
            make.top.mas_equalTo(38);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(55);
        }];
        [wechatTimeLine setTitleColor:App999999TitleColor forState:UIControlStateNormal];
        wechatTimeLine.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
        [wechatTimeLine setTitle:@"朋友圈" forState:UIControlStateNormal];
        [wechatTimeLine setImage:[UIImage imageNamed:@"WechatTimeLineIcon"] forState:UIControlStateNormal];
        [wechatTimeLine setButtonImageTitleStyle:ButtonImageTitleStyleTop padding:10];
        wechatTimeLine.tag = BossShareTypeWXFriend;
        [wechatTimeLine addTarget:self action:@selector(clickShareButton:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *wechatSession = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtnVisualEffectView.contentView addSubview:wechatSession];
        [wechatSession mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-103);
            make.top.mas_equalTo(38);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(55);
        }];
        
        [wechatSession setTitleColor:App999999TitleColor forState:UIControlStateNormal];
        wechatSession.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
        [wechatSession setTitle:@"微信" forState:UIControlStateNormal];
        [wechatSession setImage:[UIImage imageNamed:@"WechatSessionIcon"] forState:UIControlStateNormal];
        [wechatSession setButtonImageTitleStyle:ButtonImageTitleStyleTop padding:10];
        wechatSession.tag = BossShareTypeWXTimeLine;
        [wechatSession addTarget:self action:@selector(clickShareButton:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *top_line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
        top_line.backgroundColor = AppLineColor;
        [_shareBtnVisualEffectView.contentView addSubview:top_line];
        
        // 底部分割线
        UIView *bottom_line = [[UIView alloc] initWithFrame:CGRectMake(0, panelHeight-40-8, kScreenWidth, 8)];
        bottom_line.backgroundColor = HexColor(@"#E8E8E8");
        [_shareBtnVisualEffectView.contentView addSubview:bottom_line];
        
        if ([self canOpenWXApp] == NO) {///如果微信未安装 -> 把微信相关按钮隐藏掉
            wechatTimeLine.hidden = YES;
            wechatSession.hidden = YES;
        } else {
            wechatTimeLine.hidden = NO;
            wechatSession.hidden = NO;
        }
    }
    return _shareBtnVisualEffectView;
}

- (BOOL)canOpenWXApp {
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"wechat://"]] ) {
        return NO;
    } else {
        return YES;
    }
}

- (void)clickShareButton:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(shareFromBtnTag:)]) {
        [self.delegate shareFromBtnTag:button.tag];
    }
    if (self.clickBtnAction) {
        self.clickBtnAction(button.tag);
    }
    [self dismiss];
}

@end
