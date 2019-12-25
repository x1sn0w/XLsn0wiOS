//
//  BaseViewController+Alert.h
//  ChineseMedicine
//
//  Created by Mac on 2019/5/13.
//  Copyright © 2019 fbw. All rights reserved.
//

#import "BaseViewController.h"
#import "ImportHeader.h"

typedef void(^BaseViewControllerXLsn0wAlertControllerAction)(XLsn0wAlertActioner * _Nullable action);
typedef void(^BaseViewControllerInputAlertAction)(NSString * _Nullable text);//
typedef void(^BaseViewControllerXLsn0wActionSheetAction)(XLsn0wActionSheet * _Nonnull actionSheet, NSInteger buttonIndex);

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController (Alert)

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

- (void)showActionSheet:(NSString*)title
            cancelTitle:(NSString*)cancelTitle
            otherTitles:(NSArray*)otherTitles
      actionSheetAction:(BaseViewControllerXLsn0wActionSheetAction)actionSheetAction;

@end

NS_ASSUME_NONNULL_END
