//
//  UIViewController+WCExtention.h
//  WCJunior
//
//  Created by 齐江涛 on 2017/4/6.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QTPopInterface<NSObject>

- (BOOL)shouldPop;

@end

@interface UIViewController (WCExtention)<QTPopInterface>

/**
 是否允许右滑返回. YES - 允许, NO - 禁止, 默认为YES
 */
@property (nonatomic, assign) BOOL swipeback;

/**
 是否隐藏导航条. YES - 隐藏, NO - 显示, 默认为NO
 */
@property (nonatomic, assign) BOOL hiddenNavigationBar;

/**
 状态栏Style, 默认为UIStatusBarStyleDefault
 */
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

/**
 导航条的左侧返回箭头是否显示文字, 默认为YES
 */
@property (nonatomic, assign) BOOL displayBackTitle;

/**
 用于上报的页面名称及事件ID
 */
@property (nonatomic, copy) NSString *reportedPageName;
@property (nonatomic, copy) NSString *reportedEventID;

@end
