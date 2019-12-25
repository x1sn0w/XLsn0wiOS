
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (Extension)

/**
 Return `YES` if current device is iPhone X.
 
 iPhone X Safe Area
 - Top:     +24.0pt
 - Bottom:  +34.0pt
 
 @return Whether it is iPhone X
 */
- (BOOL)isiPhoneX;

@end

NS_ASSUME_NONNULL_END
