//
//  BaseViewController+OperationQueue.h
//  ChineseMedicine
//
//  Created by Mac on 2019/5/13.
//  Copyright © 2019 fbw. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^BaseViewControllerMainQueueRefreshUIAction)(void);
typedef void(^BaseViewControllerDispatchAsyncAction)(void);

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController (OperationQueue)

- (void)mainQueueRefreshUI:(BaseViewControllerMainQueueRefreshUIAction)mainQueueRefreshUI;
- (void)dispatch_async_action:(BaseViewControllerDispatchAsyncAction)dispatch_async_action refresh_UI_main_queue:(BaseViewControllerMainQueueRefreshUIAction)refresh_UI_main_queue;
- (void)dispatch_refresh_UI_main_queue:(BaseViewControllerMainQueueRefreshUIAction)refresh_UI_main_queue;

@end

NS_ASSUME_NONNULL_END
