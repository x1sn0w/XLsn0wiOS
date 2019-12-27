
#import "XLsn0wPopupSelector.h"
#import "XLsn0wPopupModel.h"
#import "XLsn0wiOSHeader.h"

#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#endif

static CGFloat const kCellHeight = 40;

@interface PopMenuTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@end

@interface XLsn0wPopupSelector ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *tableData;
@property (nonatomic, assign) CGPoint trianglePoint;

@end

@implementation XLsn0wPopupSelector

- (instancetype)initWithItems:(NSArray *)array
                       action:(XLsn0wPopMenuBlock)action {
    if (array.count == 0) return nil;
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.alpha = 0;
        _tableData = [array copy];
     
        self.action = action;
        
        
        // 添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        
        
        // 创建tableView
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(kDeviceWidth/2, kDeviceHeight/2-40*4, 280, 40*4) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.layer.masksToBounds = YES;
        _tableView.layer.cornerRadius = 5;
        _tableView.scrollEnabled = NO;
        _tableView.rowHeight = kCellHeight;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.center = [UIApplication sharedApplication].keyWindow.center;
        [_tableView registerClass:[PopMenuTableViewCell class] forCellReuseIdentifier:@"PopMenuTableViewCell"];
        [self addSubview:_tableView];
    
    }
    return self;
}

+ (void)popFromModels:(NSArray<XLsn0wPopupModel *> *)models action:(XLsn0wPopMenuBlock)action {
    XLsn0wPopupSelector *pop = [[XLsn0wPopupSelector alloc] initWithItems:models action:action];
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
        if (self.hideHandle) {
            self.hideHandle();
        }
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PopMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PopMenuTableViewCell" forIndexPath:indexPath];
    XLsn0wPopupModel *model = _tableData[indexPath.row];
    cell.titleLabel.text = model.title;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [UIView new];
    header.frame = CGRectMake(0, 0, kScreenWidth, 0);
    UILabel *sectionName = [UILabel new];
    [header addSubview:sectionName];

    [sectionName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(header);
        make.centerX.mas_equalTo(header);
    }];
    header.backgroundColor = UIColor.whiteColor;
    header.tag = 1000;
    [sectionName addTextFont:[UIFont systemFontOfSize:12] textColor:App999999TitleColor text:@"选择角色"];
    
    UIView* line = [[UIView alloc] init];
    [header addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(0.5);
    }];
    line.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    return header;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hide];
    if (self.action) {
        XLsn0wPopupModel *model = _tableData[indexPath.row];
        self.action(indexPath.row, model);
    }
}

@end

///Cell
@implementation PopMenuTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
