
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UITableViewDirection){
    UITableViewDirectionNone,
    UITableViewDirectionUnData,
    UITableViewDirectionNetError,
    UITableViewDirectionUnPower
};

@protocol DefaultPageDelegate <NSObject>

- (void)reloadNetReqFromNetError;

@end

@interface UITableView ()

@property (nonatomic) UITableViewDirection defaultPage;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, weak) id<DefaultPageDelegate> reloadDelegate;

@end

@interface UITableView (Extension)

- (void)estimated_iPhone_X;
- (void)removeTableViewCellSeparator;
- (void)scrollToBottom:(BOOL)animated;
- (CGFloat)verticalOffsetOnBottom;

@end
