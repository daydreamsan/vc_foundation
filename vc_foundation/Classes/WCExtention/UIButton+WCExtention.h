//
//  UIButton+WCExtention.h
//  vcistudent
//
//  Created by 齐江涛 on 2017/12/29.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (WCExtention)

+ (instancetype)defaultButtonWithTitle:(NSString *)title;
+ (instancetype)defaultButtonWithTitle:(NSString *)title bgColor:(UIColor *)bgcolor corner:(CGFloat)r;
+ (instancetype)animatedButtonWithImage:(UIImage *)image;
- (void)setTitle:(NSString *)title bgColor:(UIColor *)bgcolor selectBgColor:(UIColor *)selectBgColor;

@end
