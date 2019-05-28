//
//  wclistening.pch
//  wclistening
//
//  Created by 齐江涛 on 17/3/28.
//  Copyright © 2017年 daydream. All rights reserved.
//

#ifndef __VCFKBase_H__
#define __VCFKBase_H__

#import <UIKit/UIKit.h>
#import <YYKit/YYKit.h>

//平台相关
#ifndef kPlatformFlag
#define kPlatformFlag       (2)
#endif

static inline UIColor * random_color() {
    return [UIColor colorWithRed:arc4random_uniform(256) / 255.f green:arc4random_uniform(256)/255.f blue:arc4random_uniform(256)/255.f alpha:0.5f + arc4random_uniform(100) / 100.f];
}

static inline NSString * uuid_for_platform() {
    NSString *uuidStr = [NSUUID UUID].UUIDString;
    uuidStr = [uuidStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    ///32位随机串+2表示iOS平台
    uuidStr = [uuidStr substringWithRange:NSMakeRange(0, 32)];
    uuidStr = [uuidStr stringByAppendingString:@(kPlatformFlag).stringValue];
    return uuidStr;
}

//#define RGBA(red, green, blue, alpha)   ([UIColor colorWithRed:((red)/255.0) green:((green)/255.0) blue:((blue)/255.0) alpha:(alpha)])
static inline UIColor *RGBA(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha) {
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

//#define RGB_A(rgbValue, alpha)  ([UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0 green:((CGFloat)((rgbValue & 0xFF00) >> 8))/255.0 blue:((CGFloat)(rgbValue & 0xFF))/255.0 alpha:alpha])
static inline UIColor *RGB_A(NSInteger rgbValue, CGFloat alpha) {
    return [UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0 green:((CGFloat)((rgbValue & 0xFF00) >> 8))/255.0 blue:((CGFloat)(rgbValue & 0xFF))/255.0 alpha:alpha];
}

static inline id view_from_main_bundle_at(NSString *name, NSInteger idx) {
    return [[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil][idx];
}

static inline NSString *timestamp_2_timestring(NSTimeInterval time) {
    if (isnan(time)) time = 0.f;
    int min = time / 60.0;
    int sec = time - min * 60;
    NSString *minStr = min > 9 ? [NSString stringWithFormat:@"%d",min] : [NSString stringWithFormat:@"0%d",min];
    NSString *secStr = sec > 9 ? [NSString stringWithFormat:@"%d",sec] : [NSString stringWithFormat:@"0%d",sec];
    NSString *timeStr = [NSString stringWithFormat:@"%@:%@",minStr, secStr];
    return timeStr;
}

static inline NSArray<id> *wc_json_2_array_with_source(NSString *source) {
    if (!source.length) {
        return nil;
    }
    NSData *data = [source dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *tt = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    return tt;
}

static inline BOOL wc_obj_can_responds_to_selector(id obj, SEL sel) {
    return obj && [obj respondsToSelector:sel];
}

static inline NSString * wc_load_main_bundle_image(NSString *name) {
    NSString *imgname;
    if ( kScreenScale >= 3.0) {
        imgname = [name stringByAppendingString:@"@3x.png"];
    } else {
        imgname = [name stringByAppendingString:@"@2x.png"];
    }
    return [[NSBundle mainBundle] pathForResource:imgname ofType:nil];
}

#define kAppdelegate    ((AppDelegate*)[[UIApplication sharedApplication] delegate])
#define kApplication    ([UIApplication sharedApplication])
#define kKeyWindow      ([[UIApplication sharedApplication] keyWindow])

#define kSystemVersionGreaterThanOrEqualTo(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define kisiOS8     kSystemVersionGreaterThanOrEqualTo(@"8.0")
#define kisiOS9     kSystemVersionGreaterThanOrEqualTo(@"9.0")
#define kisiOS10    kSystemVersionGreaterThanOrEqualTo(@"10.0")
#define kisiOS11    kSystemVersionGreaterThanOrEqualTo(@"11.0")

#if CGFLOAT_IS_DOUBLE
#define CGFLOAT_EPSILON DBL_EPSILON
#else
#define CGFLOAT_EPSILON FLT_EPSILON
#endif

#define CGFloatEqual(A, B) (ABS(A-B) < CGFLOAT_EPSILON)

#ifdef DEBUG
#define XLog(...)   NSLog(__VA_ARGS__)
#else
#define XLog(...)
#endif

#ifndef WCTimeDebug
#if DEBUG
#define WCTimeDebug(pre, x)  XLog(@"%@%d:%@", pre?:@"", x, [NSDate date])
#else
#define WCTimeDebug(pre,x)
#endif
#endif

#define kDocumentPath   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define kWordBaseDownloadUrl     @"pcaudio/sound"
#define kSentenceDownloadBaseUrl @"pcaudio/test"

#define kClassName(A)   NSStringFromClass([A class])

#define kWCRankDefaultHeadImage [UIImage imageNamed:@"班级管理默认头像"]

#ifndef kIsValidUrl
#define kIsValidUrl(s)  [s hasPrefix:@"http"]
#endif

#ifndef kRandomColor
#define kRandomColor    random_color()
#endif

#ifndef kUUIDStringForPlatform
#define kUUIDStringForPlatform      uuid_for_platform()
#endif

#ifndef kBundleView
#define kBundleView(x)     view_from_main_bundle_at(x, (0))
#endif

#ifndef WCTimeInfoWithTimestamp
#define WCTimeInfoWithTimestamp(x)      timestamp_2_timestring(x)
#endif

#ifndef WCOBJCanRespondsToSelector
#define WCOBJCanRespondsToSelector(o,s)    wc_obj_can_responds_to_selector(o,s)
#endif

#define WCRefusePerformSelectorLeakWarning(one) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
one; \
_Pragma("clang diagnostic pop") \
} while (0)

//颜色
#define kBackgroundColor                RGBA(248, 248, 248, 1.f)
#define kMainTintColor                  RGB_A(0X31af00, 1)//RGBA(22, 170, 4, 1.f)
#define kAuxiliaryTintColor             RGBA(228, 255, 227, 1.f)
#define kNavigationBarTintColor         RGB_A(0XFFFFFF, 1.F)
#define kNavigationBarBackgroundColor   RGB_A(0xffffff, 1.f)

//高度
#define kStatusBarHeight    ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define kTabBarHeight       (49)
#define kNavBarHeight       (44)
#define kSystemTopHeight    (kStatusBarHeight + kNavBarHeight)
#define kSystemBottomHeight (34 + kTabBarHeight)
#define kisiPhoneX            ([[UIScreen mainScreen] bounds].size.width >=375.0f && [[UIScreen mainScreen] bounds].size.height >=812.0f && kisiPhone)
#define kisiPhone              (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kSystem32bit          ([[UIDevice currentDevice].machineModelName isEqualToString:@"iPhone 5"] ||[[UIDevice currentDevice].machineModelName isEqualToString:@"iPhone 5c"] || [[UIDevice currentDevice].machineModelName isEqualToString:@"iPhone 4"] || [[UIDevice currentDevice].machineModelName isEqualToString:@"iPhone 4s"])
#define kTopBarSafeHeight   (CGFloat)(kisiPhoneX?(44):(20))
#define kBottomSafeHeight   (CGFloat)(kisiPhoneX?(34):(0))
#define kIPhone5Height   (568.0f)
#define kIPhone6Width    (375.0f)
#define kADAPTER_FontSize(n) (n * [UIScreen mainScreen].bounds.size.width / 375.0f)
#define kSuitIPhone6PSize(n) (n * [UIScreen mainScreen].bounds.size.width / 414.0f)

//字体
//字体
#define kSystemFontOfSize(x)        ([UIFont systemFontOfSize:(x)])
#define kBoldSystemFontOfSize(x)    [UIFont boldSystemFontOfSize:(x)]
#define kPingFangSCRegularFontOfSize(x)     (([UIFont fontWithName:@"PingFangSC-Regular" size:(x)])?:(kSystemFontOfSize(x)))
#define kPingFangSCThinFontOfSize(x)        (([UIFont fontWithName:@"PingFangSC-Thin" size:(x)])?:(kSystemFontOfSize(x)))
#define kPingFangSCBoldFontOfSize(x)        (([UIFont fontWithName:@"PingFangSC-Semibold" size:(x)])?:(kSystemFontOfSize(x)))
#define kHoratioDMedMediFontOfSize(x)       (([UIFont fontWithName:@"HoratioD-Medi" size:(x)])?:(kSystemFontOfSize(x)))
#define kItalicSystemFontOfSize(x)  [UIFont italicSystemFontOfSize:(x)]
#define kItalicBoldFontOfSize(x)     ([UIFont fontWithName:@"Arial-BoldItalicMT" size:(x)]?:kItalicSystemFontOfSize(x))
#define kHTWithSize(x)              (([UIFont fontWithName:@"Heiti SC" size:(x)])?:(kSystemFontOfSize(x)))
#define kTimesWithSize(x)           (([UIFont fontWithName:@"TimesNewRomanPSMT" size:(x)])?:(kSystemFontOfSize(x)))
#define kTimesBoldWithSize(x)       (([UIFont fontWithName:@"TimesNewRomanPS-BoldMT" size:(x)])?:(kSystemFontOfSize(x)))
#define kKZYHJWWithSize(x)          (([UIFont fontWithName:@"FZYHJW--GB1-0" size:(x)])?:(kSystemFontOfSize(x)))


#endif /* wclistening_pch */
