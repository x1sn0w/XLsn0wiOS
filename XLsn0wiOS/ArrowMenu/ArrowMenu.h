
#import <UIKit/UIKit.h>

typedef void(^ArrowMenuSelectItemAtIndexAction)(NSInteger index);

@interface ArrowMenu : UIView

@property (nonatomic, copy) ArrowMenuSelectItemAtIndexAction selectItemAtIndexAction;

- (instancetype)initWithFrame:(CGRect)frame
                   TitleArray:(NSArray<NSString *> *)titleArray
                   imageArray:(NSArray<NSString *> *)imageArray
                    showPoint:(CGPoint)showPoint;
- (void)show;
- (void)hide;

@end


@interface ArrowMenuCell : UITableViewCell

@property (nonatomic, strong) UIImageView* icon;
@property (nonatomic, strong) UILabel* title;

@end














