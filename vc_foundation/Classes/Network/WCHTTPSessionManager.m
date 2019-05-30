//
//  WCHTTPSessionManager.m
//  源码阅读
//
//  Created by 齐江涛 on 2017/8/8.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import "WCHTTPSessionManager.h"
#import "AFNetworking.h"

@interface WCHTTPSessionManager ()

@property (nonatomic, strong) AFHTTPSessionManager *innerHTTPManager;
@property (nonatomic, strong) AFHTTPRequestSerializer *innerRequestSerializer;
@property (nonatomic, strong) AFHTTPResponseSerializer *innerResponseSerializer;

@end

@implementation WCHTTPSessionManager

- (instancetype)init {
    if (self = [super init]) {
        _innerHTTPManager = [AFHTTPSessionManager manager];
        _innerRequestSerializer = [self internalRequestSerializer];
        _innerResponseSerializer = [self internalResponseSerializer];
    }
    return self;
}

- (AFHTTPRequestSerializer *)internalRequestSerializer
{
    if (!_innerRequestSerializer) {
        AFHTTPRequestSerializer *requesteSerializer = [AFHTTPRequestSerializer serializer];
        _innerRequestSerializer = requesteSerializer;
        return _innerRequestSerializer;
    }
    return _innerRequestSerializer;
}

- (AFHTTPResponseSerializer *)internalResponseSerializer
{
    if (!_innerResponseSerializer) {
        AFHTTPResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
        _innerResponseSerializer = responseSerializer;
        return _innerResponseSerializer;
    }
    
    return _innerResponseSerializer;
}

- (NSDictionary *)wapperParametersWithDictionary:(NSDictionary *)dict {
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:self.baseRequestParameter];
    [dictM addEntriesFromDictionary:dict];
    return dictM;
}

#pragma mark - API

+ (instancetype)manager {
    return [[self alloc] init];
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameterDict
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure {
    return [self GET:URLString parameters:parameterDict progress:nil success:success failure:failure];
}
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                     progress:(void (^)(NSProgress *downloadProgress))downloadProgress
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure {
    self.innerRequestSerializer.timeoutInterval = self.timeoutInterval;
    NSDictionary *params = [self wapperParametersWithDictionary:parameters];
    return [self.innerHTTPManager GET:URLString parameters:params progress:downloadProgress success:success failure:failure];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(NSDictionary *)parameterDict
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure {
    return [self POST:URLString parameters:parameterDict progress:nil success:success failure:failure];
}
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                      progress:(void (^)(NSProgress *uploadProgress))uploadProgress
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure {
    self.innerRequestSerializer.timeoutInterval = self.timeoutInterval;
    NSDictionary *params = [self wapperParametersWithDictionary:parameters];
    return [self.innerHTTPManager POST:URLString parameters:params progress:uploadProgress success:success failure:failure];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
     constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                      progress:(void (^)(NSProgress *uploadProgress))uploadProgress
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure{
    self.innerRequestSerializer.timeoutInterval = self.timeoutInterval;
    NSDictionary *params = [self wapperParametersWithDictionary:parameters];
    return [self.innerHTTPManager POST:URLString parameters:params constructingBodyWithBlock:block progress:uploadProgress success:success failure:failure];
}

@end
