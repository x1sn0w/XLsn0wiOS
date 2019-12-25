//
//  BaseViewController+WebView.m
//  ChineseMedicine
//
//  Created by Mac on 2019/5/13.
//  Copyright © 2019 fbw. All rights reserved.
//

#import "BaseViewController+WebView.h"

@implementation BaseViewController (WebView)

- (void)pushToWebViewFromUrl:(NSString *)url
                    navTitle:(NSString *)navTitle {
    BaseWebViewController *vc = [[BaseWebViewController alloc] init];
    vc.navTitle = navTitle;
    if (isNotNull(url)) {
        vc.url = url;
        [[self getNavigationController] pushViewController:vc animated:true];
    }
}

- (void)pushToWebViewFromUrl:(NSString *)url
                    navTitle:(NSString *)navTitle
         isHideNavigationBar:(BOOL)isHideNavigationBar
                isCanRefresh:(BOOL)isCanRefresh {
    BaseWebViewController *vc = [[BaseWebViewController alloc] init];
    vc.isHideNavigationBar = isHideNavigationBar;
    vc.canRefresh = isCanRefresh;
    vc.navTitle = navTitle;
    if (isNotNull(url)) {
        vc.url = url;
        [[self getNavigationController] pushViewController:vc animated:true];
    }
}

@end
