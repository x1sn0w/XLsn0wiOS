//
//  BaseViewController+HTTP.m
//  ChineseMedicine
//
//  Created by Mac on 2019/5/13.
//  Copyright © 2019 fbw. All rights reserved.
//

#import "BaseViewController+HTTP.h"
#import "HomeViewController.h"

@implementation BaseViewController (HTTP)

- (void)GET:(NSString *)url
     params:(id)params
    success:(BaseViewControllerHTTPSuccess)success
    failure:(BaseViewControllerHTTPFailure)failure
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
      params:(id)params
     success:(BaseViewControllerHTTPSuccess)success
     failure:(BaseViewControllerHTTPFailure)failure
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

- (void)POST_JSON:(NSString *)url
           params:(id)params
          success:(BaseViewControllerHTTPSuccess)success
          failure:(BaseViewControllerHTTPFailure)failure
           isShow:(BOOL)isShow
            isLog:(BOOL)isLog {
    [XLsn0wHTTPNetworking POST_JSON:url
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
