//
//  UIViewController+WCExtention.m
//  WCJunior
//
//  Created by 齐江涛 on 2017/4/6.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import "UIViewController+WCExtention.h"
#import <objc/runtime.h>
#import "../VCFKBase.h"
#import "UINavigationController+WCExtention.h"


static void *wc_swipe_key                   = &wc_swipe_key;
static void *wc_statusbar_style_key         = &wc_statusbar_style_key;
static void *wc_display_backtitle_key       = &wc_display_backtitle_key;
static void *wc_hidden_navigationbar_key    = &wc_hidden_navigationbar_key;
static void *wc_reported_pagename_key       = &wc_reported_pagename_key;
static void *wc_reported_eventid_key        = &wc_reported_eventid_key;
//static void *wc_hidden_hair_line            = &wc_hidden_hair_line;

@implementation UIViewController (WCExtention)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = [self class];
        //[1]viewWillAppear:
        SEL original_selector = @selector(viewWillAppear:);
        SEL swizzled_selector = @selector(wc_viewWillAppear:);
        Method original_method = class_getInstanceMethod(cls, original_selector);
        Method swizzled_method = class_getInstanceMethod(cls, swizzled_selector);
        BOOL success = class_addMethod(cls, original_selector, method_getImplementation(swizzled_method), method_getTypeEncoding(swizzled_method));
        if (success) {
            class_replaceMethod(cls, swizzled_selector, method_getImplementation(original_method), method_getTypeEncoding(original_method));
        } else {
            method_exchangeImplementations(original_method, swizzled_method);
        }
        
        //[2]viewDidAppear:
        SEL o_view_did_appear_selector = @selector(viewDidAppear:);
        SEL s_view_did_appear_selector = @selector(wc_viewDidAppear:);
        Method o_view_did_appear_method = class_getInstanceMethod(cls, o_view_did_appear_selector);
        Method s_view_did_appear_method = class_getInstanceMethod(cls, s_view_did_appear_selector);
        success = class_addMethod(cls, o_view_did_appear_selector, method_getImplementation(s_view_did_appear_method), method_getTypeEncoding(s_view_did_appear_method));
        if (success) {
            class_replaceMethod(cls, s_view_did_appear_selector, method_getImplementation(o_view_did_appear_method), method_getTypeEncoding(o_view_did_appear_method));
        } else {
            method_exchangeImplementations(o_view_did_appear_method, s_view_did_appear_method);
        }
        
        //[3]viewDidDisappear:
        SEL o_view_did_disappear_selector = @selector(viewDidDisappear:);
        SEL s_view_did_disappear_selector = @selector(wc_viewDidDisappear:);
        Method o_view_did_disappear_method = class_getInstanceMethod(cls, o_view_did_disappear_selector);
        Method s_view_did_disappear_method = class_getInstanceMethod(cls, s_view_did_disappear_selector);
        success = class_addMethod(cls, o_view_did_disappear_selector, method_getImplementation(s_view_did_disappear_method), method_getTypeEncoding(s_view_did_disappear_method));
        if (success) {
            class_replaceMethod(cls, s_view_did_disappear_selector, method_getImplementation(o_view_did_disappear_method), method_getTypeEncoding(o_view_did_disappear_method));
        } else {
            method_exchangeImplementations(o_view_did_disappear_method, s_view_did_disappear_method);
        }
        
        //[4]viewDidLoad
        SEL o_view_did_load_selector = @selector(viewDidLoad);
        SEL s_view_did_load_selector = @selector(wc_viewDidLoad);
        Method o_view_did_load_method = class_getInstanceMethod(cls, o_view_did_load_selector);
        Method s_view_did_load_method = class_getInstanceMethod(cls, s_view_did_load_selector);
        success = class_addMethod(cls, o_view_did_load_selector, method_getImplementation(s_view_did_load_method), method_getTypeEncoding(s_view_did_load_method));
        if (success) {
            class_replaceMethod(cls, s_view_did_load_selector, method_getImplementation(o_view_did_load_method), method_getTypeEncoding(o_view_did_load_method));
        } else {
            method_exchangeImplementations(o_view_did_load_method, s_view_did_load_method);
        }
        
        //[4]dealloc
#if DEBUG
        SEL o_view_dealloc_selector = NSSelectorFromString(@"dealloc");
        SEL s_view_dealloc_selector = @selector(wc_dealloc);
        Method o_view_dealloc_method = class_getInstanceMethod(cls, o_view_dealloc_selector);
        Method s_view_dealloc_method = class_getInstanceMethod(cls, s_view_dealloc_selector);
        success = class_addMethod(cls, o_view_dealloc_selector, method_getImplementation(s_view_dealloc_method), method_getTypeEncoding(s_view_dealloc_method));
        if (success) {
            class_replaceMethod(cls, s_view_dealloc_selector, method_getImplementation(o_view_dealloc_method), method_getTypeEncoding(o_view_dealloc_method));
        } else {
            method_exchangeImplementations(o_view_dealloc_method, s_view_dealloc_method);
        }
#endif
    });
}

#pragma mark - Method Swizzling
- (void)wc_dealloc {
    NSLog(@"abc: %@ dealloc...", self);
    [self wc_dealloc];
}

- (void)wc_viewDidLoad {
    [self wc_viewDidLoad];
    if (!wc_should_exe_special(self.class)) {
        return;
    }
    self.view.backgroundColor = kBackgroundColor;
    self.displayBackTitle = NO;
    if (self.displayBackTitle) {
        
    } else {
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    }
}
- (void)wc_viewWillAppear:(BOOL)animated {
    [self wc_viewWillAppear:animated];
    if (!wc_should_exe_special(self.class)) {
        return;
    }
    [self.navigationController setNavigationBarHidden:self.hiddenNavigationBar animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:self.statusBarStyle animated:YES];
    self.navigationController.lucency = NO;
}

- (void)wc_viewDidAppear:(BOOL)animated {
    [self wc_viewDidAppear:animated];
    if (!wc_should_exe_special(self.class)) {
        return;
    }
    self.navigationController.interactivePopGestureRecognizer.enabled = self.swipeback;
}

- (void)wc_viewDidDisappear:(BOOL)animated {
    [self wc_viewDidDisappear:animated];
    if (!wc_should_exe_special(self.class)) {
        return;
    }
}

- (BOOL)shouldPop {
    return YES;
}

#pragma mark - Setter && Getter
- (void)setSwipeback:(BOOL)swipeback {
    objc_setAssociatedObject(self, wc_swipe_key, @(swipeback), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)swipeback {
    NSNumber *ret = objc_getAssociatedObject(self, wc_swipe_key);
    if (!ret) {
        return YES;
    }
    return ret.boolValue;
}

- (void)setHiddenNavigationBar:(BOOL)hiddenNavigationBar {
    objc_setAssociatedObject(self, wc_hidden_navigationbar_key, @(hiddenNavigationBar), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)hiddenNavigationBar {
    NSNumber *ret = objc_getAssociatedObject(self, wc_hidden_navigationbar_key);
    return ret.boolValue;
}
- (void)setDisplayBackTitle:(BOOL)displayBackTitle {
    if (!displayBackTitle) {
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    }
    objc_setAssociatedObject(self, wc_display_backtitle_key, @(displayBackTitle), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)displayBackTitle {
    NSNumber *ret = objc_getAssociatedObject(self, wc_display_backtitle_key);
    if (ret) {
        return ret.boolValue;
    }
    [self setDisplayBackTitle:YES];
    return YES;
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    objc_setAssociatedObject(self, wc_statusbar_style_key, @(statusBarStyle), OBJC_ASSOCIATION_ASSIGN);
}
- (UIStatusBarStyle)statusBarStyle {
    NSNumber *ret = objc_getAssociatedObject(self, wc_statusbar_style_key);
    if (!ret) {
        return UIStatusBarStyleDefault;
    }
    return ret.integerValue;
}
//- (void)setHiddenHairLine:(BOOL)hiddenHairLine {
//    objc_setAssociatedObject(self, wc_hidden_hair_line, @(hiddenHairLine), OBJC_ASSOCIATION_ASSIGN);
//}
//- (BOOL)hiddenHairLine {
//    NSNumber *ret = objc_getAssociatedObject(self, wc_hidden_hair_line);
//    if (ret) {
//        return ret.boolValue;
//    }
//    [self setHiddenHairLine:NO];
//    return YES;
//}
- (void)setReportedPageName:(NSString *)reportedPageName {
    objc_setAssociatedObject(self, wc_reported_pagename_key, reportedPageName, OBJC_ASSOCIATION_COPY);
}
- (NSString *)reportedPageName {
    return objc_getAssociatedObject(self, wc_reported_pagename_key);
}

- (void)setReportedEventID:(NSString *)reportedEventID {
    objc_setAssociatedObject(self, wc_reported_eventid_key, reportedEventID, OBJC_ASSOCIATION_COPY);
}
- (NSString *)reportedEventID {
    return objc_getAssociatedObject(self, wc_reported_eventid_key);
}

static inline BOOL wc_should_exe_special(Class one) {
    static NSArray *ignore_;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ignore_ = @[
                    @"UIInputWindowController",
                    @"UINavigationController",
                    @"UITabBarController",
                    @"TabBarController",
                    @"UIInputViewController",
                    @"UICompatibilityInputViewController",
                    @"UIApplicationRotationFollowingController",
                    @"UIApplicationRotationFollowingControllerNoTouches",
                    @"_UIAlertControllerTextFieldViewController",
                    @"_UIFallbackPresentationViewController",
                    @"UIAlertController",
                    @"UIActivityViewController",
                    @"UIActivityGroupViewController",
                    @"_UIActivityGroupListViewController",
                    @"SFAirDropActivityViewController",
                    @"MKASRootViewController",
                    @"WKActionSheet",
                    @"WCEssentialNavigationController",
                    @"_UIRemoteInputViewController",
                    ];
    });
    NSString *className = NSStringFromClass(one);
    if ([ignore_ containsObject:className] || [className hasPrefix:@"_"]) {
        return NO;
    }
    __block BOOL __private__ = NO;
    [ignore_ enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Class cls = NSClassFromString(obj);
        if ([one isKindOfClass:cls]) {
            __private__ = YES;
            *stop = YES;
        }
    }];
    return !__private__;
}

@end
