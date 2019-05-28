//
//  UIView+WCExtention.m
//  WCJunior
//
//  Created by 齐江涛 on 2017/4/6.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import "UIView+WCExtention.h"

@implementation UIView (WCExtention)

- (UIViewController *)currentController {
    id nextResponder = [self nextResponder];
    while (1) {
        if (nextResponder) {
            if ([nextResponder isKindOfClass:[UIViewController class]]) {
                return nextResponder;
            }
            nextResponder = [nextResponder nextResponder];
        }
        else{
            break;
        }
    }
    return nil;
}

- (void)makeCorner:(CGFloat)radius {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}

- (void)makeBorderWidth:(CGFloat)width color:(UIColor *)color {
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}
- (void)makeShadowWithColor:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity {
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;
}

@end
