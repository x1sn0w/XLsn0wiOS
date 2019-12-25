
#import <UIKit/UIKit.h>

@interface XLsn0wShareShow : UIView

@property(nonatomic, strong) UIView *bGView;

@property(nonatomic, copy) void(^ButtonClick)(UIButton*);

- (instancetype)initWithAlertViewHeight:(CGFloat)height
                               WithName:(NSString *)name
                                WithJob:(NSString *)job
                            WithUrlCard:(NSString *)Card;

- (void)show:(BOOL)animated;

- (void)hide:(BOOL)animated;

@end
