
#import "UITableView+Extension.h"
#import <objc/runtime.h>

@implementation UITableView (Extension)

static char reloadDelegateKey;
- (id<DefaultPageDelegate>)reloadDelegate{
    return objc_getAssociatedObject(self, &reloadDelegateKey);
}

- (void)setReloadDelegate:(id<DefaultPageDelegate>)reloadDelegate {
    objc_setAssociatedObject(self, &reloadDelegateKey, reloadDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UINavigationController*)currentNav {
    return [self getCurrentVCWithCurrentView:self].navigationController;
}

- (UIViewController *)currentControllerFromView:(UIView *)currentView {
    return [self getCurrentVCWithCurrentView:self];
}

- (UIViewController *)getCurrentVCWithCurrentView:(UIView *)currentView {
    for (UIView *next = currentView ; next ; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)estimated_iPhone_X {
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
    [self preventGestureConflicts:self navigationController:[self currentNav]];
}

- (void)removeTableViewCellSeparator {
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)configureHeaderImageName:(NSString *)imageName promptTitle:(NSString *)title type:(UITableViewDirection)type {
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    imageView.center = CGPointMake(self.width/2.0, (self.height -imageView.height-24)/2.0);
    UILabel *titleLabel = [UILabel new];

    titleLabel.frame = CGRectMake(0, imageView.bottom+10, self.width, 14);
//    titleLabel.textColor = HLMyHexRGB(0x999999);
    titleLabel.font = FFont_13;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    
    [footerView addSubview:imageView];
    [footerView addSubview:titleLabel];
    
    if (type == UITableViewDirectionNetError) {
        [self addTapGestureRecognizerInView:footerView];
    }
    self.tableFooterView = footerView;
}

- (void)addTapGestureRecognizerInView:(UIView*)view {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reloadNetReq:)];
    tap.numberOfTouchesRequired = 1; //手指数
    tap.numberOfTapsRequired = 1; //tap次数
    [view addGestureRecognizer:tap];
}

- (void)reloadNetReq:(UITapGestureRecognizer*)tap {
    [self.reloadDelegate reloadNetReqFromNetError];
}

- (void)dealloc {
    self.tableFooterView = nil;
}

-(void)setDefaultPage:(UITableViewDirection)defaultPage {
    switch (defaultPage) {
        case UITableViewDirectionNone:
            self.tableFooterView = [UIView new];
            break;
            
        case UITableViewDirectionUnData:
            [self configureHeaderImageName:@"UITableViewDirectionUnData" promptTitle:@"暂无数据" type:UITableViewDirectionUnData];
            break;
            
        case UITableViewDirectionNetError:
            [self configureHeaderImageName:@"UITableViewDirectionNetError" promptTitle:@"网络不太给力，点击重新加载" type:UITableViewDirectionNetError];
            break;
            
        case UITableViewDirectionUnPower:
            [self configureHeaderImageName:@"UITableViewDirectionUnPower" promptTitle:@"抱歉，您没有查看权限" type:UITableViewDirectionUnPower];
            break;
            
        default:
            break;
    }
}

- (CGFloat)verticalOffsetOnBottom {
    CGFloat viewHeight = self.bounds.size.height;
    CGFloat contentHeight = self.contentSize.height;
    CGFloat topInset = self.contentInset.top;
    CGFloat bottomInset = self.contentInset.bottom;
    CGFloat bottomOffset = floorf(contentHeight - bottomInset - topInset - viewHeight);
    return MAX(bottomOffset, 0);
}

- (void)scrollToBottom:(BOOL)animated {
    CGPoint bottomOffset = CGPointMake(0, [self verticalOffsetOnBottom]);
    [self setContentOffset:bottomOffset animated:animated];
}

@end
