
#import <UIKit/UIKit.h>
#define device_iPhoneX         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125.f, 2436.f), [[UIScreen mainScreen] currentMode].size) : NO)
#define kHomeIndicatorH (iPhoneX ? 34.f : 0)
#define rgb(r, g, b)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

#import <Foundation/Foundation.h>

typedef void(^XLsn0wShareKitShowClickBtnAction)(NSInteger tag);

@protocol XLsn0wShareKitDelegate <NSObject>

@required
- (void)shareFromBtnTag:(NSInteger)tag;

@optional
- (void)sharePanelDidShow:(id)panel;
- (void)sharePanelDidDismiss:(id)panel;

@end

@interface XLsn0wSharePanel : UIView

@property (nonatomic, copy) XLsn0wShareKitShowClickBtnAction clickBtnAction;

/// delegate
@property (nonatomic, weak) id<XLsn0wShareKitDelegate> delegate;

- (void)show;
- (void)dismiss;

- (instancetype)initWithDelegate:(id<XLsn0wShareKitDelegate>)delegate;

@end

