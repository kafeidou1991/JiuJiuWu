//
//  YZFNetworkingTool.m
//  YZF
//
//  Created by 张竟巍 on 2017/3/28.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import "JJWNetworkingTool.h"
#import "JJWCache.h"
#import "NSString+category.h"

@implementation JJWNetworkingTool
//https验证
+ (AFSecurityPolicy*)customSecurityPolicy
{
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:certificate ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    securityPolicy.pinnedCertificates = [NSSet setWithArray:@[certData]];
    
    return securityPolicy;
}


//单例
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static JJWNetworkingTool *instance;
    dispatch_once(&onceToken, ^{
        NSURL *baseUrl = [NSURL URLWithString:@""];
        instance = [[JJWNetworkingTool alloc] initWithBaseURL:baseUrl];
        // https ssl 验证。
        
        if(openHttpsSSL)
        {
            [self customSecurityPolicy];
        }
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                                   @"text/html",
                                                                                   @"text/json",
                                                                                   @"text/plain",
                                                                                   @"text/javascript",
                                                                                   @"text/xml",
                                                                                   @"image/*"]];
    });
    return instance;
}

- (NSURLSession *)downloadSession
{
    if (_downloadSession == nil) {
        
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        // nil : nil的效果跟 [[NSOperationQueue alloc] init] 是一样的
        _downloadSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    }
    
    return _downloadSession;
}



#pragma mark - get请求
+ (void)GetWithUrl: (NSString *)url params: (NSDictionary *)params isReadCache: (BOOL)isReadCache success: (responseSuccess)success failed: (ResponseFailed)failed{
    NSMutableDictionary * tempDict = params.mutableCopy;
    [[JJWNetworkingTool sharedManager] GET:url parameters:tempDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"GET------%@\n参数%@\njson----------%@",url,tempDict,[[JJWNetworkingTool sharedManager]DataTOjsonString:responseObject]);
        NSError * error = [[JJWNetworkingTool sharedManager]checkIsSuccess:responseObject Url:url];
        if (error == nil) {
            if (success) {
                //成功的话 返回data里面的内容
                success(task,[responseObject objectForKey:@"result"] ? [responseObject objectForKey:@"result"] : nil);
            }
            //请求成功,保存数据
            [JJWCache saveDataCache:responseObject forKey:url];
        }else{
            //用户需要重新登录
            if (error.code == 10002) {
                //                [[NSNotificationCenter defaultCenter] postNotificationName:ReplaceLogin object:nil];
                
            }else{
                if (failed) {
                    failed(error,nil);
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        id cacheData= nil;
        //是否读取缓存
        if (isReadCache) {
            cacheData = [JJWCache readCache:url];
        }else {
            cacheData = nil;
        }
        if (failed) {
            failed(error,cacheData);
        }
    }];
}
#pragma mark - post请求
+ (void)PostWithUrl:(NSString *)url params:(NSDictionary *)params isReadCache:(BOOL)isReadCache success:(responseSuccess)success failed:(ResponseFailed)failed{
    NSMutableDictionary * tempDict = params.mutableCopy;
    [[JJWNetworkingTool sharedManager] POST:url parameters:tempDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"POST------%@\n参数%@\njson----------%@",url,tempDict,[[JJWNetworkingTool sharedManager]DataTOjsonString:responseObject]);
        NSError * error = [[JJWNetworkingTool sharedManager]checkIsSuccess:responseObject Url:url];
        if (error == nil) {
            if (success) {
                //成功的话 返回data里面的内容
                success(task,[responseObject objectForKey:@"result"] ? [responseObject objectForKey:@"result"] : nil);
            }
            //请求成功,保存数据
            [JJWCache saveDataCache:responseObject forKey:url];
        }else{
            //用户需要重新登录
            if (error.code == -1) {
                [[NSNotificationCenter defaultCenter] postNotificationName:ReplaceLogin object:nil];
            }else{
                if (failed) {
                    failed(error,nil);
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        id cacheData= nil;
        //是否读取缓存
        if (isReadCache) {
            cacheData = [JJWCache readCache:url];
        }else {
            cacheData = nil;
        }
        if (failed) {
            failed(error,cacheData);
        }
    }];
}
-(NSString*)DataTOjsonString:(id)object{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
//检查是否有是正确链接
-(id) checkIsSuccess:(NSDictionary *)dic Url:(NSString *)url
{
    if(dic==nil) {
        NSString *str = [NSString stringWithFormat:@"%@ 返回数据为空！", url];
        return [NSError errorWithDomain:str code:0 userInfo:dic];
    }
    NSNumber *status = [dic objectForKey:@"status"];
    if (status == nil) {
        NSString *str = [NSString stringWithFormat:@"%@ 没有返回正常标识！", url];
        return [NSError errorWithDomain:str code:0 userInfo:dic];
    }
    //失败
    if (status.integerValue != 1) {
        NSString * error = [dic objectForKey:@"msg"];
        if (error == nil) {
            return [NSError errorWithDomain:@"暂无错误数据" code:0 userInfo:dic];
        }
        NSString *code = [dic objectForKey:@"status"];
        NSString *str = [NSString stringWithFormat:@"%@", [dic objectForKey:@"msg"]];
        return [NSError errorWithDomain:str code:code.integerValue userInfo:dic];
    }
    return nil;
}

//文件上传

+ (void)uploadWithUrl: (NSString *)url params: (NSDictionary *)params fileData: (NSData *)fileData name: (NSString *)name fileName: (NSString *)fileName mimeType: (NSString *)mimeType progress: (progress)progress success: (responseSuccess)success failed: (responseFailed)failed {
    [[JJWNetworkingTool sharedManager] POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task,responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failed) {
            failed(task,error,nil);
        }
        
        
    }];
    
}

//文件下载 支持断点下载
+ (void)downloadWithUrl: (NSString *)url {
    // 1. URL
    NSURL *URL = [NSURL URLWithString:url];
    
    // 2. 发起下载任务
    [JJWNetworkingTool sharedManager].downloadTask = [[JJWNetworkingTool sharedManager].downloadSession downloadTaskWithURL:URL];
    
    // 3. 启动下载任务
    [[JJWNetworkingTool sharedManager].downloadTask resume];
    
}





//暂停下载
- (void)pauseDownload {
    [self.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        self.resumeData = resumeData;
        //将已经下载的数据存到沙盒,下次APP重启后也可以继续下载
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        // 拼接文件路径   上面获取的文件路径加上文件名
        NSString *path = [@"sssssaad" stringByAppendingString:@".plist"];
        NSString *plistPath = [doc stringByAppendingPathComponent:path];
        self.resumeDataPath = plistPath;
        [resumeData writeToFile:plistPath atomically:YES];
        self.resumeData = resumeData;
        self.downloadTask = nil;
    }];
    
}

//继续下载
- (void)resumeDownloadprogress: (progress)progress success: (downloadSuccess)success failed: (downloadFailed)failed  {
    if (self.resumeData == nil) {
        NSData *resume_data = [NSData dataWithContentsOfFile:self.resumeDataPath];
        if (resume_data == nil) {
            // 即没有内存续传数据,也没有沙盒续传数据,就续传了
            return;
        } else {
            // 当沙盒有续传数据时,在内存中保存一份
            self.resumeData = resume_data;
        }
    }
    
    // 续传数据时,依然不能使用回调
    // 续传数据时起始新发起了一个下载任务,因为cancel方法是把之前的下载任务干掉了 (类似于NSURLConnection的cancel)
    // resumeData : 当新建续传数据时,resumeData不能为空,一旦为空,就崩溃
    // downloadTaskWithResumeData :已经把Range封装进去了
    
    if (self.resumeData != nil) {
        self.downloadTask = [self.downloadSession downloadTaskWithResumeData:self.resumeData];
        // 重新发起续传任务时,也要手动的启动任务
        [self.downloadTask resume];
        
    }
}

#pragma NSURLSessionDownloadDelegate

/// 监听文件下载进度的代理方法
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    // 计算进度
    float downloadProgress = (float)totalBytesWritten / totalBytesExpectedToWrite;
    DLog(@"%f",downloadProgress);
    
    
}

/// 文件下载结束时的代理方法 (必须实现的)
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    // location : 文件下载结束之后的缓存路径
    // 使用session实现文件下载时,文件下载结束之后,默认会删除,所以文件下载结束之后,需要我们手动的保存一份
    DLog(@"%@",location.path);
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    // NSString *path = @"/Users/allenjzl/Desktop/ssssss/zzzz.zip";
    // 文件下载结束之后,需要立即把文件拷贝到一个不会销毁的地方
    [[NSFileManager defaultManager] copyItemAtPath:location.path toPath:[path stringByAppendingString:@"/.zzzzzzz.zip"] error:NULL];
    DLog(@"%@",path);
}



@end

