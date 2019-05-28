//
//  Env.m
//  WCJunior
//
//  Created by 齐江涛 on 2017/4/6.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import "Env.h"

@implementation Env

//app版本信息
+ (NSInteger)appID {
    return AppIdEdition;
}

//平台ID
+ (NSInteger)platformID {
    return PlatformTypeiOS;
}

//设备类型:
+ (WCDeviceType)deviceType {
    return WCDeviceTypeiPhone;
}

//发布版本号
+ (NSString *)releaseVesion {
    NSString *reversion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return reversion?:@"";
}

//构建版本号
+ (NSString *)buildVersion {
    NSString *versionNumber;
    versionNumber = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    return versionNumber?:@"";
}

//设备系统是否越狱
+ (BOOL)hasAPT
{
    return[[NSFileManager defaultManager] fileExistsAtPath:@"/private/var/lib/apt/"];
}

+ (BOOL)shouldUpdate:(NSString *)version {
    return [Env compareVersion:[Env releaseVesion] online:version];
}

+ (BOOL)compareVersion:(NSString *)local online:(NSString *)version {
    if ([local isEqualToString:version]) {
        return NO;
    }
    BOOL update = NO;
    NSArray *tone = [local componentsSeparatedByString:@"."];
    NSArray *ttwo = [version componentsSeparatedByString:@"."];
    do {
        NSString *one = tone.firstObject;
        NSString *two = ttwo.firstObject;
        
        if (one.integerValue < two.integerValue) {
            update = YES;
            break;
        } else if (one.integerValue > two.integerValue) {
            break;
        }
        tone = [tone subarrayWithRange:NSMakeRange(1, tone.count - 1)];
        ttwo = [ttwo subarrayWithRange:NSMakeRange(1, ttwo.count - 1)];
    } while (tone.count && ttwo.count);
    if (!tone.count && ttwo.count && !update) {
        NSInteger two = [ttwo componentsJoinedByString:@""].integerValue;
        if (two) {
            update = YES;
        }
    }
    return update;
}

@end
