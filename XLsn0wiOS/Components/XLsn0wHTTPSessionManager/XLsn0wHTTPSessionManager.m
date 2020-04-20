//
//  XLsn0wNetworkingManager.m
//  ChineseMedicine
//
//  Created by mac on 2019/12/27.
//  Copyright © 2019 fbw. All rights reserved.
//

#import "XLsn0wHTTPSessionManager.h"
#import "XLsn0wiOSHeader.h"

#define UTF8StringEncoding(string) [string dataUsingEncoding:NSUTF8StringEncoding]

@implementation XLsn0wHTTPSessionManager

+ (AFHTTPSessionManager *)sharedWithBaseURL:(NSString *)baseURLString {
    static XLsn0wHTTPSessionManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XLsn0wHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseURLString]];
        NSMutableSet *contentTypes = [manager.responseSerializer.acceptableContentTypes mutableCopy];
        [contentTypes addObject:@"text/html"];
        [contentTypes addObject:@"image/png"];
        [contentTypes addObject:@"image/jpeg"];
        [contentTypes addObject:@"application/json"];
        manager.responseSerializer.acceptableContentTypes = contentTypes;
        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8"
                         forHTTPHeaderField:@"Content-Type"];
        [manager.requestSerializer setValue:[iOSDeviceInfo getLocalAppVersion]
                         forHTTPHeaderField:@"AppVersion"];
        [manager.requestSerializer setValue:@"IOS"
                         forHTTPHeaderField:@"device"];
    });
    return manager;
}

+ (NSString *)typeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
    }
    return @"jpeg";
}

+ (void)uploadPostImage:(UIImage *)image
          baseURLString:(NSString *)baseURLString
              purposeId:(NSString *)purposeId
                handler:(void (^)(id))handler{
    [self uploadImage:image baseURLString:baseURLString purpose:@"forumBbs" purposeId:purposeId handler:handler];
}

+ (void)uploadImage:(UIImage *)image
      baseURLString:(NSString *)baseURLString
            purpose:(NSString *)purpose
          purposeId:(NSString *)purposeId handler:(void(^)(id))handler{
    NSData *data = UIImageJPEGRepresentation(image, 0.8);
    if (!data) {
        data = UIImagePNGRepresentation(image);
    }
    if(!data){
        NSLog(@"图片数据为空");
        handler(nil);
        return;
    }
    NSString *type = [self typeForImageData:data];
    AFHTTPSessionManager* httpManager = [self sharedWithBaseURL:baseURLString];
    NSURLSessionDataTask *uploadTask = [httpManager
                                        POST:@"file/uploadFile"
                                        parameters:nil
                                        headers:nil
                                        constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"uploadFile" fileName:type mimeType:@"image/png"];
        [formData appendPartWithFormData:UTF8StringEncoding(@"image") name:@"fileType"];
        [formData appendPartWithFormData:UTF8StringEncoding(purpose) name:@"filePurpose"];
        [formData appendPartWithFormData:UTF8StringEncoding(purposeId) name:@"fkPurposeId"];
    }
                                        progress:nil
                                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    }
                                        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        handler(nil);
        NSLog(@"错误%@",error);
    }];
    [uploadTask resume];
}

/// 上传图片
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
+ (void)uploadImageWithPOST:(NSString*_Nullable)URLString
              baseURLString:(NSString *)baseURLString
                 parameters:(NSDictionary *_Nullable)parameters
                      files:(NSArray *_Nullable)files
                  fileNames:(NSArray *_Nullable)fileNames
                    success:(void(^_Nullable)(id _Nullable responseObject))success
                    failure:(void(^_Nullable)(NSError * _Nonnull error))failure {
    XLsn0wHTTPSessionManager *manager = [self sharedWithBaseURL:baseURLString];
    XLsn0wLog(@"URLString = %@ \n parameters = %@", URLString, convertJSON(parameters));
    XLsn0wLog(@"files = %@", files);
    XLsn0wLog(@"fileNames = %@", fileNames);
    
    [manager POST:URLString
       parameters:parameters
          headers:nil
constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < files.count; i++) {
            NSData *imageData = UIImageJPEGRepresentation(files[i], 0.8);
            [formData appendPartWithFileData:imageData
                                        name:fileNames[i]
                                    fileName:[NSString stringWithFormat:@"%@.png",fileNames[i]]
                                    mimeType:@"image/png"];
        }
    } progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        XLsn0wLog(@"responseObject = %@", convertJSON(responseObject));
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        XLsn0wLog(@"error = %@", error);
        XLsn0wLog(@"\n url   = %@ \n errorDescription = %@", [error userInfo][@"NSErrorFailingURLKey"], [error userInfo][@"NSLocalizedDescription"]);
        [TipShow showCenterText:[error userInfo][@"NSLocalizedDescription"] delay:1];
        if (failure) {
            NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            if (data != nil) {
                id JSONDictionary = [NSDictionary convertJSON:data];
                NSString *errorString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                XLsn0wLog(@"error = %@ \n JSONDictionary = %@", errorString, JSONDictionary); //就可以获取到错误时返回的body信息。
            }
            failure(error);
        }
    }];
}
#pragma clang diagnostic pop

@end
