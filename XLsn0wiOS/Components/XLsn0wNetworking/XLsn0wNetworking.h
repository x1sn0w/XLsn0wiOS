
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <AFNetworking/AFNetworking.h>
#import <UIKit+AFNetworking.h>

#define XLsn0wHTTPNetworking [XLsn0wNetworking shared]

typedef NS_ENUM(NSUInteger, XLsn0wNetworkingHTTPMethod) {
    POST = 0,
    GET,
    PUT,
    PATCH,
    DELETE
};

typedef NS_ENUM(NSInteger, AFNetworkErrorType) {
    AFNetworkErrorType_TimedOut = NSURLErrorTimedOut,
    AFNetworkErrorType_UnURL = NSURLErrorUnsupportedURL,
    AFNetworkErrorType_NoNetwork = NSURLErrorNotConnectedToInternet,
    AFNetworkErrorType_404Failed = NSURLErrorBadServerResponse,
    AFNetworkErrorType_3840Faild = 3840,
};

typedef enum : NSInteger {
    StatusUnknown = 0,     //未知状态
    StatusNotReachable,    //无网状态
    StatusReachableViaWWAN,//手机网络
    StatusReachableViaWiFi,//Wifi网络
} NetworkStatus;

@interface  XLsn0wNetworking : NSObject

- (void)HTTPMethod:(XLsn0wNetworkingHTTPMethod)HTTPMethod
        parameters:(id _Nullable )parameters
               url:(NSString *_Nullable)url
           success:(void (^_Nullable)(id _Nullable responseObject))success
           failure:(void (^_Nullable)(NSError * _Nullable error))failure;

@property (nonatomic, assign) NetworkStatus netStatus;
@property (nonatomic, strong) NSOutputStream * _Nullable outputStream;

/**取消所有网络请求*/
+ (void)cancelAllOperations;

/**
 *  建立网络请求单例
 */
+ (instancetype _Nullable )shared;

/**
 *  GET请求
 *
 *  @param url        请求接口
 *  @param params     向服务器请求时的参数
 *  @param success    请求成功，block的参数为服务返回的数据
 *  @param failure    请求失败，block的参数为错误信息
 *  @param isShow     是否显示网络加载提示框
 *  @param isLog      是否打印日志
 */
- (void)GET:(NSString *_Nullable)url
     params:(id _Nullable)params
    success:(void (^_Nullable)(id _Nullable responseObject))success
    failure:(void (^_Nullable)(NSError *_Nullable error))failure
     isShow:(BOOL)isShow
      isLog:(BOOL)isLog;


/**
 *  POST请求
 *
 *  @param url        要提交的数据结构
 *  @param params 要提交的数据
 *  @param success    成功执行，block的参数为服务器返回的内容
 *  @param failure    执行失败，block的参数为错误信息
 *  @param isShow     是否显示网络加载提示框
 *  @param isLog      是否打印日志
 */
- (void)POST:(NSString *_Nullable)url
      params:(id _Nullable)params
     success:(void (^_Nullable)(id _Nullable responseObject))success
     failure:(void (^_Nullable)(NSError *_Nullable error))failure
      isShow:(BOOL)isShow
       isLog:(BOOL)isLog;


- (void)POST_JSON:(NSString *_Nullable)url
           params:(id _Nullable)params
          success:(void (^_Nullable)(id _Nullable responseObject))success
          failure:(void (^_Nullable)(NSError *_Nullable error))failure
           isShow:(BOOL)isShow
            isLog:(BOOL)isLog;

- (void)PUT_JSON:(NSString *_Nullable)url
          params:(id _Nullable )params
         success:(void (^_Nullable)(id _Nullable responseObject))success
         failure:(void (^_Nullable)(NSError *_Nullable error))failure
          isShow:(BOOL)isShow
           isLog:(BOOL)isLog;


/**
 *  向服务器上传文件
 *
 *  @param url       要上传的文件接口
 *  @param parameter 上传的参数
 *  @param fileData  上传的文件\数据
 *  @param fieldName 服务对应的字段
 *  @param fileName  上传到时服务器的文件名
 *  @param mimeType  上传的文件类型
 *  @param success   成功执行，block的参数为服务器返回的内容
 *  @param failure   执行失败，block的参数为错误信息
 */
- (void)POST:(NSString * _Nullable)url
   Parameter:(NSDictionary * _Nullable)parameter
        Data:(NSData *_Nullable)fileData
   FieldName:(NSString *_Nullable)fieldName
    FileName:(NSString *_Nullable)fileName
    MimeType:(NSString *_Nullable)mimeType
     Success:(void(^_Nullable)(id _Nullable responseObject))success
     Failure:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 *  下载文件
 *
 *  @param url       下载地址
 *  @param patameter 下载参数
 *  @param savedPath 保存路径
 *  @param complete  下载成功返回文件：NSData
 *  @param progress  设置进度条的百分比：progressValue
 */
- (void)downloadFileWithRequestUrl:(NSString *_Nullable)url
                         Parameter:(NSDictionary *_Nullable)patameter
                         SavedPath:(NSString * _Nullable)savedPath
                          Complete:(void (^_Nullable)(NSData * _Nullable data, NSError * _Nullable error))complete
                          Progress:(void (^_Nullable)(id _Nullable downloadProgress, double currentValue))progress;


/**
 *  NSData上传文件
 *
 *  @param url        请求地址
 *  @param data       文件data
 *  @param progress   实时进度回调
 *  @param completion 完成结果
 */
- (void)uploadDataWithRequestURLString:(NSString * _Nullable)url
                              fileData:(NSData * _Nullable)data
                              Progress:(void(^_Nullable)(NSProgress * _Nullable uploadProgress))progress
                            Completion:(void(^_Nullable)(id _Nullable object,NSError * _Nullable error))completion;


/**
 *  NSURL上传文件
 *
 *  @param str        目标地址
 *  @param fromUrl    文件源
 *  @param progress   实时进度回调
 *  @param completion 完成结果
 */
- (void)updataFileWithRequestStr:(NSString *_Nullable)str
                        FromFile:(NSURL *_Nullable)fromUrl
                        Progress:(void(^_Nullable)(NSProgress * _Nullable uploadProgress))progress
                      Completion:(void(^_Nullable)(id _Nullable object,NSError *_Nullable error))completion;

/**
 *   监听网络状态的变化
 */
+ (void)checkingNetworkResult:(void(^_Nullable)(NetworkStatus status))result;

@end
