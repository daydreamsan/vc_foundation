//
//  Networking.h
//  源码阅读
//
//  Created by 齐江涛 on 2017/8/8.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WCHTTPSessionManager.h"

@interface Networking : NSObject

+ (instancetype)networking;

- (NSURLSessionDataTask *)GET:(NSString *)URLString
 parameters:(id)parameterDict
    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask * task, NSError *e))failure;

- (NSURLSessionDataTask *)POST:(NSString *)URLString
  parameters:(NSDictionary *)parameterDict
     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
     failure:(void (^)(NSURLSessionDataTask * task, NSError *e))failure;

- (NSURLSessionDataTask *)uploadImageWithURLString:(NSString *)URLString
                      parameters:(NSDictionary *)parameterDict
                       imageData:(NSData *)imageData
                        fileName:(NSString *)fileName
                        progress:(void (^)(NSProgress *uploadProgress))uploadProgress
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask * task, NSError *e))failure;

- (NSURLSessionDataTask *)uploadAudioWithURLString:(NSString *)URLString
                      parameters:(NSDictionary *)parameterDict
                       audioData:(NSData *)audioData
                        fileName:(NSString *)fileName
                        progress:(void (^)(NSProgress *uploadProgress))uploadProgress
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask * task, NSError *e))failure;

@end
