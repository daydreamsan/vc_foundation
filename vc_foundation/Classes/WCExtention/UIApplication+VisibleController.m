//
//  UIApplication+VisibleController.m
//  vcistudent
//
//  Created by ideas on 2018/4/28.
//  Copyright © 2018年 daydream. All rights reserved.
//

#import "UIApplication+VisibleController.h"
#import "../VCFKBase.h"

@implementation UIApplication (VisibleController)

- (UIWindow *)mainWindow {
    return [[[UIApplication sharedApplication] delegate] window];
}

- (UIViewController *)visibleViewController {
    UIViewController *rootViewController = [self.mainWindow rootViewController];
    return [self getVisibleViewControllerFrom:rootViewController];
}

- (UIViewController *)getVisibleViewControllerFrom:(UIViewController *) vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self getVisibleViewControllerFrom:[((UINavigationController *) vc) visibleViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self getVisibleViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    } else {
        if (vc.presentedViewController) {
            return [self getVisibleViewControllerFrom:vc.presentedViewController];
        } else {
            return vc;
        }
    }
}

- (UINavigationController *)visibleNavigationController {
    return [[self visibleViewController] navigationController];
}

@end
