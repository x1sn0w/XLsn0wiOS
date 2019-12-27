//
//  CKAlertViewController.m
//  JinJinHospital
//
//  Created by mc on 2017/9/28.
//  Copyright © 2017年 fbw. All rights reserved.
//

#import "XLsn0wBoldAlertController.h"
#import "XLsn0wAlertActioner.h"
#import "XLsn0wHighLightButton.h"
#import "XLsn0wiOSHeader.h"

#define kThemeColor [UIColor colorWithRed:94/255.0 green:96/255.0 blue:102/255.0 alpha:1]

@interface XLsn0wBoldAlertController () {
    UIView *_shadowView;
    UIEdgeInsets _contentMargin;
    CGFloat _contentViewWidth;
    CGFloat _buttonHeight;
    BOOL _firstDisplay;
}

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) NSMutableArray *mutableActions;
@property (strong, nonatomic) UIButton *grayBackgroundView;

@end

@implementation XLsn0wBoldAlertController

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message {
    XLsn0wBoldAlertController *vc = [XLsn0wBoldAlertController new];
    vc.title = title;
    vc.message = message;
    return vc;
}

- (instancetype)init {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        [self defaultSetting];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatShadowView];
    [self creatContentView];
    
    [self creatAllButtons];
    [self creatAllSeparatorLine];
    
    [self addTextContent];
}

- (void)addTextContent {/// 添加文本内容
    self.titleLabel.text = self.title;
    [self.messageLabel lineSpacing:5
                         titleFont:[UIFont systemFontOfSize:15]
                        titleColor:HexColor(@"#666666")
                              text:self.message
                         alignment:self.messageAlignment
                         boldRange:NSMakeRange(7, 5)];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    //更新标题的frame
    [self updateTitleLabelFrame];
    
    //更新message的frame
    [self updateMessageLabelFrame];
    
    //更新按钮的frame
    [self updateAllButtonsFrame];
    
    //更新分割线的frame
    [self updateAllSeparatorLineFrame];
    
    //更新弹出框的frame
    [self updateShadowAndContentViewFrame];
    
    //显示弹出动画
    [self showAppearAnimation];
}

- (void)defaultSetting {
    
    _contentMargin = UIEdgeInsetsMake(25, 20, 0, 20);
    _contentViewWidth = 285;
    _buttonHeight = 45;
    _firstDisplay = YES;
    _messageAlignment = NSTextAlignmentCenter;
}

#pragma mark - 创建内部视图

//阴影层
- (void)creatShadowView {
    _grayBackgroundView = [[UIButton alloc] initWithFrame:UIScreen.mainScreen.bounds];
    _grayBackgroundView.backgroundColor = RGBACOLOR(0, 0, 0, 0.4);
//    [_grayBackgroundView addTarget:self
//                            action:@selector(showDisappearAnimation)
//                  forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_grayBackgroundView];
    
    _shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _contentViewWidth, 175)];
    _shadowView.layer.masksToBounds = NO;
    _shadowView.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2].CGColor;
    _shadowView.layer.shadowRadius = 20;
    _shadowView.layer.shadowOpacity = 1;
    _shadowView.layer.shadowOffset = CGSizeMake(0, 10);
    [_grayBackgroundView addSubview:_shadowView];
}

//内容层
- (void)creatContentView {
    _contentView = [[UIView alloc] initWithFrame:_shadowView.bounds];
    _contentView.backgroundColor = [UIColor colorWithRed:250 green:251 blue:252 alpha:1];
    _contentView.layer.cornerRadius = 13;
    _contentView.clipsToBounds = YES;
    [_shadowView addSubview:_contentView];
}

//创建所有按钮
- (void)creatAllButtons {
    
    for (int i=0; i<self.actions.count; i++) {
        
        XLsn0wHighLightButton *btn = [XLsn0wHighLightButton new];
        btn.tag = 10+i;
        btn.highlightedColor = [UIColor colorWithWhite:0.97 alpha:1];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:AppSubThemeColor forState:UIControlStateNormal];
        [btn setTitle:self.actions[i].title forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:btn];
        if ([btn.titleLabel.text isEqualToString:@"取消"] ||
            [btn.titleLabel.text isEqualToString:@"放弃"] ||
            [btn.titleLabel.text isEqualToString:@"不使用"] ||
            [btn.titleLabel.text isEqualToString:@"不保存"] ||
            [btn.titleLabel.text isEqualToString:@"不再提示"]) {
            [btn setTitleColor:App666666TitleColor forState:UIControlStateNormal];
        }
    }
}

//创建所有的分割线
- (void)creatAllSeparatorLine {
    
    if (!self.actions.count) {
        return;
    }
    
    //要创建的分割线条数
    NSInteger linesAmount = self.actions.count>2 ? self.actions.count : 1;
    linesAmount -= (self.title.length || self.message.length) ? 0 : 1;
    
    for (int i=0; i<linesAmount; i++) {
        
        UIView *separatorLine = [UIView new];
        separatorLine.tag = 1000+i;
        separatorLine.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
        [_contentView addSubview:separatorLine];
    }
}

- (void)updateTitleLabelFrame {
    
    CGFloat labelWidth = _contentViewWidth - _contentMargin.left - _contentMargin.right;
    CGFloat titleHeight = 0.0;
    if (self.title.length) {
        CGSize size = [self.titleLabel sizeThatFits:CGSizeMake(labelWidth, CGFLOAT_MAX)];
        titleHeight = size.height;
        self.titleLabel.frame = CGRectMake(_contentMargin.left, _contentMargin.top, labelWidth, size.height);
    }
}

- (void)updateMessageLabelFrame {
    
    CGFloat labelWidth = _contentViewWidth - _contentMargin.left - _contentMargin.right;
    //更新message的frame
    CGFloat messageHeight = 0.0;
    CGFloat messageY = self.title.length ? CGRectGetMaxY(_titleLabel.frame) + 20 : _contentMargin.top;
    if (self.message.length) {
        CGSize size = [self.messageLabel sizeThatFits:CGSizeMake(labelWidth, CGFLOAT_MAX)];
        messageHeight = size.height;
        self.messageLabel.frame = CGRectMake(_contentMargin.left, messageY, labelWidth, size.height);
    }
}

- (void)updateAllButtonsFrame {
    
    if (!self.actions.count) {
        return;
    }
    
    CGFloat firstButtonY = [self getFirstButtonY];
    
    CGFloat buttonWidth = self.actions.count>2 ? _contentViewWidth : _contentViewWidth/self.actions.count;
    
    for (int i=0; i<self.actions.count; i++) {
        UIButton *btn = [_contentView viewWithTag:10+i];
        CGFloat buttonX = self.actions.count>2 ? 0 : buttonWidth*i;
        CGFloat buttonY = self.actions.count>2 ? firstButtonY+_buttonHeight*i : firstButtonY;
        
        btn.frame = CGRectMake(buttonX, buttonY, buttonWidth, _buttonHeight);
    }
}

- (void)updateAllSeparatorLineFrame {
    //分割线的条数
    NSInteger linesAmount = self.actions.count>2 ? self.actions.count : 1;
    linesAmount -= (self.title.length || self.message.length) ? 0 : 1;
    NSInteger offsetAmount = (self.title.length || self.message.length) ? 0 : 1;
    for (int i=0; i<linesAmount; i++) {
        //获取到分割线
        UIView *separatorLine = [_contentView viewWithTag:1000+i];
        //获取到对应的按钮
        UIButton *btn = [_contentView viewWithTag:10+i+offsetAmount];
        
//        CGFloat x = linesAmount==1 ? _contentMargin.left : btn.frame.origin.x;
        CGFloat y = btn.frame.origin.y;
//        CGFloat width = linesAmount==1 ? _contentViewWidth - _contentMargin.left - _contentMargin.right : _contentViewWidth;
        separatorLine.frame = CGRectMake(0, y, _contentView.width, 0.5);
    }
    
//    XLsn0wLog(@"self.actions.count--%ld", self.actions.count);
    if (self.actions.count == 2) {
        UIButton *btn = [_contentView viewWithTag:10+0+offsetAmount];
        
        UIView* line = [[UIView alloc] init];
        [_contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self->_contentView);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(0.5);
            make.height.mas_equalTo(btn.height);
        }];
        line.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];;
    }
}

- (void)updateShadowAndContentViewFrame {
    
    CGFloat firstButtonY = [self getFirstButtonY];
    
    CGFloat allButtonHeight;
    if (!self.actions.count) {
        allButtonHeight = 0;
    }
    else if (self.actions.count<3) {
        allButtonHeight = _buttonHeight;
    }
    else {
        allButtonHeight = _buttonHeight*self.actions.count;
    }
    
    //更新警告框的frame
    CGRect frame = _shadowView.frame;
    frame.size.height = firstButtonY+allButtonHeight;
    _shadowView.frame = frame;
    
    _shadowView.center = self.view.center;
    _contentView.frame = _shadowView.bounds;
}

- (CGFloat)getFirstButtonY {
    
    CGFloat firstButtonY = 0.0;
    if (self.title.length) {
        firstButtonY = CGRectGetMaxY(self.titleLabel.frame);
    }
    if (self.message.length) {
        firstButtonY = CGRectGetMaxY(self.messageLabel.frame);
    }
    firstButtonY += firstButtonY>0 ? 15 : 0;
    return firstButtonY;
}

#pragma mark - 事件响应
- (void)didClickButton:(UIButton *)sender {
    XLsn0wAlertActioner *action = self.actions[sender.tag-10];
    if (action.actionHandler) {
        action.actionHandler(action);
    }
    
    [self showDisappearAnimation];
}

#pragma mark - 其他方法

- (void)addAction:(XLsn0wAlertActioner *)action {
    [self.mutableActions addObject:action];
}

- (UILabel *)creatLabelWithFontSize:(CGFloat)fontSize {
    
    UILabel *label = [UILabel new];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = kThemeColor;
    return label;
}

- (void)showAppearAnimation {
    if (_firstDisplay) {
        _firstDisplay = NO;
        _shadowView.alpha = 0;
        _shadowView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseIn animations:^{
            _shadowView.transform = CGAffineTransformIdentity;
            _shadowView.alpha = 1;
        } completion:nil];
    }
}

- (void)showDisappearAnimation {
    [UIView animateWithDuration:0.1 animations:^{
        _contentView.alpha = 0;
        _grayBackgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

#pragma mark - getter & setter

- (NSString *)title {
    return [super title];
}

- (NSArray<XLsn0wAlertActioner *> *)actions {
    return [NSArray arrayWithArray:self.mutableActions];
}

- (NSMutableArray *)mutableActions {
    if (!_mutableActions) {
        _mutableActions = [NSMutableArray array];
    }
    return _mutableActions;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [self creatLabelWithFontSize:20];
        _titleLabel.text = self.title;
        _titleLabel.textColor = HexColor(@"#333333");
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [self creatLabelWithFontSize:15];
        _messageLabel.text = self.message;
        _messageLabel.textColor = HexColor(@"#666666");
        _messageLabel.textAlignment = NSTextAlignmentLeft;
        [_contentView addSubview:_messageLabel];
    }
    return _messageLabel;
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    _titleLabel.text = title;
}

- (void)setMessage:(NSString *)message {
    _message = message;
    _messageLabel.text = message;
    _messageLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)setMessageAlignment:(NSTextAlignment)messageAlignment {
    _messageAlignment = messageAlignment;
    [_messageLabel lineSpacing:5
                     titleFont:[UIFont systemFontOfSize:15]
                    titleColor:HexColor(@"#666666")
                          text:self.message
                     alignment:messageAlignment];
}

@end
