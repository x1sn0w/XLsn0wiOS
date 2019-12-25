//
//  XLsn0wShareKit.h
//  ChineseMedicine
//
//  Created by Mac on 2019/5/28.
//  Copyright © 2019 fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 分享小程序类型
typedef NS_ENUM(NSUInteger, XLsn0wShareType) {
    XLsn0wShareTypeWXSceneSession  = 0,  /// 聊天界面
    XLsn0wShareTypeWXSceneTimeline = 1,  /// 朋友圈
};

NS_ASSUME_NONNULL_BEGIN

@interface XLsn0wShareKit : NSObject

+ (void)shareWXFromTitle:(NSString*)title
             description:(NSString*)description
                imageUrl:(NSString*)imageUrl
              webpageUrl:(NSString*)webpageUrl
                   scene:(XLsn0wShareType)scene;

+ (void)shareWXFromTitle:(NSString*)title
             description:(NSString*)description
              localImage:(UIImage*)localImage
              webpageUrl:(NSString*)webpageUrl
                   scene:(XLsn0wShareType)scene;

@end

NS_ASSUME_NONNULL_END
