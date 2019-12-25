//
//  BaseViewController+WebView.h
//  ChineseMedicine
//
//  Created by Mac on 2019/5/13.
//  Copyright © 2019 fbw. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController (WebView)

- (void)pushToWebViewFromUrl:(NSString *)url
                    navTitle:(NSString *)navTitle;

- (void)pushToWebViewFromUrl:(NSString *)url
                    navTitle:(NSString *)navTitle
         isHideNavigationBar:(BOOL)isHideNavigationBar
                isCanRefresh:(BOOL)isCanRefresh;

@end

NS_ASSUME_NONNULL_END
