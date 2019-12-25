
#import <UIKit/UIKit.h>

@interface UITextField (Extension)

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) BOOL isShowToolBar;
@property (nonatomic, assign) BOOL canResign;
//设置密码输入框
- (void)eye_rightView;
- (void)eyeWhite_rightView;

@end
