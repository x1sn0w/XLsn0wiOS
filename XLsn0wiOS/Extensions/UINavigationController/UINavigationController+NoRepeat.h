//
//  UINavigationController+NoRepeat.h
//  xiaolvlan
//
//  Created by mac on 2019/3/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (NoRepeat)

//是否允许重复的方法定义
- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
              noRepeatOpen:(BOOL)flag;

- (void)xlsn0w_pushViewController:(UIViewController *)viewController
                         animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
