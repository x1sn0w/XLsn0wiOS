
#import <UIKit/UIKit.h>

@class XLsn0wAlertActioner;

@interface XLsn0wAlertController : UIViewController

@property (nonatomic, readonly) NSArray<XLsn0wAlertActioner *> *actions;

@property (nonatomic, copy) UIView *contentView;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSTextAlignment messageAlignment;///内容文本对齐: Left | Center | Right
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIFont *messageLabelFont;
@property (nonatomic, strong) UIColor *messageLabelColor;

+ (instancetype)alertControllerWithTitle:(NSString *)title
                                 message:(NSString *)message;
- (void)addAction:(XLsn0wAlertActioner *)action;

@end
