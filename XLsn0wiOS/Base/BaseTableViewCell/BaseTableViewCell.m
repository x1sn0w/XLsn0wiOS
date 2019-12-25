//
//  BaseTableViewCell.m
//  TimeForest
//
//  Created by TimeForest on 2018/10/8.
//  Copyright © 2018年 TimeForest. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (UINavigationController*)currentNav {
    return [self currentControllerFromView:self].navigationController;
}

- (UIViewController *)currentControllerFromView:(UIView *)currentView; {
    for (UIView *next = currentView ; next ; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
                
    }
    return self;
}

- (void)addDataFromModel:(id)model {
    
}

- (void)addData:(id)model {

}

- (void)clipRoundCornersFromView:(UIView*)view {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(6, 6)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    
    maskLayer.frame = view.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    view.layer.mask = maskLayer;
}

- (void)clipRoundCornersFromViewBottomLeft:(UIView*)view {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(20, 20)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    
    maskLayer.frame = view.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    view.layer.mask = maskLayer;
}

- (BOOL)isInReview {
    NSNumber* iosApplyStatus = [UserDefaulter selectValueFromKey:@"iosApplyStatus"];
    if (iosApplyStatus.integerValue == 1) {
        return YES;
    } else {
        return NO;
    }
}

- (void)GET:(NSString *)url
     params:(NSDictionary *)params
    success:(BaseTableViewCellHTTPSuccess)success
    failure:(BaseTableViewCellHTTPFailure)failure
     isShow:(BOOL)isShow
      isLog:(BOOL)isLog {
    [XLsn0wHTTPNetworking GET:url
                       params:params
                      success:^(id responseObject) {
                          if (responseObject) {
                              if (success) {
                                  success(responseObject);
                              }
                          }
                      } failure:^(NSError *error) {
                          if (error) {
                              if (failure) {
                                  failure(error);
                              }
                          }
                      } isShow:isShow isLog:isLog];
}

- (void)POST:(NSString *)url
      params:(NSDictionary *)params
     success:(BaseTableViewCellHTTPSuccess)success
     failure:(BaseTableViewCellHTTPFailure)failure
      isShow:(BOOL)isShow
       isLog:(BOOL)isLog {
    [XLsn0wHTTPNetworking POST:url
                        params:params
                       success:^(id responseObject) {
                           if (responseObject) {
                               if (success) {
                                   success(responseObject);
                               }
                           }
                       } failure:^(NSError *error) {
                           if (error) {
                               if (failure) {
                                   failure(error);
                               }
                           }
                       } isShow:isShow isLog:isLog];
}

@end
