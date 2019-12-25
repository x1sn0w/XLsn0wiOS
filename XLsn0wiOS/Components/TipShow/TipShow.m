
#import "TipShow.h"

#define showDelay 0.5

@implementation TipShow

+ (void)showText:(NSString *)text
              yOffset:(float)yOffset {
    TipHUD *progress = [TipHUD showHUDAddedTo:kAppWindow animated:YES];
    progress.mode = RQMBProgressHUDModeCustomView;
    progress.yOffset = yOffset;
    progress.detailsLabelFont = [UIFont systemFontOfSize:15];
    progress.removeFromSuperViewOnHide = YES;
    progress.detailsLabelText = text;
    [progress hide:YES afterDelay:showDelay];
}

+ (void)showBottomText:(NSString *)text {
    TipHUD *progress = [TipHUD showHUDAddedTo:kAppWindow animated:YES];
    progress.yOffset = kScreenHeight/2-100;
    progress.mode = RQMBProgressHUDModeCustomView;
    progress.detailsLabelFont = [UIFont systemFontOfSize:15];
    progress.removeFromSuperViewOnHide = YES;
    progress.detailsLabelText = text;
    [progress hide:YES afterDelay:showDelay];
}

+ (void)showBottomText:(NSString *)text delay:(NSTimeInterval)delay {
    TipHUD *progress = [TipHUD showHUDAddedTo:kAppWindow animated:YES];
    progress.yOffset = kScreenHeight/2-100;
    progress.mode = RQMBProgressHUDModeCustomView;
    progress.detailsLabelFont = [UIFont systemFontOfSize:15];
    progress.removeFromSuperViewOnHide = YES;
    progress.detailsLabelText = text;
    [progress hide:YES afterDelay:delay];
}

+ (void)showCenterText:(NSString *)text {
    TipHUD *progress = [TipHUD showHUDAddedTo:kAppWindow animated:YES];
    progress.yOffset = 0;
    progress.mode = RQMBProgressHUDModeCustomView;
    progress.detailsLabelFont = [UIFont systemFontOfSize:15];
    progress.removeFromSuperViewOnHide = YES;
    progress.detailsLabelText = text;
    [progress hide:YES afterDelay:showDelay];
}

+ (void)showCenterText:(NSString *)text
                 delay:(NSTimeInterval)delay {
    TipHUD *progress = [TipHUD showHUDAddedTo:kAppWindow animated:YES];
    progress.yOffset = 0;
    progress.mode = RQMBProgressHUDModeCustomView;
    progress.detailsLabelFont = [UIFont systemFontOfSize:15];
    progress.removeFromSuperViewOnHide = YES;
    progress.detailsLabelText = text;
    [progress hide:YES afterDelay:delay];
}

+ (void)showText:(NSString *)text superView:(UIView *)superView {
    TipHUD *progress = [TipHUD showHUDAddedTo:superView animated:YES];
    progress.mode = RQMBProgressHUDModeCustomView;
    progress.yOffset = kScreenHeight/2-100;
    progress.detailsLabelFont = [UIFont systemFontOfSize:15];
    progress.removeFromSuperViewOnHide = YES;
    progress.detailsLabelText = text;
    [progress hide:YES afterDelay:showDelay];
}

@end
