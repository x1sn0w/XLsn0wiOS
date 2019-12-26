
#import <UIKit/UIKit.h>

@interface UITextView (Extension)

@property (nonatomic, assign) BOOL isShowToolBar;
@property (nonatomic,strong) NSString *placeholder;//占位符
@property (copy, nonatomic) NSNumber *limitLength;//字数限制

@end
