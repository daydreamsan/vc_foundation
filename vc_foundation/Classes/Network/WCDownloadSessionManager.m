//
//  WCDownloadSessionManager.m
//  源码阅读
//
//  Created by 齐江涛 on 2017/8/8.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import "WCDownloadSessionManager.h"
#import "AFNetworking.h"

@interface WCDownloadSessionManager ()

@property (nonatomic, strong) AFURLSessionManager *innerSessionManager;

@end

@implementation WCDownloadSessionManager

- (instancetype)init {
    return [self initWithSessionConfiguration:nil];
}

- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration {
    if (self = [super init]) {
        self.innerSessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    }
    return self;
}

- (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request delegate:(id<WCDownloadSessionManagerDelegate>)delegate {
    self.delegate = delegate;
    __block NSURLSessionDownloadTask *task;
    __weak __typeof__(self) weak_self = self;
    task = [self.innerSessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        __strong __typeof__(self) strong_self = weak_self;
        if (strong_self.delegate && [strong_self.delegate respondsToSelector:@selector(downloadSessionManager:downloadTask:didUpdateProgress:)]) {
            [strong_self.delegate downloadSessionManager:strong_self downloadTask:task didUpdateProgress:downloadProgress];
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        __strong __typeof__(self) strong_self = weak_self;
        if (strong_self.delegate && [strong_self.delegate respondsToSelector:@selector(downloadSessionManager:destinationWithTargetPath:response:)]) {
            return [strong_self.delegate downloadSessionManager:strong_self destinationWithTargetPath:targetPath response:response];
        }
        NSString *tmp = NSTemporaryDirectory();
        tmp = [tmp stringByAppendingPathComponent:response.suggestedFilename];
        NSURL *url = [NSURL fileURLWithPath:tmp];
        return url;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        __strong __typeof__(self) strong_self = weak_self;
        if (strong_self.delegate && [strong_self.delegate respondsToSelector:@selector(downloadSessionManager:downloadTask:didCompleteWithResponse:filePath:error:)]) {
            [strong_self.delegate downloadSessionManager:strong_self downloadTask:task didCompleteWithResponse:response filePath:filePath error:error];
        }
    }];
    return task;
}

- (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request
                                             progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock
                                          destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                                    completionHandler:(void (^)(NSURLResponse *response, NSURL * filePath, NSError * error))completionHandler {
    return [self.innerSessionManager downloadTaskWithRequest:request progress:downloadProgressBlock destination:destination completionHandler:completionHandler];
}

- (void)setDidFinishEventsForBackgroundURLSessionBlock:(void (^)(NSURLSession *session))block {
    [self.innerSessionManager setDidFinishEventsForBackgroundURLSessionBlock:block];
}

- (void)setDownloadTaskDidFinishDownloadingBlock:(NSURL * (^)(NSURLSession *session, NSURLSessionDownloadTask *downloadTask, NSURL *location))block {
    [self.innerSessionManager setDownloadTaskDidFinishDownloadingBlock:block];
}

- (void)setDownloadTaskDidWriteDataBlock:(void (^)(NSURLSession *session, NSURLSessionDownloadTask *downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite))block {
    [self.innerSessionManager setDownloadTaskDidWriteDataBlock:block];
}

- (void)setDownloadTaskDidResumeBlock:(void (^)(NSURLSession *session, NSURLSessionDownloadTask *downloadTask, int64_t fileOffset, int64_t expectedTotalBytes))block {
    [self.innerSessionManager setDownloadTaskDidResumeBlock:block];
}

@end
