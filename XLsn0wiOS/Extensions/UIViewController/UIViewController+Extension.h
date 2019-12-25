///系统版本号
#define kAppSystemVersion ([[UIDevice currentDevice].systemVersion floatValue])
#define kSystemVersion_iOS8_Later (kSystemVersion >= 8.0)

#import <UIKit/UIKit.h>
#define NO_USE -1000

typedef void(^click)(NSInteger index);
typedef void(^configuration)(UITextField *field, NSInteger index);
typedef void(^clickHaveField)(NSArray<UITextField *> *fields, NSInteger index);

@interface UIViewController (Extension)

#ifdef kSystemVersion_iOS8_Later

#else

<UIAlertViewDelegate, UIActionSheetDelegate>

#endif

/// 模式
typedef NS_ENUM(NSUInteger, Mode) {
    ModeRelease = 0, /// 正式版
    ModeTest    = 1, /// 开发版
    ModePreview = 2, /// 体验版
};

@property (nonatomic) NSInteger mode;
//@property (nonatomic) NSInteger tag;

@property (nonatomic, copy) NSString* typeCode;
- (NSString *)getProductTypeFromTypeCode:(NSString *)typeCode;

- (void)pushAlertWithTitle:(NSString *)title
                   message:(NSString *)message
                   buttons:(NSArray<NSString *> *)buttons
                  animated:(BOOL)animated
                    action:(click)click;

- (void)pushAlertWithTitle:(NSString *)title
                   message:(NSString *)message
                   buttons:(NSArray<NSString *> *)buttons
           textFieldCount:(NSInteger )count
             configuration:(configuration )configuration
                  animated:(BOOL )animated
                    action:(clickHaveField )click;

- (void)pushSheetWithTitle:(NSString *)title
                   message:(NSString *)message
                  subtitle:(NSString *)subtitle
            subtitleAction:(click)subtitleAction
                   buttons:(NSArray<NSString *> *)buttons
                  animated:(BOOL)animated
                    action:(click)click;

@end
