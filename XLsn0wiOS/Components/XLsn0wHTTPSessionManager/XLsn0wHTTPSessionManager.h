//
//  XLsn0wNetworkingManager.h
//  ChineseMedicine
//
//  Created by mac on 2019/12/27.
//  Copyright © 2019 fbw. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLsn0wHTTPSessionManager : AFHTTPSessionManager

+ (XLsn0wHTTPSessionManager *_Nullable)sharedWithBaseURL:(NSString *_Nullable)baseURLString;

// 上传图片
+ (void)uploadImage:(UIImage *_Nullable)image
      baseURLString:(NSString *_Nullable)baseURLString
            purpose:(NSString *_Nullable)purpose
          purposeId:(NSString *_Nullable)purposeId
            handler:(void(^_Nullable)(id _Nullable ))handler;

// 上传多个图片
+ (void)uploadImageWithPOST:(NSString*_Nullable)URLString
              baseURLString:(NSString *_Nullable)baseURLString
                 parameters:(NSDictionary *_Nullable)parameters
                      files:(NSArray *_Nullable)files
                  fileNames:(NSArray *_Nullable)fileNames
                    success:(void(^_Nullable)(id _Nullable responseObject))success
                    failure:(void(^_Nullable)(NSError * _Nonnull error))failure;

@end

NS_ASSUME_NONNULL_END
