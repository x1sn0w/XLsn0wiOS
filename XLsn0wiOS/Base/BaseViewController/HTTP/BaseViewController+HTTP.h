//
//  BaseViewController+HTTP.h
//  ChineseMedicine
//
//  Created by Mac on 2019/5/13.
//  Copyright © 2019 fbw. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^BaseViewControllerHTTPSuccess)(id _Nullable responseObject);
typedef void(^BaseViewControllerHTTPFailure)(NSError* _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController (HTTP)

#pragma mark - GET

- (void)GET:(NSString *)url
     params:(id _Nullable)params
    success:(BaseViewControllerHTTPSuccess)success
    failure:(BaseViewControllerHTTPFailure)failure
     isShow:(BOOL)isShow
      isLog:(BOOL)isLog;

#pragma mark - POST

- (void)POST:(NSString *)url
      params:(id)params
     success:(BaseViewControllerHTTPSuccess)success
     failure:(BaseViewControllerHTTPFailure)failure
      isShow:(BOOL)isShow
       isLog:(BOOL)isLog;

- (void)POST_JSON:(NSString *)url /// application/json
           params:(id)params
          success:(BaseViewControllerHTTPSuccess)success
          failure:(BaseViewControllerHTTPFailure)failure
           isShow:(BOOL)isShow
            isLog:(BOOL)isLog;

@end

NS_ASSUME_NONNULL_END
