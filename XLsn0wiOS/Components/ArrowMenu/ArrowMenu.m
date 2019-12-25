
#import "ArrowMenu.h"
#import "ImportHeader.h"
#define kCellHeight     45
#define kTriangleWith   15  //三角形的高度

@interface ArrowMenu () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (assign, nonatomic) CGPoint showPoint;
@property (assign, nonatomic) CGRect originalRect;

@property (nonatomic, strong) NSArray<NSString *> *titleArray;
@property (nonatomic, strong) NSArray<NSString *> *ImageArray;

@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation ArrowMenu

- (instancetype)initWithFrame:(CGRect)frame
                   TitleArray:(NSArray<NSString *> *)titleArray
                        imageArray:(NSArray<NSString *> *)imageArray
                         showPoint:(CGPoint)showPoint {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        if (titleArray) {
            self.titleArray = titleArray;
        }
        if (imageArray) {
            self.ImageArray = [NSArray arrayWithArray:imageArray];
        }
        
        CGRect newFrame = frame;
        newFrame.size.height = titleArray.count * kCellHeight + kTriangleWith - 5;
        self.frame = newFrame;
        self.alpha = 0;
        self.originalRect = newFrame;
        self.showPoint = showPoint;
        self.layer.anchorPoint = CGPointMake(0.9, 0);
        self.layer.position = CGPointMake(self.layer.position.x+self.frame.size.width*0.4, self.layer.position.y-self.frame.size.height*0.5);
        
        [self.tableView reloadData];
    }
    return self;
}

//展开
- (void)show {
    [self.backgroundView addSubview:self];
    [kKeyWindow addSubview:self.backgroundView];
    self.alpha = 0;
    self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(1, 1);
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
}

//隐藏
- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        self.alpha = 0;
    } completion:^(BOOL finished) {
//        [self.menuTableView removeFromSuperview];
        [self.backgroundView removeFromSuperview];
//        self.menuTableView = nil;
//        self.bgView = nil;
    }];
}

#pragma mark 绘制三角形
- (void)drawRect:(CGRect)rect {
    // 设置背景色
    [[UIColor whiteColor] set];
    //拿到当前视图准备好的画板
    CGContextRef  context = UIGraphicsGetCurrentContext();
    
    //利用path进行绘制三角形
    CGContextBeginPath(context);//标记
    CGPoint locationPoint = CGPointMake(self.showPoint.x - self.originalRect.origin.x, 10);
    CGPoint leftPoint     = CGPointMake(self.showPoint.x - self.originalRect.origin.x-kTriangleWith/2, (kTriangleWith-5)/2+10);
    CGPoint rightPoint    = CGPointMake(self.showPoint.x - self.originalRect.origin.x, kTriangleWith-5+10);
    
    CGContextMoveToPoint(context,locationPoint.x,locationPoint.y);//设置起点
    
    CGContextAddLineToPoint(context,leftPoint.x ,  leftPoint.y);
    
    CGContextAddLineToPoint(context,rightPoint.x, rightPoint.y);
    
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    
    UIColor *arrowColor = AppWhiteColor;
    [arrowColor setFill];  //设置填充色
    
    [arrowColor setStroke]; //设置边框颜色
    
    CGContextDrawPath(context,kCGPathFillStroke);//绘制路径path
}

#pragma mark - UITableViewDelegate, UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArrowMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArrowMenuCell"];
    
    if (!cell) {
        cell = [[ArrowMenuCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"ArrowMenuCell"];
    }
    
    if (self.titleArray.count > 0 ) {
        cell.title.text = self.titleArray[indexPath.row];
    }
    if (self.ImageArray.count > 0 && self.titleArray.count == self.ImageArray.count) {
        cell.icon.image = [UIImage imageNamed:self.ImageArray[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self hide];
    if (self.selectItemAtIndexAction) {
        self.selectItemAtIndexAction(indexPath.row);
    }
}

#pragma mark - UIGestureRecognizerDelegate -
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}

#pragma mark - Getter -
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(kTriangleWith-5, 0, self.width, self.height-(kTriangleWith-3))
                                                      style:(UITableViewStylePlain)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
        _tableView.layer.cornerRadius = 5;
        _tableView.layer.masksToBounds = YES;
        [self addSubview:_tableView];
        _tableView.backgroundColor = AppWhiteColor;
        [_tableView removeTableViewCellSeparator];
    }
    return _tableView;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        tap.delegate = self;
        [_backgroundView addGestureRecognizer:tap];
        _backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }
    return _backgroundView;
}

@end



@implementation ArrowMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = AppWhiteColor;
        [self drawSubviews];
    }
    return self;
}

- (void)drawSubviews {
    _icon = [[UIImageView alloc] init];
    [self addSubview:_icon];
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    _title = [[UILabel alloc] init];
    [self addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_icon.mas_right).offset(10);
        make.centerY.mas_equalTo(self);
    }];
    [_title addTextFont:[UIFont systemFontOfSize:14] textColor:HexColor(@"#666666")];
    
    UIView* line = [[UIView alloc] init];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.width);
        make.height.mas_equalTo(1);
    }];
    line.backgroundColor = AppLineColor;
}

@end
