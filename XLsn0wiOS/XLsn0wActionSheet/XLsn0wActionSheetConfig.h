
#import <UIKit/UIKit.h>

#define kLCActionSheetColor(r, g, b)        kLCActionSheetColorA(r, g, b, 1.0f)
#define kLCActionSheetColorA(r, g, b, a)    [UIColor colorWithRed:(r)/255.0f\
                                                            green:(g)/255.0f\
                                                             blue:(b)/255.0f\
                                                            alpha:a]


NS_ASSUME_NONNULL_BEGIN

@interface XLsn0wActionSheetConfig : NSObject

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
 Title's edge insets. Default is `UIEdgeInsetsMake(8.0, 15.0, 8.0f, 15.0f)`.
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
 LCActionSheetConfig shared instance.
 */
@property (class, nonatomic, strong, readonly) XLsn0wActionSheetConfig *config;

/**
 LCActionSheetConfig shared instance.
 */
+ (instancetype)shared NS_DEPRECATED_IOS(2_0, 10_0, "Method deprecated. Use class property `config` instead.");

@end

NS_ASSUME_NONNULL_END
