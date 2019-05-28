//
//  Env.h
//  WCJunior
//
//  Created by 齐江涛 on 2017/4/6.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PlatformType) { PlatformTypeiOS = 2 };
typedef NS_ENUM(NSInteger, AppId) { AppIdEdition = 8 };
typedef NS_ENUM(NSInteger, WCDeviceType) { WCDeviceTypeiPhone = 1, WCDeviceTypeiPad = 2};

@interface Env : NSObject


/**
 app版本信息

 @return appID
 */
+ (NSInteger)appID;


/**
 平台ID

 @return platformID
 */
+ (NSInteger)platformID;


/**
 设备类型, 只区分iPhone与iPad

 @return deviceType
 */
+ (WCDeviceType)deviceType;


/**
 发行版本号

 @return release version
 */
+ (NSString *)releaseVesion;


/**
 构建版本号

 @return build version
 */
+ (NSString *)buildVersion;


/**
 设备系统是否越狱

 @return has apt
 */
+ (BOOL)hasAPT;

/**
 判断是否需要版本更新

 @param version 线上版本
 @return has update
 */
+ (BOOL)shouldUpdate:(NSString *)version;

@end
