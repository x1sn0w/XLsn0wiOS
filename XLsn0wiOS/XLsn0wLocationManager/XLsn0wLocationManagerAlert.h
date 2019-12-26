
#import <UIKit/UIKit.h>

@interface XLsn0wLocationManagerAlert : NSObject

+ (void)addSecConfirmAlertWithController:(UIViewController *)viewController
                                   title:(NSString *)title
                                 message:(NSString *)message
                           confiemAction:(void(^)(UIAlertAction *action))confiemAction;

@end
