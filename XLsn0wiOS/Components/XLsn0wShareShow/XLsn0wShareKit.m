//
//  XLsn0wShareKit.m
//  ChineseMedicine
//
//  Created by Mac on 2019/5/28.
//  Copyright © 2019 fbw. All rights reserved.
//

#import "XLsn0wShareKit.h"

@implementation XLsn0wShareKit

+ (void)shareWXFromTitle:(NSString*)title
             description:(NSString*)description
                imageUrl:(NSString*)imageUrl
              webpageUrl:(NSString*)webpageUrl
                   scene:(XLsn0wShareType)scene {
    if([WXApi isWXAppInstalled]){//判断当前设备是否安装微信客户端
        //创建多媒体消息结构体
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = title;//标题
        message.description = description;//描述
        [message setThumbImage:[[UIImage imageFromURLString:imageUrl] resizeImage:CGSizeMake(30, 30)]];
        //设置预览图
        ///@note 大小不能超过64K
        //创建网页数据对象
        WXWebpageObject *webObj = [WXWebpageObject object];
        webObj.webpageUrl = webpageUrl;//链接
        message.mediaObject = webObj;
        
        SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
        sendReq.bText = NO;//不使用文本信息
        sendReq.message = message;
        
        if (scene == XLsn0wShareTypeWXSceneSession) {
            sendReq.scene = WXSceneSession; // **< 聊天界面    */
        } else {
            sendReq.scene = WXSceneTimeline;// **< 朋友圈     */
        }
        
        [WXApi sendReq:sendReq];//发送对象实例
    }
}

+ (void)shareWXFromTitle:(NSString*)title
             description:(NSString*)description
              localImage:(UIImage*)localImage
              webpageUrl:(NSString*)webpageUrl
                   scene:(XLsn0wShareType)scene {
    if([WXApi isWXAppInstalled]){//判断当前设备是否安装微信客户端
        //创建多媒体消息结构体
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = title;//标题
        message.description = description;//描述
        [message setThumbImage:[localImage resizeImage:CGSizeMake(30, 30)]];
        //设置预览图
        ///@note 大小不能超过64K
        //创建网页数据对象
        WXWebpageObject *webObj = [WXWebpageObject object];
        webObj.webpageUrl = webpageUrl;//链接
        message.mediaObject = webObj;
        
        SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
        sendReq.bText = NO;//不使用文本信息
        sendReq.message = message;
        
        if (scene == XLsn0wShareTypeWXSceneSession) {
            sendReq.scene = WXSceneSession; // **< 聊天界面    */
        } else {
            sendReq.scene = WXSceneTimeline;// **< 朋友圈     */
        }
        
        [WXApi sendReq:sendReq];//发送对象实例
    }
}

@end
