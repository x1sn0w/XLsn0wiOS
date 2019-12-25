//
//  NoviceGuidePager.m
//  ChineseMedicine
//
//  Created by Mac on 2019/5/30.
//  Copyright © 2019 fbw. All rights reserved.
//

#import "NoviceGuidePager.h"

@interface NoviceGuidePager ()

@property (nonatomic, assign) int times;

@end

@implementation NoviceGuidePager

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {
    self.times = 0;
    [self setImage:UIImageName(@"NoviceGuidePager1") forState:(UIControlStateNormal)];
    [[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable btn) {
        self.times++;
        XLsn0wLog(@"times = %d", self.times);
        if (self.times == 1) {
            [UIView animateWithDuration:0.3 animations:^{
                [self setImage:UIImageName(@"NoviceGuidePager2") forState:(UIControlStateNormal)];
            } completion:^(BOOL finished) {}];
        } else if (self.times == 2) {
            [UIView animateWithDuration:0.3 animations:^{
                [self setImage:UIImageName(@"NoviceGuidePager3") forState:(UIControlStateNormal)];
            } completion:^(BOOL finished) {}];
        } else if (self.times == 3) {
            [UIView animateWithDuration:0.3 animations:^{
                [self setImage:UIImageName(@"NoviceGuidePager4") forState:(UIControlStateNormal)];
            } completion:^(BOOL finished) {}];
        } else if (self.times == 4) {
            [UIView animateWithDuration:0.3 animations:^{
                [self removeFromSuperview];
            } completion:^(BOOL finished) {}];
        }
    }];
}

+ (void)show {
    //首先判断是否是第一次运行
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"NoviceGuidePagerFirst"]) {
        NoviceGuidePager* shadeView = [[NoviceGuidePager alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:shadeView];
        //保存，已经不是第一次运行了
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"NoviceGuidePagerFirst"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
