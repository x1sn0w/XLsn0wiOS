
#import "XLsn0wShareShow.h"

@implementation XLsn0wShareShow

- (instancetype)initWithAlertViewHeight:(CGFloat)height
                              WithName:(NSString *)name
                               WithJob:(NSString *)job
                           WithUrlCard:(NSString *)Card {
    if (self = [super init]) {
        if (self.bGView==nil) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
            view.backgroundColor = [UIColor blackColor];
            view.alpha = 0.6;
            UITapGestureRecognizer *TapW = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapWih:)];
            [view addGestureRecognizer:TapW];
       
            [[UIApplication sharedApplication].keyWindow addSubview:view];
            self.bGView = view;
        }
        
        self.frame = CGRectMake((kScreenWidth-280)/2,(kScreenHeight-320)/2,280,310);
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
        //中间弹框的view
        UIView *popView = [[UIView alloc] initWithFrame:CGRectMake(0,0,280,310)];
        popView.backgroundColor = [UIColor whiteColor];
        [self addSubview:popView];
        
        UILabel *cardName = [[UILabel alloc] init];
        cardName.text = name;
        cardName.textColor = App666666TitleColor;
        cardName.font = [UIFont boldSystemFontOfSize:16];
        cardName.textAlignment = NSTextAlignmentCenter;
        [popView addSubview:cardName];
        [cardName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(popView);
            make.top.mas_equalTo(18);
        }];
        
        UILabel *profession = [UILabel new];
        profession.textColor = App666666TitleColor;
        if (isNotNull(job)) {
            profession.text = job;
        }
        profession.font = [UIFont systemFontOfSize:14];
        [popView addSubview:profession];
        profession.textAlignment = NSTextAlignmentCenter;
        [profession mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(popView);
            make.top.mas_equalTo(cardName.mas_bottom).offset(6);
        }];
        
        UIImageView *qrcodeImage = [[UIImageView alloc] init];
        [qrcodeImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", Card]] placeholderImage:[UIImage imageNamed:@"默认的头像"]];
        [popView addSubview:qrcodeImage];
        [qrcodeImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(popView);
            make.top.mas_equalTo(profession.mas_bottom).offset(14);
             make.width.mas_equalTo(150);
             make.height.mas_equalTo(150);
        }];
        
        UIImageView *logoImage = [[UIImageView alloc] init];
        [qrcodeImage addSubview:logoImage];
        [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(qrcodeImage);
            make.centerY.mas_equalTo(qrcodeImage);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(40);
        }];
        UserArchiverModel* user = [XLsn0wArchiver selectFromUserModel];
        [logoImage setImageFromURLString:user.avatarUrl];
        [logoImage xlsn0w_addCornerRadius:4];
        
        UIButton *calendarBtn = [UIButton new];
        calendarBtn.tag =100;
        [popView addSubview:calendarBtn];
        [calendarBtn setTitle:@"分享" forState:UIControlStateNormal];
        [calendarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [calendarBtn setBackgroundColor:HexColor(@"#4E8AFF")];
        calendarBtn.layer.shadowOffset =  CGSizeMake(1, 1);
        calendarBtn.layer.shadowOpacity = 0.8;
        calendarBtn.layer.shadowColor =  [UIColor blackColor].CGColor;
        calendarBtn.layer.cornerRadius= 20;
        [calendarBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [calendarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18);
            make.right.mas_equalTo(-18);
            make.bottom.mas_equalTo(-18);
            make.height.mas_equalTo(40);
        }];
        
        [self show:YES];

    }
    return self;
}
-(void)buttonClick:(UIButton*)button
{
    [self hide:YES];
    if (self.ButtonClick) {
        self.ButtonClick(button);
    }
}

-(void)TapWih:(UITapGestureRecognizer *)tap
{
    [self hide:YES];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hide:YES];
}

- (void)show:(BOOL)animated
{
    if (animated)
    {
        self.transform = CGAffineTransformScale(self.transform,0,0);
        __weak XLsn0wShareShow *weakSelf = self;
        [UIView animateWithDuration:.3 animations:^{
            weakSelf.transform = CGAffineTransformScale(weakSelf.transform,1.2,1.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.3 animations:^{
                weakSelf.transform = CGAffineTransformIdentity;
            }];
        }];
    }
}

- (void)hide:(BOOL)animated {
    [self endEditing:YES];
    if (self.bGView != nil) {
        __weak XLsn0wShareShow *weakSelf = self;
        
        [UIView animateWithDuration:animated ?0.3: 0 animations:^{
            weakSelf.transform = CGAffineTransformScale(weakSelf.transform,1,1);
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration: animated ?0.3: 0 animations:^{
                weakSelf.transform = CGAffineTransformScale(weakSelf.transform,0.2,0.2);
            } completion:^(BOOL finished) {
                [weakSelf.bGView removeFromSuperview];
                [weakSelf removeFromSuperview];
                weakSelf.bGView=nil;
            }];
        }];
    }
    
}

@end
