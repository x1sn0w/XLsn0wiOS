
#import <UIKit/UIKit.h>
#import "XLsn0wActionSheetConfig.h"

@class XLsn0wActionSheet;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - LCActionSheet Block

/**
 Handle click button.
 */
typedef void(^LCActionSheetClickedHandler)(XLsn0wActionSheet *actionSheet, NSInteger buttonIndex);

/**
 Handle action sheet will present.
 */
typedef void(^LCActionSheetWillPresentHandler)(XLsn0wActionSheet *actionSheet);
/**
 Handle action sheet did present.
 */
typedef void(^LCActionSheetDidPresentHandler)(XLsn0wActionSheet *actionSheet);

/**
 Handle action sheet will dismiss.
 */
typedef void(^LCActionSheetWillDismissHandler)(XLsn0wActionSheet *actionSheet, NSInteger buttonIndex);
/**
 Handle action sheet did dismiss.
 */
typedef void(^LCActionSheetDidDismissHandler)(XLsn0wActionSheet *actionSheet, NSInteger buttonIndex);

#pragma mark - LCActionSheet Delegate

@protocol XLsn0wActionSheetDelegate <NSObject>

@optional

/**
 Handle click button.
 */
- (void)actionSheet:(XLsn0wActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

/**
 Handle action sheet will present.
 */
- (void)willPresentActionSheet:(XLsn0wActionSheet *)actionSheet;
/**
 Handle action sheet did present.
 */
- (void)didPresentActionSheet:(XLsn0wActionSheet *)actionSheet;

/**
 Handle action sheet will dismiss.
 */
- (void)actionSheet:(XLsn0wActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex;
/**
 Handle action sheet did dismiss.
 */
- (void)actionSheet:(XLsn0wActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;

@end


#pragma mark - LCActionSheet

@interface XLsn0wActionSheet : UIView


#pragma mark - Properties

/**
 Title.
 */
@property (nullable, nonatomic, copy) NSString *title;

/**
 Cancel button's title.
 */
@property (nullable, nonatomic, copy) NSString *cancelButtonTitle;

/**
 Cancel button's index.
 */
@property (nonatomic, assign, readonly) NSInteger cancelButtonIndex;

/**
 LCActionSheet's delegate.
 */
@property (nullable, nonatomic, weak) id<XLsn0wActionSheetDelegate> delegate;

/**
 Deprecated, use `destructiveButtonIndexSet` instead.
 */
@property (nullable, nonatomic, strong) NSIndexSet *redButtonIndexSet __deprecated_msg("Property deprecated. Use `destructiveButtonIndexSet` instead.");

/**
 All destructive buttons' set. You should give it the `NSNumber` type items.
 */
@property (nullable, nonatomic, strong) NSIndexSet *destructiveButtonIndexSet;

/**
 Destructive button's color. Default is RGB(254, 67, 37).
 */
@property (nonatomic, strong) UIColor *destructiveButtonColor;
/**
 Destructive button's background color. Default is `[UIColor clearColor]`.
 */
@property (nonatomic, strong) UIColor *destructiveButtonBgColor;

/**
 Title's color. Default is `[UIColor blackColor]`.
 */
@property (nonatomic, strong) UIColor *titleColor;

/**
 Cancel button's color. Default is `buttonColor`.
 */
@property (nonatomic, strong) UIColor *cancelButtonColor;
/**
 Cancel button's backgroundColor, without destructive buttons. Default is `[UIColor clarColor]`.
 */
@property (nonatomic, strong) UIColor *cancelButtonBgColor;

/**
 Buttons' color, without destructive buttons. Default is `[UIColor blackColor]`.
 */
@property (nonatomic, strong) UIColor *buttonColor;
/**
 Buttons' backgroundColor, without destructive buttons. Default is `[UIColor clarColor]`.
 */
@property (nonatomic, strong) UIColor *buttonBgColor;

/**
 Title's font. Default is `[UIFont systemFontOfSize:14.0f]`.
 */
@property (nonatomic, strong) UIFont *titleFont;
/**
 All buttons' font. Default is `[UIFont systemFontOfSize:18.0f]`.
 */
@property (nonatomic, strong) UIFont *buttonFont;
/**
 All buttons' height. Default is 49.0f;
 */
@property (nonatomic, assign) CGFloat buttonHeight;

/**
 All buttons' corner. Default is 0.0f;
 */
@property (nonatomic, assign) CGFloat buttonCornerRadius;

/**
 If buttons' bottom view can scrolling. Default is NO.
 */
@property (nonatomic, assign, getter=canScrolling) BOOL scrolling;

/**
 Visible buttons' count. You have to set `scrolling = YES` if you want to set it.
 */
@property (nonatomic, assign) CGFloat visibleButtonCount;

/**
 Animation duration. Default is 0.3 seconds.
 */
@property (nonatomic, assign) CGFloat animationDuration;

/**
 Opacity of dark background. Default is 0.3f.
 */
@property (nonatomic, assign) CGFloat darkOpacity;

/**
 If you can tap darkView to dismiss. Defalut is NO, you can tap dardView to dismiss.
 */
@property (nonatomic, assign) BOOL darkViewNoTaped;

/**
 Clear blur effect. Default is NO, don't clear blur effect.
 */
@property (nonatomic, assign) BOOL unBlur;

/**
 Style of blur effect. Default is `UIBlurEffectStyleExtraLight`. iOS 8.0 +
 */
@property (nonatomic, assign) UIBlurEffectStyle blurEffectStyle;

/**
 Title's edge insets. Default is `UIEdgeInsetsMake(15.0f, 15.0f, 15.0f, 15.0f)`.
 */
@property (nonatomic, assign) UIEdgeInsets titleEdgeInsets;
/**
 Button's edge insets. Default is `UIEdgeInsetsMake(8.0, 15.0, 8.0f, 15.0f)`.
 */
@property (nonatomic, assign) UIEdgeInsets buttonEdgeInsets;
///**
// ActionSheet's edge insets. Default is `UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)`.
// */
//@property (nonatomic, assign) UIEdgeInsets actionSheetEdgeInsets;

/**
 Cell's separator color. Default is `RGBA(170/255.0f, 170/255.0f, 170/255.0f, 0.5f)`.
 */
@property (nonatomic, strong) UIColor *separatorColor;

/**
 Blur view's background color. Default is `RGBA(255.0/255.0f, 255.0/255.0f, 255.0/255.0f, 0.5f)`.
 */
@property (nonatomic, strong) UIColor *blurBackgroundColor;

/**
 Title can be limit in numberOfTitleLines. Default is 0.
 */
@property (nonatomic, assign) NSInteger numberOfTitleLines;

/**
 Auto hide when the device rotated. Default is NO, won't auto hide.
 */
@property (nonatomic, assign) BOOL autoHideWhenDeviceRotated;

/**
 Disable auto dismiss after clicking. Default is NO, will auto dismiss.
 */
@property (nonatomic, assign) BOOL disableAutoDismissAfterClicking;


/**
 LCActionSheet clicked handler.
 */
@property (nullable, nonatomic, copy) LCActionSheetClickedHandler     clickedHandler;
/**
 LCActionSheet will present handler.
 */
@property (nullable, nonatomic, copy) LCActionSheetWillPresentHandler willPresentHandler;
/**
 LCActionSheet did present handler.
 */
@property (nullable, nonatomic, copy) LCActionSheetDidPresentHandler  didPresentHandler;
/**
 LCActionSheet will dismiss handler.
 */
@property (nullable, nonatomic, copy) LCActionSheetWillDismissHandler willDismissHandler;
/**
 LCActionSheet did dismiss handler.
 */
@property (nullable, nonatomic, copy) LCActionSheetDidDismissHandler  didDismissHandler;


#pragma mark - Methods

#pragma mark Delegate

/**
 Initialize an instance of LCActionSheet (Delegate).
 
 @param title             title
 @param delegate          delegate
 @param cancelButtonTitle cancelButtonTitle
 @param otherButtonTitles otherButtonTitles
 
 @return An instance of LCActionSheet.
 */
+ (instancetype)sheetWithTitle:(nullable NSString *)title
                      delegate:(nullable id<XLsn0wActionSheetDelegate>)delegate
             cancelButtonTitle:(nullable NSString *)cancelButtonTitle
             otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 Initialize an instance of LCActionSheet with title array (Delegate).
 
 @param title                 title
 @param delegate              delegate
 @param cancelButtonTitle     cancelButtonTitle
 @param otherButtonTitleArray otherButtonTitleArray
 
 @return An instance of LCActionSheet.
 */
+ (instancetype)sheetWithTitle:(nullable NSString *)title
                      delegate:(nullable id<XLsn0wActionSheetDelegate>)delegate
             cancelButtonTitle:(nullable NSString *)cancelButtonTitle
         otherButtonTitleArray:(nullable NSArray<NSString *> *)otherButtonTitleArray;

/**
 Initialize an instance of LCActionSheet (Delegate).
 
 @param title             title
 @param delegate          delegate
 @param cancelButtonTitle cancelButtonTitle
 @param otherButtonTitles otherButtonTitles
 
 @return An instance of LCActionSheet.
 */
- (instancetype)initWithTitle:(nullable NSString *)title
                     delegate:(nullable id<XLsn0wActionSheetDelegate>)delegate
            cancelButtonTitle:(nullable NSString *)cancelButtonTitle
            otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 Initialize an instance of LCActionSheet with title array (Delegate).
 
 @param title                 title
 @param delegate              delegate
 @param cancelButtonTitle     cancelButtonTitle
 @param otherButtonTitleArray otherButtonTitleArray
 
 @return An instance of LCActionSheet.
 */
- (instancetype)initWithTitle:(nullable NSString *)title
                     delegate:(nullable id<XLsn0wActionSheetDelegate>)delegate
            cancelButtonTitle:(nullable NSString *)cancelButtonTitle
        otherButtonTitleArray:(nullable NSArray<NSString *> *)otherButtonTitleArray;


#pragma mark Block

/**
 Initialize an instance of LCActionSheet (Block).
 
 @param title             title
 @param cancelButtonTitle cancelButtonTitle
 @param clickedHandler    clickedHandler
 @param otherButtonTitles otherButtonTitles
 
 @return An instance of LCActionSheet.
 */
+ (instancetype)sheetWithTitle:(nullable NSString *)title
             cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                       clicked:(nullable LCActionSheetClickedHandler)clickedHandler
             otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 Initialize an instance of LCActionSheet with title array (Block).
 
 @param title                 title
 @param cancelButtonTitle     cancelButtonTitle
 @param clickedHandler        clickedHandler
 @param otherButtonTitleArray otherButtonTitleArray
 
 @return An instance of LCActionSheet.
 */
+ (instancetype)sheetWithTitle:(nullable NSString *)title
             cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                       clicked:(nullable LCActionSheetClickedHandler)clickedHandler
         otherButtonTitleArray:(nullable NSArray<NSString *> *)otherButtonTitleArray;

/**
 Initialize an instance of LCActionSheet (Block).
 
 @param title             title
 @param cancelButtonTitle cancelButtonTitle
 @param clickedHandler    clickedHandler
 @param otherButtonTitles otherButtonTitles
 
 @return An instance of LCActionSheet.
 */
- (instancetype)initWithTitle:(nullable NSString *)title
            cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                      clicked:(nullable LCActionSheetClickedHandler)clickedHandler
            otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 Initialize an instance of LCActionSheet with title array (Block).
 
 @param title                 title
 @param cancelButtonTitle     cancelButtonTitle
 @param clickedHandler        clickedHandler
 @param otherButtonTitleArray otherButtonTitleArray
 
 @return An instance of LCActionSheet.
 */
- (instancetype)initWithTitle:(nullable NSString *)title
            cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                      clicked:(nullable LCActionSheetClickedHandler)clickedHandler
        otherButtonTitleArray:(nullable NSArray<NSString *> *)otherButtonTitleArray;



/**
 Initialize an instance of LCActionSheet (Block).
 
 @param title             title
 @param cancelButtonTitle cancelButtonTitle
 @param didDismissHandler didDismissHandler
 @param otherButtonTitles otherButtonTitles
 
 @return An instance of LCActionSheet.
 */
+ (instancetype)sheetWithTitle:(nullable NSString *)title
             cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                    didDismiss:(nullable LCActionSheetDidDismissHandler)didDismissHandler
             otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 Initialize an instance of LCActionSheet with title array (Block).
 
 @param title                 title
 @param cancelButtonTitle     cancelButtonTitle
 @param didDismissHandler     didDismissHandler
 @param otherButtonTitleArray otherButtonTitleArray
 
 @return An instance of LCActionSheet.
 */
+ (instancetype)sheetWithTitle:(nullable NSString *)title
             cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                    didDismiss:(nullable LCActionSheetDidDismissHandler)didDismissHandler
         otherButtonTitleArray:(nullable NSArray<NSString *> *)otherButtonTitleArray;

/**
 Initialize an instance of LCActionSheet (Block).
 
 @param title             title
 @param cancelButtonTitle cancelButtonTitle
 @param didDismissHandler didDismissHandler
 @param otherButtonTitles otherButtonTitles
 
 @return An instance of LCActionSheet.
 */
- (instancetype)initWithTitle:(nullable NSString *)title
            cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                   didDismiss:(nullable LCActionSheetDidDismissHandler)didDismissHandler
            otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 Initialize an instance of LCActionSheet with title array (Block).
 
 @param title                 title
 @param cancelButtonTitle     cancelButtonTitle
 @param didDismissHandler     didDismissHandler
 @param otherButtonTitleArray otherButtonTitleArray
 
 @return An instance of LCActionSheet.
 */
- (instancetype)initWithTitle:(nullable NSString *)title
            cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                   didDismiss:(nullable LCActionSheetDidDismissHandler)didDismissHandler
        otherButtonTitleArray:(nullable NSArray<NSString *> *)otherButtonTitleArray;


#pragma mark Append & Show

/**
 Append buttons with titles.
 
 @param titles titles
 */
- (void)appendButtonsWithTitles:(nullable NSString *)titles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 Append button at index with title.
 
 @param title title
 @param index index
 */
- (void)appendButtonWithTitle:(nullable NSString *)title atIndex:(NSInteger)index;

/**
 Append buttons at indexSet with titles.
 
 @param titles  titles
 @param indexes indexes
 */
- (void)appendButtonsWithTitles:(NSArray<NSString *> *)titles atIndexes:(NSIndexSet *)indexes;

/**
 Show the instance of LCActionSheet.
 */
- (void)show;

/**
 Get button title with index.
 
 @param index index
 @return button title
 */
- (nullable NSString *)buttonTitleAtIndex:(NSInteger)index;

/**
 Set button title with index.

 @param title title
 @param index index
 */
- (void)setButtonTitle:(nullable NSString *)title atIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END


#define LC_ACTION_SHEET_CELL_NO_HIDDE_LINE_TAG  100
#define LC_ACTION_SHEET_CELL_HIDDE_LINE_TAG     101

NS_ASSUME_NONNULL_BEGIN

@interface XLsn0wActionSheetCell : UITableViewCell

/**
 Title label.
 */
@property (nonatomic, weak) UILabel *titleLabel;

/**
 Line.
 */
@property (nonatomic, weak) UIView *lineView;

/**
 Button's edge insets. Default is `UIEdgeInsetsMake(8.0, 15.0, 8.0f, 15.0f)`.
 */
@property (nonatomic, assign) UIEdgeInsets buttonEdgeInsets;

/**
 Cell's separator color.
 */
@property (nonatomic, strong) UIColor *cellSeparatorColor;

@end

NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN

@interface XLsn0wActionSheetController : UIViewController

/**
 Status bar hidden. Same as the original.
 */
@property (nonatomic, assign) BOOL statusBarHidden;

/**
 Status bar style. Same as the original.
 */
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

@end

NS_ASSUME_NONNULL_END
