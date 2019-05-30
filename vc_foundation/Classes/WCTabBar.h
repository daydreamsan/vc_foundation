//
//  WCTabBar.h
//  vci
//
//  Created by 齐江涛 on 2017/11/6.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WCTabBar;
@protocol WCTabBarDelegate <NSObject>

- (void)tabBar:(WCTabBar *)tabBar didSelectIndex:(NSInteger)idx;

@end

@interface WCTabBar : UIView

@property (nonatomic, weak) id<WCTabBarDelegate> delegate;
@property (nonatomic, assign) NSInteger selectedIndex;

- (void)setTitles:(NSArray<NSString *> *)titles;

@end
