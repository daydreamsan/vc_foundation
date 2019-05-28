//
//  UIApplication+VisibleController.h
//  vcistudent
//
//  Created by ideas on 2018/4/28.
//  Copyright © 2018年 daydream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (VisibleController)

/**
 获取当前可视的Controller
 */
- (UINavigationController *)visibleNavigationController;
- (UIViewController *)visibleViewController;

@end
