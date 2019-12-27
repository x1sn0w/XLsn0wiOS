#import <UIKit/UIKit.h>

@class XLsn0wPopupModel;

typedef void(^XLsn0wPopMenuBlock)(NSInteger selectedIndex, XLsn0wPopupModel *model);

@interface XLsn0wPopupSelector : UIView

@property (nonatomic, copy) void(^hideHandle)(void);
@property (nonatomic, copy) XLsn0wPopMenuBlock action;

+ (void)popFromModels:(NSArray<XLsn0wPopupModel *> *)models
               action:(XLsn0wPopMenuBlock)action;

- (void)show;
- (void)hide;

@end
