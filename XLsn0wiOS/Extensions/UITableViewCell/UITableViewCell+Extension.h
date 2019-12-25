
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (Extension)

@property (nonatomic) NSInteger section;
@property (nonatomic) NSInteger row;

@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIImageView *arrow;
- (void)addLine;
- (void)addArrow;
- (void)removeLine;
- (void)remakeLineScreenWidth;
- (void)noneCellSelection;
- (void)addTopSeparatorLine;
- (void)addBottomSeparatorLine;

@end

NS_ASSUME_NONNULL_END
