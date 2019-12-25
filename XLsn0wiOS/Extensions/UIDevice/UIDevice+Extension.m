
#import "UIDevice+Extension.h"

@implementation UIDevice (Extension)

- (BOOL)isiPhoneX {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat height = MAX(screenSize.width, screenSize.height);
    BOOL isX = height == 812.0 || height == 896.0;
    return isX;
}

@end
