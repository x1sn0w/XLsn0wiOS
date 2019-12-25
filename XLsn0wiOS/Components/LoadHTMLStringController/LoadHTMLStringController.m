//
//  LoadHTMLStringController.m
//  ChineseMedicine
//
//  Created by Mac on 2019/7/25.
//  Copyright © 2019 fbw. All rights reserved.
//

#import "LoadHTMLStringController.h"

@interface LoadHTMLStringController ()

@end

@implementation LoadHTMLStringController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage xlsn0w_imageWithColor:AppThemeColor]
                                                 forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    [self addWKWebView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self whiteNavBackBtn];
}

- (void)addWKWebView {
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKWebView* webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) configuration:config];
    webView.scrollView.bounces = NO;
    [self.view addSubview:webView];
    [webView loadHTMLString:self.HTMLString baseURL:nil];
}

@end
