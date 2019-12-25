#import "ImportHeader.h"
#import "XLsn0wActionSheetCell.h"
#import "Masonry.h"
#import "LCActionSheetConfig.h"

@interface XLsn0wActionSheetCell ()

/**
 *  Highlighted View.
 */
@property (nonatomic, weak) UIView *highlightedView;

@end

@implementation XLsn0wActionSheetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        
//        UIView *selBgView = [[UIView alloc] init];
//        selBgView.backgroundColor = LC_ACTION_SHEET_BG_COLOR_HIGHLIGHTED;
//        self.selectedBackgroundView = selBgView;
        
        
        UIView *highlightedView = [[UIView alloc] init];
        highlightedView.backgroundColor = self.cellSeparatorColor;
        highlightedView.clipsToBounds   = YES;
        highlightedView.hidden          = YES;
        [self.contentView addSubview:highlightedView];
        self.highlightedView = highlightedView;
        [highlightedView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(self.buttonEdgeInsets);
        }];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = self.cellSeparatorColor;
        lineView.contentMode   = UIViewContentModeBottom;
        lineView.clipsToBounds = YES;
        [self.contentView addSubview:lineView];
        self.lineView = lineView;
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.height.offset(1 / 3.0);
        }];
    }
    return self;
}

- (void)setButtonEdgeInsets:(UIEdgeInsets)buttonEdgeInsets {
    _buttonEdgeInsets = buttonEdgeInsets;

    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(self.buttonEdgeInsets);
    }];
}


- (void)setCellSeparatorColor:(UIColor *)cellSeparatorColor {
    _cellSeparatorColor = cellSeparatorColor;
    
    self.highlightedView.backgroundColor = cellSeparatorColor;
    self.lineView.backgroundColor = cellSeparatorColor;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    if (self.tag == LC_ACTION_SHEET_CELL_HIDDE_LINE_TAG) {
        self.lineView.hidden = YES;
    } else {
        self.lineView.hidden = highlighted;
    }
    
    self.highlightedView.hidden = !highlighted;
}

@end
