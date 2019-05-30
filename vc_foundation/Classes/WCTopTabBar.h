//
//  WCTopTabBar.h
//  wc_composite_bsd_yl_wy
//
//  Created by 齐江涛 on 17/2/28.
//  Copyright © 2017年 Daydream. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WCTopTabBar;

@protocol WCTopTabBarDelegate <NSObject>

- (void)topTabBar:(WCTopTabBar *)tabBar didClickIndex:(NSUInteger)idx;

@end

@interface WCTopTabBar : UIView

@property (nonatomic, weak) id<WCTopTabBarDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *teachMaterialBtn;
@property (weak, nonatomic) IBOutlet UIButton *letterBtn;
@property (weak, nonatomic) IBOutlet UIButton *levelBtn;
@property (weak, nonatomic) IBOutlet UIView *teachIndicator;
@property (weak, nonatomic) IBOutlet UIView *letterIndicator;
@property (weak, nonatomic) IBOutlet UIView *levelIndicator;

+ (instancetype)tabBar;
- (void)setTitles:(NSArray<NSString *> *)titles;

@end
