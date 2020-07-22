//
//  YHBNetworkTool.m
//  YiHuiBaoPro
//
//  Created by Shaun on 2018/5/24.
//  Copyright © 2018年 YiHuiBao. All rights reserved.
//

#import "YHBNetworkTool.h"
//
typedef NS_ENUM(NSInteger, RequestType) {
    RequestTypeGet = 0,
    RequestTypePost,
    RequestTypeUpload,
    RequestTypePut,
    RequestTypeDelete
};

// 默认请求超时时间
static NSTimeInterval const kDefaultTimeoutInterval = 10;

@interface YHBNetworkTool ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation YHBNetworkTool

+ (instancetype)sharedInstance {
    static YHBNetworkTool *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[YHBNetworkTool alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        self.manager = [AFHTTPSessionManager manager];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/html",nil];
//        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.manager.requestSerializer.timeoutInterval = kDefaultTimeoutInterval;
        
        // 开始设置请求头
        [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        //[self.manager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    }
    return self;
}

+ (NSURLSessionDataTask *)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure withShowView:(UIView *)showView {
    return [YHBNetworkTool requestUrl:url parameters:parameters requestType:RequestTypeGet constructingBodyWithBlock:nil success:success failure:failure withShowView:showView];
}

+ (NSURLSessionDataTask *)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure withShowView:(UIView *)showView {
    return [YHBNetworkTool requestUrl:url parameters:parameters requestType:RequestTypePost constructingBodyWithBlock:nil success:success failure:failure withShowView:showView];
}

+ (NSURLSessionDataTask *)PUT:(NSString *)url parameters:(id )parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure withShowView:(UIView *)showView {
    return [YHBNetworkTool requestUrl:url parameters:parameters requestType:RequestTypePut constructingBodyWithBlock:nil success:success failure:failure withShowView:showView];
}

+ (NSURLSessionDataTask *)DELETE:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure withShowView:(UIView *)showView {
    return [YHBNetworkTool requestUrl:url parameters:parameters requestType:RequestTypeDelete constructingBodyWithBlock:nil success:success failure:failure withShowView:showView];
}

+ (NSURLSessionDataTask *)Upload:(NSString *)url parameters:(NSDictionary *)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))constructingBody success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure withShowView:(UIView *)showView {
    return [YHBNetworkTool requestUrl:url parameters:parameters requestType:RequestTypeUpload constructingBodyWithBlock:constructingBody success:success failure:failure withShowView:showView];
}

+ (NSURLSessionDataTask *)requestUrl:(NSString *)url parameters:(NSDictionary *)parameters requestType:(RequestType)type constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))constructingBody success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure withShowView:(UIView *)showView{
    
    YHBNetworkTool *network = [YHBNetworkTool sharedInstance];
    
    // token
    // 暂时先这样处理， 后期调试到注册接口， 登录接口再处理
    /**
     * 在注册接口， 登录接口都会返回token
     */
    
//     DDLog(@"\n%@\n", YHBUserDefaults.Authorization);
    
//    if (YHBUserDefaults.Authorization) {
//        [network.manager.requestSerializer setValue:YHBUserDefaults.Authorization forHTTPHeaderField:@"Authorization"];
//    }
    
    // 处理中文和空格问题
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    // DDLog(@"%@", url);
    
    switch (type) {
        case RequestTypeGet: {
//            network.manager.requestSerializer.timeoutInterval = kDefaultTimeoutInterval;
            NSURLSessionDataTask *task = [network.manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if (success) {
                    success(responseObject);
                }
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                if (failure) {
                    failure(error);
                }
                
                NSHTTPURLResponse *httpResponse = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
                
                if (httpResponse.statusCode != 0) {
                    
                    [self showErrorInfoWithStatusCode:httpResponse.statusCode showView:showView];
                    
                } else {
                    
                    [self showErrorInfoWithStatusCode:error.code showView:showView];
                    
                }
                
            }];
            return task;
        }
            break;
        case RequestTypePost: {
            
//            network.manager.requestSerializer.timeoutInterval = kDefaultTimeoutInterval;
            NSURLSessionDataTask *task = [network.manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                
                if (success) {
                    success(responseObject);
                }
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                if (failure) {
                    failure(error);
                }
                
                NSHTTPURLResponse *httpResponse = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
                
                if (httpResponse.statusCode != 0) {
                    
                    [self showErrorInfoWithStatusCode:httpResponse.statusCode showView:showView];
                    
                } else {
                    
                    [self showErrorInfoWithStatusCode:error.code showView:showView];
                    
                }
                
            }];
            return task;
            
        }
            break;
            
        case RequestTypePut: {
            
//            network.manager.requestSerializer.timeoutInterval = kDefaultTimeoutInterval;
            
            NSURLSessionDataTask *task = [network.manager PUT:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
                
                NSHTTPURLResponse *httpResponse = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
                
                if (httpResponse.statusCode != 0) {
                    
                    [self showErrorInfoWithStatusCode:httpResponse.statusCode showView:showView];
                    
                } else {
                    
                    [self showErrorInfoWithStatusCode:error.code showView:showView];
                    
                }
            }];
            
            return task;
            
        }
            break;
        case RequestTypeDelete: {
            
            network.manager.requestSerializer.timeoutInterval = kDefaultTimeoutInterval;
            
            NSURLSessionDataTask *task = [network.manager DELETE:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
                
                NSHTTPURLResponse *httpResponse = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
                
                if (httpResponse.statusCode != 0) {
                    
                    [self showErrorInfoWithStatusCode:httpResponse.statusCode showView:showView];
                    
                } else {
                    
                    [self showErrorInfoWithStatusCode:error.code showView:showView];
                    
                }
            }];
            
            return task;
            
        }
            break;
            
        case RequestTypeUpload: {
            
            
            
            NSURLSessionDataTask *task = [network.manager POST:url parameters:parameters constructingBodyWithBlock:constructingBody progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                
                if (success) {
                    success(responseObject);
                }
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                if (failure) {
                    failure(error);
                }
                
                NSHTTPURLResponse *httpResponse = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
                
                if (httpResponse.statusCode != 0) {
                    
                    [self showErrorInfoWithStatusCode:httpResponse.statusCode showView:showView];
                    
                } else {
                    
                    [self showErrorInfoWithStatusCode:error.code showView:showView];
                    
                }
                
            }];
            return task;
        }
            break;
        default:
            break;
    }
    
    return nil;
}

+ (void)cancelNetworkAllOperations {
    [[YHBNetworkTool sharedInstance].manager.operationQueue cancelAllOperations];
}

// 暂时用不到
+ (void)showErrorInfoWithStatusCode:(NSInteger)statusCode showView:(UIView *)showView {
    if (!showView) return;
    
    NSString *message = nil;
    switch (statusCode) {
        case 401: {} break;
            
        case 500: { message = @"服务器异常！";} break;
            
        case -1001: { message = @"网络请求超时，请稍后重试！";} break;
            
        case -1002: { message = @"不支持的URL！";} break;
            
        case -1003: { message = @"未能找到指定的服务器！";} break;
            
        case -1004: { message = @"服务器连接失败！";} break;
            
        case -1005: { message = @"连接丢失，请稍后重试！";} break;
            
        case -1009: { message = @"互联网似乎是离线的哦";} break;
            
        case -1012: { message = @"操作无法完成！";} break;
            
        default: { message = @"网络请求发生未知错误！";} break;
    }
    
    // 此处http请求为了跟安卓统一, 只弹一种消息类型, 且加载无网络页面
    // MD
    message = @"网络请求失败";
    
//    [MBProgressHUD showFailToast:message inView:showView completionHandler:nil];
}

@end
