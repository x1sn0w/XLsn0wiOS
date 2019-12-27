//
//  XLsn0wAlertActioner.h
//  ChineseMedicine
//
//  Created by Mac on 2019/4/11.
//  Copyright © 2019 fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLsn0wAlertActioner : NSObject

@property (nonatomic, readonly) NSString *title;
@property (copy, nonatomic) void(^actionHandler)(XLsn0wAlertActioner *action);

+ (instancetype)actionWithTitle:(NSString *)title handler:(void (^)(XLsn0wAlertActioner *action))handler;

@end

NS_ASSUME_NONNULL_END
