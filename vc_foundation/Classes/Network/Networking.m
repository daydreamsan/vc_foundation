//
//  Networking.m
//  源码阅读
//
//  Created by 齐江涛 on 2017/8/8.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import "Networking.h"
#import "UserDefaultsUtility.h"

NSString *WCNetworkingStatusCode911Notification = @"WCNetworkingStatusCode911Notification";
NSString *WCNetworkingStatusCode911TypeKey      = @"WCNetworkingStatusCode911TypeKey";

@implementation Networking

+ (instancetype)networking {
    return [[self alloc] init];
}

- (NSTimeInterval)timeoutInterval {
    return 45.f;
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString
 parameters:(id)parameterDict
    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure {
    WCHTTPSessionManager *mgr = [WCHTTPSessionManager manager];
    mgr.timeoutInterval = self.timeoutInterval;
    return [mgr GET:URLString parameters:parameterDict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSInteger code911 = [[responseObject objectForKey:@"result_code"] integerValue];
        if (code911 == 911) {
            [UserDefaultsUtility setSession:nil];
            [UserDefaultsUtility setUserCode:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:WCNetworkingStatusCode911Notification object:nil];
        }
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
  parameters:(NSDictionary *)parameterDict
     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
     failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure{
    WCHTTPSessionManager *mgr = [WCHTTPSessionManager manager];
    mgr.timeoutInterval = self.timeoutInterval;
    return [mgr POST:URLString parameters:parameterDict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSInteger code911 = [[responseObject objectForKey:@"result_code"] integerValue];
        if (code911 == 911) {
            [UserDefaultsUtility setSession:nil];
            [UserDefaultsUtility setUserCode:nil];
            [UserDefaultsUtility setHasSyncBasicData:NO];
            [UserDefaultsUtility setHasCompletePersonalInfo:NO];
            [[NSNotificationCenter defaultCenter] postNotificationName:WCNetworkingStatusCode911Notification object:nil];
        }
        if (success) {
            success(task, responseObject);
        }
    } failure:failure];
}

- (NSURLSessionDataTask *)uploadImageWithURLString:(NSString *)URLString
                      parameters:(NSDictionary *)parameterDict
                       imageData:(NSData *)imageData
                        fileName:(NSString *)fileName
                        progress:(void (^)(NSProgress *uploadProgress))uploadProgress
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure {
    WCHTTPSessionManager *mgr = [WCHTTPSessionManager manager];
    mgr.timeoutInterval = self.timeoutInterval;
    return [mgr POST:URLString parameters:parameterDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"upload" fileName:fileName mimeType:@"image/jpeg"];
    } progress:uploadProgress success:success failure:failure];
}

- (NSURLSessionDataTask *)uploadAudioWithURLString:(NSString *)URLString
                      parameters:(NSDictionary *)parameterDict
                       audioData:(NSData *)audioData
                        fileName:(NSString *)fileName
                        progress:(void (^)(NSProgress *uploadProgress))uploadProgress
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure {
    WCHTTPSessionManager *mgr = [WCHTTPSessionManager manager];
    mgr.timeoutInterval = self.timeoutInterval;
    return [mgr POST:URLString parameters:parameterDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:audioData name:@"upload" fileName:fileName mimeType:@"audio/mpeg"];
    } progress:uploadProgress success:success failure:failure];
}

- (NSString *)URLStringWithTask:(NSURLSessionDataTask *)task {
    return nil;
}

@end
