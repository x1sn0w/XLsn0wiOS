//
//  BaseViewController+OperationQueue.m
//  ChineseMedicine
//
//  Created by Mac on 2019/5/13.
//  Copyright © 2019 fbw. All rights reserved.
//

#import "BaseViewController+OperationQueue.h"

@implementation BaseViewController (OperationQueue)

# pragma mark - 返回主线程刷新UI
- (void)mainQueueRefreshUI:(BaseViewControllerMainQueueRefreshUIAction)mainQueueRefreshUI {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        if (mainQueueRefreshUI) {///需要在主线程执行的代码
            mainQueueRefreshUI();
        }
    }];
}

- (void)dispatch_async_action:(BaseViewControllerDispatchAsyncAction)dispatch_async_action refresh_UI_main_queue:(BaseViewControllerMainQueueRefreshUIAction)refresh_UI_main_queue {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 处理耗时操作的代码块...
        if (dispatch_async_action) {///需要在主线程执行的代码
            dispatch_async_action();
        }
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新
            if (refresh_UI_main_queue) {///需要在主线程执行的代码
                refresh_UI_main_queue();
            }
        });
        
    });
}

- (void)dispatch_refresh_UI_main_queue:(BaseViewControllerMainQueueRefreshUIAction)refresh_UI_main_queue {
    //通知主线程刷新
    dispatch_async(dispatch_get_main_queue(), ^{
        //回调或者说是通知主线程刷新
        if (refresh_UI_main_queue) {///需要在主线程执行的代码
            refresh_UI_main_queue();
        }
    });
}


@end
