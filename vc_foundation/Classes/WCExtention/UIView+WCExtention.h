//
//  UIView+WCExtention.h
//  WCJunior
//
//  Created by 齐江涛 on 2017/4/6.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WCExtention)

- (UIViewController *)currentController;

- (void)makeCorner:(CGFloat)radius;
- (void)makeBorderWidth:(CGFloat)width color:(UIColor *)color;
- (void)makeShadowWithColor:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity;

@end
