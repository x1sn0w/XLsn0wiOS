
#import "UIScrollView+Extension.h"
#import "MJRefresh.h"
#import <objc/runtime.h>

@interface UIScrollView ()

@property (nonatomic, copy) HeaderAction headerAction;
@property (nonatomic, copy) FooterAction footerAction;

@end

@implementation UIScrollView (Extension)

static void *pageIndexKey = &pageIndexKey;
- (void)setPageIndex:(NSInteger)pageIndex{
    objc_setAssociatedObject(self, &pageIndexKey, @(pageIndex), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)pageIndex {
    return [objc_getAssociatedObject(self, &pageIndexKey) integerValue];
}

static char *headerActionKey = "headerAction";
- (void)setHeaderAction:(HeaderAction)headerAction {
    objc_setAssociatedObject(self, &headerActionKey, headerAction, OBJC_ASSOCIATION_COPY);
}

- (HeaderAction)headerAction {
    return objc_getAssociatedObject(self, &headerActionKey);
}

- (void)setFooterAction:(FooterAction)footerAction {
    objc_setAssociatedObject(self, @"FooterAction", footerAction, OBJC_ASSOCIATION_COPY);
}

- (FooterAction)footerAction {
    return objc_getAssociatedObject(self, @"FooterAction");
}

- (void)addHeaderRefresh:(BOOL)beginRefresh animation:(BOOL)animation headerAction:(HeaderAction)headerAction {
    self.headerAction = headerAction;
    [self initPageIndex];
    @WeakObj(self);
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (selfWeak.headerAction) {
            selfWeak.headerAction();
        }
        [selfWeak endHeaderRefresh];
    }];
    
    if (beginRefresh && animation) {
        //有动画的刷新
        [self beginHeaderRefresh];
    }else if (beginRefresh && !animation){
        //刷新，但是没有动画
        [self.mj_header executeRefreshingCallback];
    }
    
    header.mj_h = 70.0;
    self.mj_header = header;
}

- (void)addFooterRefresh:(BOOL)automaticallyRefresh footerAction:(void(^)(NSInteger pageIndex))footerAction {
    self.footerAction = footerAction;
    [self initPageIndex];
    @WeakObj(self);
    
    if (automaticallyRefresh) {
        MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
             selfWeak.pageIndex += 1;
            if (selfWeak.footerAction) {
                selfWeak.footerAction(selfWeak.pageIndex);
            }
            [selfWeak endFooterRefresh];
        }];
        
        footer.automaticallyRefresh = automaticallyRefresh;
        
        [footer setTitle:@"" forState:MJRefreshStateIdle];//设置闲置状态下不显示“点击或上拉加载更多”
  
        footer.stateLabel.font = [UIFont systemFontOfSize:13.0];
        footer.stateLabel.textColor = [UIColor colorWithWhite:0.400 alpha:1.000];
        [footer setTitle:@"加载中…" forState:MJRefreshStateRefreshing];
        [footer setTitle:@"这是我的底线啦~" forState:MJRefreshStateNoMoreData];
        
        self.mj_footer = footer;
        
    } else {
        
        MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
             selfWeak.pageIndex += 1;
            if (selfWeak.footerAction) {
                selfWeak.footerAction(selfWeak.pageIndex);
            }
            [selfWeak endFooterRefresh];
        }];
        
        footer.stateLabel.font = [UIFont systemFontOfSize:13.0];
        footer.stateLabel.textColor = [UIColor colorWithWhite:0.400 alpha:1.000];
        [footer setTitle:@"加载中…" forState:MJRefreshStateRefreshing];
        [footer setTitle:@"这是我的底线啦~" forState:MJRefreshStateNoMoreData];
        
        self.mj_footer = footer;
    }
}

- (void)beginHeaderRefresh {
    [self initPageIndex];
    [self.mj_header beginRefreshing];
}

- (void)initPageIndex {
    self.pageIndex = 1;///页数默认为1
}

- (void)resetNoMoreData {
    [self.mj_footer resetNoMoreData];
}

- (void)endHeaderRefresh {
    [self.mj_header endRefreshing];
    [self resetNoMoreData];
}

- (void)endFooterRefresh {
    [self.mj_footer endRefreshing];
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

- (void)preventGestureConflicts {
    [self preventGestureConflicts:self navigationController:[self currentNav]];
}

@end
