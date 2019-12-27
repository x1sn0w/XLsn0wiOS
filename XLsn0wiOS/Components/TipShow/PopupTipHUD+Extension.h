
#import "TipHUD.h"

@interface TipHUD (Extension)

+ (void)showSuccess:(NSString *)success;

+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showError:(NSString *)error;

+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (void)showMessage:(NSString *)message toView:(UIView *)view;

+ (void)hideView;

+ (void)hideHUDForView:(UIView *)view;

@end
