//
//  AgreementViewController.m
//  TimeForest
//
//  Created by TimeForest on 2018/11/19.
//  Copyright © 2018 TimeForest. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController ()

@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.navTitle;
}

- (void)restoreNavBar {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage xlsn0w_imageWithColor:AppThemeColor]
                                                 forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:AppWhiteColor,
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17]}];
}

- (void)whiteNavBackBtn {
    UIButton *navButton = [UIButton buttonWithType:UIButtonTypeCustom];
    navButton.frame = CGRectMake(0, 0, 40, 40);
    navButton.contentEdgeInsets =UIEdgeInsetsMake(0, -30, 0, 0);
    [navButton setImage:whiteNavImage forState:UIControlStateNormal];
    [navButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navButton];
}

- (void)blackNavBackBtn {
    UIButton *navButton = [UIButton buttonWithType:UIButtonTypeCustom];
    navButton.frame = CGRectMake(0, 0, 40, 40);
    navButton.contentEdgeInsets =UIEdgeInsetsMake(0, -30,0, 0);
    [navButton setImage:[UIImage imageNamed:@"nav"] forState:UIControlStateNormal];
    [navButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navButton];
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)resetWhiteNavBar {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage xlsn0w_imageWithColor:UIColor.whiteColor]
                                                 forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName :AppBlackTextColor,
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:18]}];
}

- (void)viewWillAppear:(BOOL)animated {
    [self restoreNavBar];
    [self whiteNavBackBtn];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self restoreNavBar];
    [super viewWillDisappear:animated];
}

@end
