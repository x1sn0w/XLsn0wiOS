//
//  BaseViewModel.h
//  ChineseMedicine
//
//  Created by Mac on 2019/5/5.
//  Copyright © 2019 fbw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImportHeader.h"
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^BaseViewModelHTTPSuccess)(id responseObject);
typedef void(^BaseViewModelHTTPFailure)(NSError* error);

@interface BaseViewModel : NSObject

@property (nonatomic, weak) UIView *view;                                  // vm.view = self.view
@property (nonatomic, weak) BaseViewController *viewController;            //控制器传递过去 vm.viewController = self
@property (nonatomic, weak) BaseNavigationController *navigationController;//vm.navigationController = self.navigationController

- (void)GET:(NSString *)url
     params:(NSDictionary *)params
    success:(BaseViewModelHTTPSuccess)success
    failure:(BaseViewModelHTTPFailure)failure
     isShow:(BOOL)isShow
      isLog:(BOOL)isLog;

- (void)POST:(NSString *)url
      params:(NSDictionary *)params
     success:(BaseViewModelHTTPSuccess)success
     failure:(BaseViewModelHTTPFailure)failure
      isShow:(BOOL)isShow
       isLog:(BOOL)isLog;

- (void)inputAlertWithTitle:(NSString*)title
                     detail:(NSString*)detail
                placeholder:(NSString*)placeholder      /// UIKeyboardTypeNumberPad  纯数字键盘
               keyboardType:(UIKeyboardType)keyboardType/// UIKeyboardTypeDecimalPad 纯数字加小数点键盘
           inputAlertAction:(BaseViewControllerInputAlertAction)inputAlertAction;

- (void)xlsn0w_AlertControllerWithTitle:(NSString*)title
                                message:(NSString*)message
                                 cancel:(NSString*)cancel
                                   sure:(NSString*)sure
                  alertControllerAction:(BaseViewControllerXLsn0wAlertControllerAction)alertControllerAction;

- (void)xlsn0w_AlertControllerWithTitle:(NSString*)title
                                message:(NSString*)message
                                 cancel:(NSString*)cancel
                                   sure:(NSString*)sure
                  alertControllerAction:(BaseViewControllerXLsn0wAlertControllerAction)alertControllerAction
                           cancelAction:(BaseViewControllerXLsn0wAlertControllerAction)cancelAction;

- (void)xlsn0w_AlertControllerWithTitle:(NSString*)title
                                message:(NSString*)message
                                 cancel:(NSString*)cancel
                  alertControllerAction:(BaseViewControllerXLsn0wAlertControllerAction)alertControllerAction;

- (void)inputAlertWithTitle:(NSString*)title
                     detail:(NSString*)detail
                placeholder:(NSString*)placeholder
           inputAlertAction:(BaseViewControllerInputAlertAction)inputAlertAction;

- (void)inputAlertWithTitle:(NSString*)title
                     detail:(NSString*)detail
                       text:(NSString*)text
           inputAlertAction:(BaseViewControllerInputAlertAction)inputAlertAction;

@end

NS_ASSUME_NONNULL_END
