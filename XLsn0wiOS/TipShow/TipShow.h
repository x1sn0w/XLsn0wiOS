
#import <Foundation/Foundation.h>
#import "XLsn0wiOSHeader.h"
NS_ASSUME_NONNULL_BEGIN

@interface TipShow : NSObject

+ (void)showText:(NSString *)text
         yOffset:(float)yOffset;

+ (void)showCenterText:(NSString *)text;
+ (void)showBottomText:(NSString *)text;
+ (void)showBottomText:(NSString *)text
                 delay:(NSTimeInterval)delay;

+ (void)showText:(NSString *)text
       superView:(UIView *)superView;

+ (void)showCenterText:(NSString *)text
                 delay:(NSTimeInterval)delay;

@end

NS_ASSUME_NONNULL_END
