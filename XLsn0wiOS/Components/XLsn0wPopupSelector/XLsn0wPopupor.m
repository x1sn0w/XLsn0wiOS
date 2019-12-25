
#import "XLsn0wPopupor.h"

static CGFloat const kCellHeight = 40;

@interface XLsn0wPopuporCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@end

@interface XLsn0wPopupor () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) CGPoint trianglePoint;

@end

@implementation XLsn0wPopupor

- (instancetype)initWithItems:(NSArray *)titles {
    if (titles.count == 0) return nil;
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.alpha = 0;
        self.titles = [titles copy];

        // 添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];

        // 创建tableView
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(kDeviceWidth/2, kDeviceHeight/2-40*(titles.count+1), 200, 40*(titles.count+1)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.layer.masksToBounds = YES;
        _tableView.layer.cornerRadius = 5;
        _tableView.scrollEnabled = NO;
        _tableView.rowHeight = kCellHeight;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.center = [UIApplication sharedApplication].keyWindow.center;
        [_tableView registerClass:[XLsn0wPopuporCell class] forCellReuseIdentifier:@"XLsn0wPopuporCell"];
        [self addSubview:_tableView];
    
    }
    return self;
}

+ (void)popupFromTitles:(NSMutableArray<NSString *> *)titles {
    XLsn0wPopupor *pop = [[XLsn0wPopupor alloc] initWithItems:titles];
    [pop show];
}

- (void)tap {
    [self hide];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:NSClassFromString(@"UITableViewCellContentView")]) {
        return NO;
    }
    if (touch.view.tag == 1000) {
        return NO;
    }
    return YES;
}

#pragma mark - show or hide
- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
//    // 设置右上角为transform的起点（默认是中心点）
//    _tableView.layer.position = [UIApplication sharedApplication].keyWindow.center;
    // 向右下transform
    _tableView.layer.anchorPoint = CGPointMake(1, 0);
    _tableView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
        self->_tableView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        self->_tableView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    } completion:^(BOOL finished) {
        [self->_tableView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XLsn0wPopuporCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XLsn0wPopuporCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.titles[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = [UIView new];
    footer.frame = CGRectMake(0, 0, kScreenWidth, 0);
    UILabel *sectionName = [UILabel new];
    [footer addSubview:sectionName];

    [sectionName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(footer);
        make.centerX.mas_equalTo(footer);
    }];
    footer.backgroundColor = UIColor.whiteColor;
    footer.tag = 2000;
    [sectionName addTextFont:[UIFont systemFontOfSize:12] textColor:App999999TitleColor text:@"取消"];
    
    return footer;
}

@end

///Cell
@implementation XLsn0wPopuporCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self noneCellSelection];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = App333333TitleColor;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.centerX.mas_equalTo(self.contentView);
        }];
        
        UIView* line = [[UIView alloc] init];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(kScreenWidth);
            make.height.mas_equalTo(0.5);
        }];
        line.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];;
        
    }
    return self;
}

@end
