
#import <MBProgressHUD/MBProgressHUD.h>

/**
 MBProgressHUD 的二次封装
 */
@interface MBProgressHUD (Extension)


+ (void)showTipMessageInWindow:(NSString*)message;
+ (void)showTipMessageInView:(NSString*)message;
+ (void)showTipMessageInWindow:(NSString*)message timer:(float)aTimer;
+ (void)showTipMessageInView:(NSString*)message timer:(float)aTimer;


+ (void)showActivityMessageInWindow:(NSString*)message;
+ (void)showActivityMessageInView:(NSString*)message;
+ (void)showActivityMessageInWindow:(NSString*)message timer:(float)aTimer;
+ (void)showActivityMessageInView:(NSString*)message timer:(float)aTimer;


+ (void)showSuccessMessage:(NSString *)Message;
+ (void)showErrorMessage:(NSString *)Message;
+ (void)showInfoMessage:(NSString *)Message;
+ (void)showWarnMessage:(NSString *)Message;


+ (void)showCustomIconInWindow:(NSString *)iconName message:(NSString *)message;
+ (void)showCustomIconInView:(NSString *)iconName message:(NSString *)message;


+ (void)hideHUD;



/**
 *  自定义图片的提示，1s后自动消息
 *
 *  @param iconName 图片名称
 *  @param title 要显示的文字
 *  @param view 要添加的view
 */
+ (void)showCustomIcon:(NSString *)iconName Title:(NSString *)title ToView:(UIView *)view;

/**
 *  自动消失成功提示，带默认图
 *
 *  @param success 要显示的文字
 *  @param view    要添加的view
 */
+ (void)showSuccess:(NSString *)success ToView:(UIView *)view;


/**
 *  自动消失错误提示,带默认图
 *
 *  @param error 要显示的错误文字
 *  @param view  要添加的View
 */
+ (void)showError:(NSString *)error ToView:(UIView *)view;


/**
 *  文字+菊花提示,不自动消失
 *
 *  @param message 要显示的文字
 *  @param view    要添加的View
 *
 *  @return MBProgressHUD
 */
+ (MBProgressHUD *)showMessage:(NSString *)message ToView:(UIView *)view;


/**
 *  快速显示一条提示信息
 */
+ (void)showAutoMessage:(NSString *)message;


/**
 *  自动消失提示，无图
 *
 *  @param message 要显示的文字
 *  @param view    要添加的View
 */
+ (void)showAutoMessage:(NSString *)message ToView:(UIView *)view;


/**
 *  自定义停留时间，有图
 *
 *  @param message 要显示的文字
 *  @param view    要添加的View
 *  @param time    停留时间
 */
+(void)showIconMessage:(NSString *)message ToView:(UIView *)view RemainTime:(CGFloat)time;


/**
 *  自定义停留时间，无图
 *
 *  @param message 要显示的文字
 *  @param view 要添加的View
 *  @param time 停留时间
 */
+(void)showMessage:(NSString *)message ToView:(UIView *)view RemainTime:(CGFloat)time;


/**
 *  加载视图
 *
 *  @param view 要添加的View
 */
+ (void)showLoadToView:(UIView *)view;


/**
 *  进度条View
 *
 *  @param view     要添加的View
 *  @param model    进度条的样式
 *  @param text     显示的文字
 *
 *  @return 返回使用
 */
+ (MBProgressHUD *)showProgressToView:(UIView *)view ProgressModel:(MBProgressHUDMode)model Text:(NSString *)text;


/**
 *  隐藏ProgressView
 *
 *  @param view superView
 */
+ (void)hideHUDForView:(UIView *)view;


+ (UIViewController *)getCurrentVC;
+ (UIViewController *)getCurrentUIVC;

@end
