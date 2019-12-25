//
//  BaseTableViewCell.h
//  TimeForest
//
//  Created by TimeForest on 2018/10/8.
//  Copyright © 2018年 TimeForest. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BaseTableViewCellHTTPSuccess)(id responseObject);
typedef void(^BaseTableViewCellHTTPFailure)(NSError* error);

@interface BaseTableViewCell : UITableViewCell

- (UINavigationController*)currentNav;
- (UIViewController *)currentControllerFromView:(UIView *)currentView;

- (void)addData:(id)model;
- (void)clipRoundCornersFromView:(UIView*)view;
- (void)addDataFromModel:(id)model;
- (void)clipRoundCornersFromViewBottomLeft:(UIView*)view;
- (BOOL)isInReview;

- (void)GET:(NSString *)url
     params:(NSDictionary *)params
    success:(BaseTableViewCellHTTPSuccess)success
    failure:(BaseTableViewCellHTTPFailure)failure
     isShow:(BOOL)isShow
      isLog:(BOOL)isLog;

- (void)POST:(NSString *)url
      params:(NSDictionary *)params
     success:(BaseTableViewCellHTTPSuccess)success
     failure:(BaseTableViewCellHTTPFailure)failure
      isShow:(BOOL)isShow
       isLog:(BOOL)isLog;

@end

NS_ASSUME_NONNULL_END
