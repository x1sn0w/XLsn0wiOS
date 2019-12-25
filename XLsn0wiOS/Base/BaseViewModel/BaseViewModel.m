//
//  BaseViewModel.m
//  ChineseMedicine
//
//  Created by Mac on 2019/5/5.
//  Copyright © 2019 fbw. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

- (void)GET:(NSString *)url
     params:(NSDictionary *)params
    success:(BaseViewModelHTTPSuccess)success
    failure:(BaseViewModelHTTPFailure)failure
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
     success:(BaseViewModelHTTPSuccess)success
     failure:(BaseViewModelHTTPFailure)failure
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

- (void)xlsn0w_AlertControllerWithTitle:(NSString*)title
                                message:(NSString*)message
                                 cancel:(NSString*)cancel
                                   sure:(NSString*)sure
                  alertControllerAction:(BaseViewControllerXLsn0wAlertControllerAction)alertControllerAction {
    XLsn0wAlertController *xlsn0wAlertController = [XLsn0wAlertController alertControllerWithTitle:title message:message];
    XLsn0wAlertActioner *cancelActioner = [XLsn0wAlertActioner actionWithTitle:cancel handler:^(XLsn0wAlertActioner *action) {}];
    XLsn0wAlertActioner *sureActioner = [XLsn0wAlertActioner actionWithTitle:sure handler:^(XLsn0wAlertActioner *action) {
        if (alertControllerAction) {
            alertControllerAction(action);
        }
    }];
    [xlsn0wAlertController addAction:cancelActioner];
    [xlsn0wAlertController addAction:sureActioner];
    [self.viewController presentViewController:xlsn0wAlertController animated:NO completion:nil];
}

- (void)xlsn0w_AlertControllerWithTitle:(NSString*)title
                                message:(NSString*)message
                                 cancel:(NSString*)cancel
                                   sure:(NSString*)sure
                  alertControllerAction:(BaseViewControllerXLsn0wAlertControllerAction)alertControllerAction
                           cancelAction:(BaseViewControllerXLsn0wAlertControllerAction)cancelAction {
    XLsn0wAlertController *xlsn0wAlertController = [XLsn0wAlertController alertControllerWithTitle:title message:message];
    XLsn0wAlertActioner *cancelActioner = [XLsn0wAlertActioner actionWithTitle:cancel handler:^(XLsn0wAlertActioner *action) {
        if (cancelAction) {
            cancelAction(action);
        }
    }];
    XLsn0wAlertActioner *sureActioner = [XLsn0wAlertActioner actionWithTitle:sure handler:^(XLsn0wAlertActioner *action) {
        if (alertControllerAction) {
            alertControllerAction(action);
        }
    }];
    [xlsn0wAlertController addAction:cancelActioner];
    [xlsn0wAlertController addAction:sureActioner];
    [self.viewController presentViewController:xlsn0wAlertController animated:NO completion:nil];
}

- (void)xlsn0w_AlertControllerWithTitle:(NSString*)title
                                message:(NSString*)message
                                 cancel:(NSString*)cancel
                  alertControllerAction:(BaseViewControllerXLsn0wAlertControllerAction)alertControllerAction {
    XLsn0wAlertController *xlsn0wAlertController = [XLsn0wAlertController alertControllerWithTitle:title message:message];
    XLsn0wAlertActioner *cancelActioner = [XLsn0wAlertActioner actionWithTitle:cancel handler:^(XLsn0wAlertActioner *action) {
        if (alertControllerAction) {
            alertControllerAction(action);
        }
    }];
    [xlsn0wAlertController addAction:cancelActioner];
    [self.viewController presentViewController:xlsn0wAlertController animated:NO completion:nil];
}

- (void)inputAlertWithTitle:(NSString*)title
                     detail:(NSString*)detail
                placeholder:(NSString*)placeholder
           inputAlertAction:(BaseViewControllerInputAlertAction)inputAlertAction {
    [MMAlertViewConfig globalConfig].titleColor = AppBlackColor;
    [MMAlertViewConfig globalConfig].itemNormalColor = AppWhiteColor;
    [MMAlertViewConfig globalConfig].splitColor = AppBlackColor;
    [MMAlertViewConfig globalConfig].defaultTextCancel = @"取消";
    [MMAlertViewConfig globalConfig].defaultTextConfirm = @"确定";
    [MMAlertViewConfig globalConfig].itemHighlightColor = HexColor(@"#548EF0");
    [MMAlertViewConfig globalConfig].buttonFontSize = 15;
    [MMAlertViewConfig globalConfig].titleFontSize = 16;
    [MMAlertViewConfig globalConfig].detailFontSize = 13;
    MMAlertView * alertView = [[MMAlertView alloc] initWithInputTitle:title
                                                               detail:detail
                                                          placeholder:placeholder
                                                              handler:^(NSString *text) {
                                                                  if (inputAlertAction) {
                                                                      inputAlertAction(text);
                                                                  }
                                                              }];
    [alertView showWithBlock:^(MMPopupView *popupView, BOOL isFinsh) {}];
}

- (void)inputAlertWithTitle:(NSString*)title
                     detail:(NSString*)detail
                placeholder:(NSString*)placeholder
               keyboardType:(UIKeyboardType)keyboardType
           inputAlertAction:(BaseViewControllerInputAlertAction)inputAlertAction {
    [MMAlertViewConfig globalConfig].titleColor = AppBlackColor;
    [MMAlertViewConfig globalConfig].itemNormalColor = AppWhiteColor;
    [MMAlertViewConfig globalConfig].splitColor = AppBlackColor;
    [MMAlertViewConfig globalConfig].defaultTextCancel = @"取消";
    [MMAlertViewConfig globalConfig].defaultTextConfirm = @"确定";
    [MMAlertViewConfig globalConfig].itemHighlightColor = HexColor(@"#548EF0");
    [MMAlertViewConfig globalConfig].buttonFontSize = 15;
    [MMAlertViewConfig globalConfig].titleFontSize = 16;
    [MMAlertViewConfig globalConfig].detailFontSize = 13;
    [MMAlertViewConfig globalConfig].keyboardType = keyboardType;
    MMAlertView * alertView = [[MMAlertView alloc] initWithInputTitle:title
                                                               detail:detail
                                                          placeholder:placeholder
                                                              handler:^(NSString *text) {
                                                                  if (inputAlertAction) {
                                                                      inputAlertAction(text);
                                                                  }
                                                              }];
    [alertView showWithBlock:^(MMPopupView *popupView, BOOL isFinsh) {}];
}

- (void)inputAlertWithTitle:(NSString*)title
                     detail:(NSString*)detail
                       text:(NSString*)text
           inputAlertAction:(BaseViewControllerInputAlertAction)inputAlertAction {
    [MMAlertViewConfig globalConfig].titleColor = AppBlackColor;
    [MMAlertViewConfig globalConfig].itemNormalColor = AppWhiteColor;
    [MMAlertViewConfig globalConfig].splitColor = AppBlackColor;
    [MMAlertViewConfig globalConfig].defaultTextCancel = @"取消";
    [MMAlertViewConfig globalConfig].defaultTextConfirm = @"确定";
    [MMAlertViewConfig globalConfig].itemHighlightColor = HexColor(@"#548EF0");
    [MMAlertViewConfig globalConfig].buttonFontSize = 15;
    [MMAlertViewConfig globalConfig].titleFontSize = 16;
    [MMAlertViewConfig globalConfig].detailFontSize = 13;
    MMAlertView* alertView = [[MMAlertView alloc] initWithInputTitle:title
                                                              detail:detail
                                                         placeholder:@""
                                                             handler:^(NSString *text) {
                                                                 if (inputAlertAction) {
                                                                     inputAlertAction(text);
                                                                 }
                                                             }];
    alertView.inputView.text = text;
    [alertView showWithBlock:^(MMPopupView *popupView, BOOL isFinsh) {
        
    }];
}

@end
