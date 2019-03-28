//
//  YHBNetworkTool.h
//  YiHuiBaoPro
//
//  Created by Shaun on 2018/5/24.
//  Copyright © 2018年 YiHuiBao. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "AFNetworking.h"
#import <AFNetworking/AFNetworking.h>

@interface YHBNetworkTool : NSObject

+ (NSURLSessionDataTask *)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure withShowView:(UIView *)showView;

+ (NSURLSessionDataTask *)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure withShowView:(UIView *)showView;

+ (NSURLSessionDataTask *)PUT:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure withShowView:(UIView *)showView;

+ (NSURLSessionDataTask *)DELETE:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure withShowView:(UIView *)showView;

+ (NSURLSessionDataTask *)Upload:(NSString *)url parameters:(NSDictionary *)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))constructingBody success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure withShowView:(UIView *)showView;

+ (void)cancelNetworkAllOperations;

@end
