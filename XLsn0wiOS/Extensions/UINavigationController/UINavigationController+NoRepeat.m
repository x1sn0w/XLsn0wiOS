//
//  UINavigationController+NoRepeat.m
//  xiaolvlan
//
//  Created by mac on 2019/3/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "UINavigationController+NoRepeat.h"

@implementation UINavigationController (NoRepeat)

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated noRepeatOpen:(BOOL)flag {
    //判断该类是否已经打开，
    if ([[self.viewControllers lastObject] isKindOfClass:viewController.class] && flag) {///"YES"表示不允许重复打开
        return;
    }
    //隐藏下方tab，可忽略
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //跳转
    [self pushViewController:viewController animated:animated];
}

- (void)xlsn0w_pushViewController:(UIViewController *)viewController
                         animated:(BOOL)animated {
    //判断该类是否已经打开，
    if ([[self.viewControllers lastObject] isKindOfClass:viewController.class] && YES) {///"YES"表示不允许重复打开
        return;
    }
    //隐藏下方tab，可忽略
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //跳转
    [self pushViewController:viewController animated:animated];
}

@end
