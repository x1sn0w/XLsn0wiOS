//
//  XLsn0wAlertActioner.m
//  ChineseMedicine
//
//  Created by Mac on 2019/4/11.
//  Copyright © 2019 fbw. All rights reserved.
//

#import "XLsn0wAlertActioner.h"

@implementation XLsn0wAlertActioner

+ (instancetype)actionWithTitle:(NSString *)title handler:(void (^)(XLsn0wAlertActioner *action))handler {
    XLsn0wAlertActioner *instance = [XLsn0wAlertActioner new];
    instance -> _title = title;
    instance.actionHandler = handler;
    return instance;
}

@end
