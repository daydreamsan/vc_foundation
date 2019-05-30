//
//  WCTabContainerViewController.h
//  vci
//
//  Created by 齐江涛 on 2017/11/6.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCFKFoundation.h"

@class WCTabContainerViewController;
@protocol WCTabContainerViewControllerDelegate <NSObject>

- (void)tabContainerViewController:(WCTabContainerViewController *)controller didSelectIndex:(NSInteger)idx;

@end

@interface WCTabContainerViewController : UIViewController

@property (nonatomic, weak) id<WCTabContainerViewControllerDelegate> delegate;

/**
 脚视图的高, 默认为`90`个点
 */
@property (nonatomic, assign) CGFloat footerHeight;
@property (nonatomic, strong, readonly) UIView *footerView;
@property (nonatomic, assign) NSInteger selectedIndex;

- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title;
- (void)setChildViewControllers:(NSArray<UIViewController *> *)childControllers titles:(NSArray<NSString *> *)titles;
- (void)setBarTitles:(NSArray<NSString *> *)titles;

@end
