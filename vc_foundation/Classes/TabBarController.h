//
//  TabBarController.h
//  WCJunior
//
//  Created by 齐江涛 on 2017/4/6.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TabBadgePosition) {
    TabBadgePositionDefault = 3
};

@protocol TabBarControllerPlaceholder
@end

@interface TabBarController : UITabBarController

@property (nonatomic, strong) NSDictionary *launchInfo;

+ (TabBarController *)global;
+ (UINavigationController *)currentNavigationController;

- (void)badgeAt:(NSInteger)index show:(BOOL)isShow;

@end
