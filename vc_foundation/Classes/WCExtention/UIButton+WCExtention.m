//
//  UIButton+WCExtention.m
//  vcistudent
//
//  Created by 齐江涛 on 2017/12/29.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import "UIButton+WCExtention.h"
#import "../VCFKBase.h"
#import <YYKit/YYKit.h>
#import "UIImage+WCExtention.h"
#import "UIView+WCExtention.h"

@implementation UIButton (WCExtention)

+ (instancetype)defaultButtonWithTitle:(NSString *)title {
    return [self defaultButtonWithTitle:title bgColor:kMainTintColor corner:5];
}

+ (instancetype)defaultButtonWithTitle:(NSString *)title bgColor:(UIColor *)bgcolor corner:(CGFloat)r {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(30, kScreenHeight - 80, kScreenWidth - 60, 50.f);
    [btn setTitle:title bgColor:bgcolor selectBgColor:nil corner:r];
    return btn;
}

+ (instancetype)animatedButtonWithImage:(UIImage *)image {
    UIButton * soundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [soundButton setImage:image forState:UIControlStateNormal];
    soundButton.adjustsImageWhenHighlighted = NO;
    [soundButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
    NSArray *images = @[[UIImage imageNamed:@"line01"], [UIImage imageNamed:@"line02"], [UIImage imageNamed:@"line03"], [UIImage imageNamed:@"line04"]];
    soundButton.imageView.animationImages = images;
    soundButton.imageView.animationDuration = 0.8;
    [soundButton sizeToFit];
    return soundButton;
}

- (void)setTitle:(NSString *)title bgColor:(UIColor *)bgcolor selectBgColor:(UIColor *)selectBgColor {
    [self setTitle:title bgColor:bgcolor selectBgColor:selectBgColor corner:5];
}

- (void)setTitle:(NSString *)title bgColor:(UIColor *)bgcolor selectBgColor:(UIColor *)selectBgColor corner:(CGFloat)r {
    UIImage *bg = [UIImage imageWithColor:bgcolor size:CGSizeMake(20, 20)];
    UIColor *bgm = selectBgColor?selectBgColor:RGBA(138, 210, 109, 1.f);
    UIImage *hbg = [[UIImage imageWithColor:bgm size:CGSizeMake(20, 20)] imageByApplyingAlpha:1];
    bg = [bg imageByRoundCornerRadius:r];
    bg = [bg resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    hbg = [[hbg imageByRoundCornerRadius:r] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [self setBackgroundImage:bg forState:UIControlStateNormal];
    [self setBackgroundImage:hbg forState:UIControlStateHighlighted];
    [self makeCorner:r];
    [self setTitle:title forState:UIControlStateNormal];
}

@end
