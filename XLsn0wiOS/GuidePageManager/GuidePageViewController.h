
#import <UIKit/UIViewController.h>
#import <UIKit/UIKit.h>

@interface KSGuaidViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView* imageView;

@end

UIKIT_EXTERN NSString * const KSGuaidViewCellID;

@interface GuidePageViewController : UIViewController

@property (nonatomic, copy) dispatch_block_t willDismissHandler;

@end
