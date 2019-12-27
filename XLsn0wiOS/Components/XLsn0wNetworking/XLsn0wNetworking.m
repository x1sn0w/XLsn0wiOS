
#import "XLsn0wNetworking.h"
#import "XLsn0wiOSHeader.h"

static NSString * const kAFNetworkingLockName = @"com.alamofire.networking.operation.lock";
#define errorDescription [error userInfo][@"NSLocalizedDescription"]
#define XLsn0wNetworking_timeoutInterval 30
#define addHTTPHeaderAppVersion ([manager.requestSerializer setValue:[iOSDeviceInfo getLocalAppVersion] forHTTPHeaderField:@"AppVersion"])

@interface XLsn0wNetworking ()

@property (readwrite, nonatomic, strong) NSRecursiveLock *lock;///递归锁

@end

@implementation XLsn0wNetworking

@synthesize outputStream = _outputStream;

+ (void)cancelAllOperations{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.operationQueue cancelAllOperations];
}

/**
 *  建立网络请求单例
 */
+ (instancetype)shared {
    static XLsn0wNetworking *XLsn0wNetwork;
    static dispatch_once_t onceToken;
    ///弱引用
    __weak XLsn0wNetworking *weakSelf = XLsn0wNetwork;
    dispatch_once(&onceToken, ^{
        if (XLsn0wNetwork == nil) {
            XLsn0wNetwork = [[XLsn0wNetworking alloc]init];
            weakSelf.lock = [[NSRecursiveLock alloc] init];
            weakSelf.lock.name = kAFNetworkingLockName;
        }
    });
    return XLsn0wNetwork;
}

/*XLsn0w*
 
 1.https证书转换
 在服务器人员，给你发送的crt证书后，进到证书路径，执行下面语句
 // openssl x509 -in 你的证书.crt -out 你的证书.cer -outform der
 这样你就可以得到cer类型的证书了。双击，导入电脑。
 2.证书放入工程
 1、可以直接把转换好的cer文件拖动到工程中。
 2、可以在钥匙串内，找到你导入的证书，单击右键，导出项目，就可以导出.cer文件的证书了
 
 NSAppTransportSecurity，
 NSExceptionDomains，
 NSIncludesSubdomains，
 NSExceptionRequiresForwardSecrecy，
 NSExceptionAllowInsecureHTTPLoads
 
 */

//支持https  AFSecurityPolicy
-  (AFSecurityPolicy *)httpsSecurityPolicy {
    //先导入证书，找到证书的路径
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"cerName" ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    //AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    //如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    NSSet *set = [[NSSet alloc] initWithObjects:certData, nil];
    securityPolicy.pinnedCertificates = set;
    
    return securityPolicy;
}

- (void)GET:(NSString *)url
     params:(id)params
    success:(void (^)(id))success
    failure:(void (^)(NSError *))failure
     isShow:(BOOL)isShow
      isLog:(BOOL)isLog {
    //网络检查
    [XLsn0wNetworking checkingNetworkResult:^(NetworkStatus status) {
        if (status == StatusNotReachable) {
            [MBProgressHUD showAutoMessage:@"网络连接失败！" ToView:kAppWindow];
            return;
        }
    }];
    
    //断言
    NSAssert(url != nil, @"url不能为空");
    
    //使用AFNetworking进行网络请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
//# warning 启用https
//    manager.securityPolicy = [self httpsSecurityPolicy];
    
    //因为服务器返回的数据如果不是application/json格式的数据
    //需要以NSData的方式接收,然后自行解析
    ///返回格式
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];///JSON
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];///二进制(NSData*)
    //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];  ///二进制(NSData*)
    manager.requestSerializer = [AFJSONRequestSerializer serializer];///POST请求: Code=-1011 "Request failed: bad request (400)
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    manager.requestSerializer.timeoutInterval = XLsn0wNetworking_timeoutInterval;
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    
    [manager.requestSerializer setValue:@"IOS" forHTTPHeaderField:@"device"];
    addHTTPHeaderAppVersion;
    
    if (isLog == true) {
        XLsn0wLog(@"url    = %@ \n params = \n%@", url, [NSString convertJSONString:params]);
    }
    
    if (isShow == YES) {
        [MBProgressHUD showActivityMessageInWindow:@"加载中..."];
    }
    ///GET请求
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        [downloadProgress addObserver:self
                           forKeyPath:@"fractionCompleted"
                              options:NSKeyValueObservingOptionNew
                              context:NULL];
        //         XLsn0wLog(@"总大小：%lld,当前大小:%lld", downloadProgress.totalUnitCount, downloadProgress.completedUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //将返回的数据转成json数据格式
        if (isLog == true) {
            XLsn0wLog(@"responseJSON = \n%@", [NSString convertJSONString:[NSDictionary convertJSON:responseObject]]);
        }
        //通过block，将数据回掉给用户
        if (success) success([NSDictionary convertJSON:responseObject]);
        [MBProgressHUD hideHUD];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        XLsn0wLog(@"\n url   = %@ \n errorDescription = %@", [error userInfo][@"NSErrorFailingURLKey"], errorDescription);
        //通过block,将错误信息回传给用户
        if (failure) failure(error);
        [MBProgressHUD hideHUD];
        [TipShow showCenterText:errorDescription delay:1];
    }];
}

- (void)POST:(NSString *)url
      params:(id)params
     success:(void (^)(id))success
     failure:(void (^)(NSError *))failure
      isShow:(BOOL)isShow
       isLog:(BOOL)isLog {
    //网络检查
    [XLsn0wNetworking checkingNetworkResult:^(NetworkStatus status) {
        if (status == StatusNotReachable) {
            [MBProgressHUD showAutoMessage:@"网络连接失败！" ToView:kAppWindow];
            return;
        }
    }];
    
    //断言
    NSAssert(url != nil, @"url不能为空");
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //# warning 启用https
    //    manager.securityPolicy = [self httpsSecurityPolicy];
    /*XLsn0w*
     
     请求格式
     AFHTTPRequestSerializer            二进制格式
     AFJSONRequestSerializer            JSON
     AFPropertyListRequestSerializer    PList(是一种特殊的XML,解析起来相对容易)
     
     返回格式
     AFHTTPResponseSerializer           二进制格式
     AFJSONResponseSerializer           JSON
     AFXMLParserResponseSerializer      XML,只能返回XMLParser,还需要自己通过代理方法解析
     AFXMLDocumentResponseSerializer (Mac OS X)
     AFPropertyListResponseSerializer   PList
     AFImageResponseSerializer          Image
     AFCompoundResponseSerializer       组合
     
     */
    ///设置请求头 请求格式
    ///请求格式不对，服务器要json格式的请求，所以要加下面的代码：
    ///[AFHTTPSessionManager manager].requestSerializer =  [AFJSONRequestSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];///POST请求: Code=-1011 "Request failed: bad request (400)
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    manager.requestSerializer.timeoutInterval = XLsn0wNetworking_timeoutInterval;///请求等待超时时间
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    
    manager.responseSerializer.acceptableContentTypes  = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",nil];
    
    
    if (isLog == true) {
        XLsn0wLog(@"url    = %@ \n params = \n%@", url, [NSString convertJSONString:params]);
    }
    
    if (isShow == YES) {
        [MBProgressHUD showActivityMessageInWindow:@"加载中..."];
    }
    
    ///返回格式 (NSData *)
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"IOS" forHTTPHeaderField:@"device"];
    addHTTPHeaderAppVersion;

    ///POST
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        [uploadProgress addObserver:self
                         forKeyPath:@"fractionCompleted"
                            options:NSKeyValueObservingOptionNew
                            context:NULL];
        //        XLsn0wLog(@"总大小：%lld,当前大小:%lld",uploadProgress.totalUnitCount,uploadProgress.completedUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //将返回的数据转成json数据格式
        if (isLog == true) {
            XLsn0wLog(@"responseJSON = \n%@", [NSString convertJSONString:[NSDictionary convertJSON:responseObject]]);
        }
        //通过block，将数据回掉给用户
        if (success) success([NSDictionary convertJSON:responseObject]);
        [MBProgressHUD hideHUD];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        XLsn0wLog(@"\n url   = %@ \n errorDescription = %@", [error userInfo][@"NSErrorFailingURLKey"], errorDescription);
        //通过block,将错误信息回传给用户
        if (failure) failure(error);
        [MBProgressHUD hideHUD];
        [TipShow showCenterText:errorDescription delay:1];
    }];
}

- (void)POST_JSON:(NSString *)url
           params:(id)params
          success:(void (^)(id))success
          failure:(void (^)(NSError *))failure
           isShow:(BOOL)isShow
            isLog:(BOOL)isLog {
    //网络检查
    [XLsn0wNetworking checkingNetworkResult:^(NetworkStatus status) {
        if (status == StatusNotReachable) {
            [MBProgressHUD showAutoMessage:@"网络连接失败！" ToView:kAppWindow];
            return;
        }
    }];
    
    //断言
    NSAssert(url != nil, @"url不能为空");
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //# warning 启用https
    //    manager.securityPolicy = [self httpsSecurityPolicy];
    /*XLsn0w*
     
     请求格式
     AFHTTPRequestSerializer            二进制格式
     AFJSONRequestSerializer            JSON
     AFPropertyListRequestSerializer    PList(是一种特殊的XML,解析起来相对容易)
     
     返回格式
     AFHTTPResponseSerializer           二进制格式
     AFJSONResponseSerializer           JSON
     AFXMLParserResponseSerializer      XML,只能返回XMLParser,还需要自己通过代理方法解析
     AFXMLDocumentResponseSerializer (Mac OS X)
     AFPropertyListResponseSerializer   PList
     AFImageResponseSerializer          Image
     AFCompoundResponseSerializer       组合
     
     */
    ///设置请求头 请求格式
    ///请求格式不对，服务器要json格式的请求，所以要加下面的代码：[AFHTTPSessionManager manager].requestSerializer =  [AFJSONRequestSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];///POST请求: Code=-1011 "Request failed: bad request (400)
    //    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    manager.requestSerializer.timeoutInterval = XLsn0wNetworking_timeoutInterval;///请求等待超时时间
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    
    manager.responseSerializer.acceptableContentTypes  = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",nil];
    
    [manager.requestSerializer setValue:@"IOS" forHTTPHeaderField:@"device"];
    addHTTPHeaderAppVersion;
    
    if (isLog == true) {
        XLsn0wLog(@"url    = %@ \n params = \n%@", url, [NSString convertJSONString:params]);
    }
    
    if (isShow == YES) {
        [MBProgressHUD showActivityMessageInWindow:@"加载中..."];
    }
    
    ///返回格式 (NSData *)
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    ///POST
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        [uploadProgress addObserver:self
                         forKeyPath:@"fractionCompleted"
                            options:NSKeyValueObservingOptionNew
                            context:NULL];
        //        XLsn0wLog(@"总大小：%lld,当前大小:%lld",uploadProgress.totalUnitCount,uploadProgress.completedUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //将返回的数据转成json数据格式
        if (isLog == true) {
            XLsn0wLog(@"responseJSON = \n%@", [NSString convertJSONString:[NSDictionary convertJSON:responseObject]]);
        }
        //通过block，将数据回掉给用户
        if (success) success([NSDictionary convertJSON:responseObject]);
        [MBProgressHUD hideHUD];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        XLsn0wLog(@"\n url   = %@ \n errorDescription = %@", [error userInfo][@"NSErrorFailingURLKey"], errorDescription);
        //通过block,将错误信息回传给用户
        if (failure) failure(error);
        [MBProgressHUD hideHUD];
        [TipShow showCenterText:errorDescription delay:1];
    }];
}

- (void)PUT_JSON:(NSString *)url
          params:(id)params
          success:(void (^)(id))success
          failure:(void (^)(NSError *))failure
           isShow:(BOOL)isShow
            isLog:(BOOL)isLog {
    
    //网络检查
    [XLsn0wNetworking checkingNetworkResult:^(NetworkStatus status) {
        if (status == StatusNotReachable) {
            [MBProgressHUD showAutoMessage:@"网络连接失败！" ToView:kAppWindow];
            return;
        }
    }];
    
    //断言
    NSAssert(url != nil, @"url不能为空");
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/javascript",@"text/json",@"text/plain", nil];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];// 设置请求头
    ///返回格式 (NSData *)
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager.requestSerializer setValue:@"IOS" forHTTPHeaderField:@"device"];
    addHTTPHeaderAppVersion;
    
    if (isLog == true) {
        XLsn0wLog(@"url    = %@ \n params = \n%@", url, [NSString convertJSONString:params]);
    }
    
    if (isShow == YES) {
        [MBProgressHUD showActivityMessageInWindow:@"加载中..."];
    }
    
    [manager PUT:url
      parameters:params
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             //将返回的数据转成json数据格式
             if (isLog == true) {
                 XLsn0wLog(@"responseJSON = \n%@", [NSString convertJSONString:[NSDictionary convertJSON:responseObject]]);
             }
             //通过block，将数据回掉给用户
             if (success) success([NSDictionary convertJSON:responseObject]);
             [MBProgressHUD hideHUD];
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             //通过block,将错误信息回传给用户
             XLsn0wLog(@"\n url   = %@ \n errorDescription = %@", [error userInfo][@"NSErrorFailingURLKey"], errorDescription);
             //通过block,将错误信息回传给用户
             if (failure) failure(error);
             [MBProgressHUD hideHUD];
             [TipShow showCenterText:errorDescription delay:1];
         }];
}

#pragma mark - 拿到进度
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    //    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    if ([keyPath isEqualToString:@"fractionCompleted"] && [object isKindOfClass:[NSProgress class]]) {
//        NSProgress *progress = (NSProgress *)object;
//        XLsn0wLog(@"进度 %f", progress.fractionCompleted);
//        XLsn0wLog(@"进度完成到 %@", progress.localizedAdditionalDescription);//显示完后比例 如：10% completed
    }
}

/**
 *  向服务器上传文件
 */
- (void)POST:(NSString *)url
   Parameter:(NSDictionary *)parameter
        Data:(NSData *)fileData FieldName:(NSString *)fieldName
    FileName:(NSString *)fileName MimeType:(NSString *)mimeType
     Success:(void (^)(id))success
     Failure:(void (^)(NSError *))failure {
    
    //网络检查
    [XLsn0wNetworking checkingNetworkResult:^(NetworkStatus status) {
        if (status == StatusNotReachable) {
            [MBProgressHUD showAutoMessage:@"网络连接失败！" ToView:kAppWindow];
            return;
        }
    }];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = XLsn0wNetworking_timeoutInterval;
    
    [manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:fileData name:fieldName fileName:fileName mimeType:mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //将返回的数据转成json数据格式
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        
        //将返回的数据转成json数据格式
        if (success) success(result);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //通过block,将错误信息回传给用户
        if (failure) failure(error);
    }];
}

/**
 *  下载文件
 */
- (void)downloadFileWithRequestUrl:(NSString *)url
                         Parameter:(NSDictionary *)patameter
                         SavedPath:(NSString *)savedPath
                          Complete:(void (^)(NSData *data, NSError *error))complete
                          Progress:(void (^)(id downloadProgress, double currentValue))progress{
    //网络检查
    [XLsn0wNetworking checkingNetworkResult:^(NetworkStatus status) {
        if (status == StatusNotReachable) {
            [MBProgressHUD showAutoMessage:@"网络连接失败！" ToView:kAppWindow];
            return;
        }
    }];
    
    //默认配置
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    //AFN3.0URLSession的句柄
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    //下载Task操作
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        double progressValue = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        if (progress) progress(downloadProgress, progressValue);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
        
        return [NSURL fileURLWithPath:savedPath != nil ? savedPath : path];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        // filePath就是下载文件的位置，可以直接拿来使用
        NSData *data;
        if (!error) {
            data = [NSData dataWithContentsOfURL:filePath];
            NSLog(@"下载地址:%@",filePath);
        }
        if (complete) complete(data, error);
    }];
    
    //默认下载操作是挂起的，须先手动恢复下载。
    [downloadTask resume];
}


/**
 *  NSData上传文件
 */
- (void)uploadDataWithRequestURLString:(NSString *)url
                              fileData:(NSData *)data
                              Progress:(void (^)(NSProgress *))progress
                            Completion:(void (^)(id, NSError *))completion {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager uploadTaskWithRequest:request fromData:data progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) progress(uploadProgress);
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (completion) completion(responseObject,error);
    }];
}


/**
 *  NSURL上传文件
 */
- (void)updataFileWithRequestStr:(NSString *)str
                        FromFile:(NSURL *)fromUrl
                        Progress:(void(^)(NSProgress *uploadProgress))progress
                      Completion:(void(^)(id object,NSError *error))completion{
    
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager uploadTaskWithRequest:request fromFile:fromUrl progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) progress(uploadProgress);
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (completion) completion(responseObject,error);
    }];
}


/**
 *   监听网络状态的变化
 */
+ (void)checkingNetworkResult:(void (^)(NetworkStatus))result {
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusUnknown) {
//            XLsn0wLog(@"---------网络未知---------");
            if (result) result(StatusUnknown);
            
        }else if (status == AFNetworkReachabilityStatusNotReachable){
//            XLsn0wLog(@"---------断开网络---------");
            if (result) result(StatusNotReachable);
            
        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
//            XLsn0wLog(@"---------手机网络---------");
            if (result) result(StatusReachableViaWWAN);
            
        }else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
//            XLsn0wLog(@"---------WiFi网络---------");
            if (result) result(StatusReachableViaWiFi);
            
        }
    }];
}

/**
 *   取消所有正在执行的网络请求项
 */
- (void)cancelAllNetworkingRequest{
    
    //开发中...
}

- (NSOutputStream *)outputStream {
    if (!_outputStream) {
        self.outputStream = [NSOutputStream outputStreamToMemory];
    }
    
    return _outputStream;
}

- (void)setOutputStream:(NSOutputStream *)outputStream {
    [self.lock lock];
    if (outputStream != _outputStream) {
        if (_outputStream) {
            [_outputStream close];
        }
        _outputStream = outputStream;
    }
    [self.lock unlock];
}

- (void)HTTPMethod:(XLsn0wNetworkingHTTPMethod)HTTPMethod
        parameters:(id)parameters
               url:(NSString *)url
           success:(void (^)(id responseObject))success
           failure:(void (^)(NSError *error))failure {
    
    XLsn0wLog(@"\n parameters = \n\n%@ \n\n url = %@ \n", convertJSON(parameters), url);
    //1、初始化：
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //2、设置请求超时时间：
    
    manager.requestSerializer.timeoutInterval = XLsn0wNetworking_timeoutInterval;
    
    //2、设置允许接收返回数据类型：
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer = [AFHTTPRequestSerializer  serializer];
    [manager.requestSerializer setValue:@"IOS" forHTTPHeaderField:@"device"];
    addHTTPHeaderAppVersion;
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [manager.requestSerializer setValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", nil];
    
    __weak __typeof(self)weakSelf = self;
    
    NSDictionary *paramDic = parameters;
    
    if (HTTPMethod == POST) {
        [manager POST:url parameters:paramDic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                XLsn0wLog(@"responseJSON = %@", convertJSON(JSONDictionary));
                success(JSONDictionary);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
                NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                if (data != nil) {
                    id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    XLsn0wLog(@"错误error = %@ %@", str, body); //就可以获取到错误时返回的body信息。
                }
                [weakSelf requestFailed:error];
            }else{
                [weakSelf requestFailed:error];
            }
        }];
    }else if (HTTPMethod == GET){
        [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                XLsn0wLog(@"responseJSON = %@", convertJSON(JSONDictionary));
                success(JSONDictionary);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                if (data != nil) {
                    id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    XLsn0wLog(@"错误error = %@ %@", str, body); //就可以获取到错误时返回的body信息。
                }
                failure(error);
                [weakSelf requestFailed:error];
            }else{
                [weakSelf requestFailed:error];
            }
        }];
    }else if (HTTPMethod == DELETE){
        [manager DELETE:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                XLsn0wLog(@"responseJSON = %@", convertJSON(JSONDictionary));
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                if (data != nil) {
                    id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    XLsn0wLog(@"错误error = %@ %@", str, body); //就可以获取到错误时返回的body信息。
                }
                failure(error);
                [weakSelf requestFailed:error];
            }else{
                [weakSelf requestFailed:error];
            }
        }];
        
    }
}

//添加请求头
- (void)startAddPostRequestMethod:(XLsn0wNetworkingHTTPMethod)method parameters:(id)parameters url:(NSString *)url success:(void (^)(id))success {
    [self startAddPostRequestMethod:method parameters:parameters url:url success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        
    }];
}

- (void)startAddPostRequestMethod:(XLsn0wNetworkingHTTPMethod)method parameters:(id)parameters url:(NSString *)url success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    //1、初始化：
    //FbwManager *Manager = [FbwManager shareManager];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //2、设置请求超时时间：
    
    manager.requestSerializer.timeoutInterval = XLsn0wNetworking_timeoutInterval;
    
    //2、设置允许接收返回数据类型：
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    NSLog(@"呵呵哒%@ %@",Manager.UUserId,Manager.AccessToken);
    manager.requestSerializer = [AFHTTPRequestSerializer  serializer];
    //    [manager.requestSerializer setValue:Manager.AccessToken forHTTPHeaderField:@"accessToken"];
    //    [manager.requestSerializer setValue:Manager.UUserId forHTTPHeaderField:@"tokenUserId"];
    
    __weak __typeof(self)weakSelf = self;
    
    NSDictionary *paramDic = parameters;
    
    if (method == POST) {
        [manager POST:url parameters:paramDic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                success(dict);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
                [weakSelf requestFailed:error];
            }else{
                [weakSelf requestFailed:error];
            }
        }];
    }else if (method == GET){
        [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                if (data != nil) {
                    id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    NSLog(@"错误error--%@ %@", str,body); //就可以获取到错误时返回的body信息。
                }
                failure(error);
                [weakSelf requestFailed:error];
            }else{
                [weakSelf requestFailed:error];
            }
        }];
    }
}

- (void)requestFailed:(NSError *)error

{
    
    //NSLog(@"--------------\n%ld %@",(long)error.code, error.debugDescription);
    
    switch (error.code) {
            
        case AFNetworkErrorType_NoNetwork : {
            NSLog(@"网络链接失败，请检查网络。");
            show(@"网络链接失败，请检查网络。");
            break;
        }
            
        case AFNetworkErrorType_TimedOut : {
            NSLog(@"访问服务器超时，请检查网络。");
            show(@"访问服务器超时，请检查网络。");
            break;
        }
            
        case AFNetworkErrorType_3840Faild : {
            NSLog(@"服务器报错了，请稍后再访问。");
            show(@"服务器报错了，请稍后再访问。");
            break;
        }
            
        default:
            show(@"加载失败,请稍后再试。");
            break;
            
    }
}

@end
