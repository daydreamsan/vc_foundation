//
//  UINavigationController+WCExtention.m
//  wclistening
//
//  Created by 齐江涛 on 2017/7/3.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import "UINavigationController+WCExtention.h"
#import <objc/runtime.h>
#import "../VCFKBase.h"
#import "UIView+WCExtention.h"
#import "UIImage+WCExtention.h"
#import "UIViewController+WCExtention.h"

void __swipeback_swizzle(Class cls, SEL originalSelector) {
    NSString *originalName = NSStringFromSelector(originalSelector);
    NSString *alternativeName = [NSString stringWithFormat:@"swizzled_%@", originalName];
    
    SEL alternativeSelector = NSSelectorFromString(alternativeName);
    
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    Method alternativeMethod = class_getInstanceMethod(cls, alternativeSelector);
    
    class_addMethod(cls,
                    originalSelector,
                    class_getMethodImplementation(cls, originalSelector),
                    method_getTypeEncoding(originalMethod));
    class_addMethod(cls,
                    alternativeSelector,
                    class_getMethodImplementation(cls, alternativeSelector),
                    method_getTypeEncoding(alternativeMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(cls, originalSelector),
                                   class_getInstanceMethod(cls, alternativeSelector));
}

@interface UINavigationController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *blurBackView;

@end

@implementation UINavigationController (WCExtention)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __swipeback_swizzle(self, @selector(viewDidLoad));
        __swipeback_swizzle(self, @selector(pushViewController:animated:));
    });
    
    NSMutableDictionary *titleTextAttributes = @{}.mutableCopy;
//    UIFont *font = [UIFont boldSystemFontOfSize:19];
//    [titleTextAttributes setObject:font forKey:NSFontAttributeName];
    [titleTextAttributes setObject:RGB_A(0x2b2b2b, 1) forKey:NSForegroundColorAttributeName];

    [[UINavigationBar appearance] setTitleTextAttributes:titleTextAttributes];
    [[UINavigationBar appearance] setTintColor:RGB_A(0X2B2B2B, 1.F)];
    {
        UIImage *img = [UIImage resizableColorImage:[UIColor whiteColor] cornerRadius:0];
        [[UINavigationBar appearance] setBackgroundImage:img forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [UINavigationBar appearance].translucent = YES;
        [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    }
}

- (void)swizzled_viewDidLoad {
    [self swizzled_viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self.swipeBackEnabled ? self : nil;
    [self setupBlurView];
}

- (void)swizzled_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [self swizzled_pushViewController:viewController animated:animated];
    self.interactivePopGestureRecognizer.enabled = NO;
}

#pragma mark - UIGestureRecognizerDelegate

/**
 * Prevent `interactiveGestureRecognizer` from canceling navigation button's touch event. (patch for #2)
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UIButton class]] && [touch.view isDescendantOfView:self.navigationBar]) {
        UIButton *button = (id)touch.view;
        button.highlighted = YES;
    }
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // patch for #3
    if (self.viewControllers.count <= 1 || !self.swipeBackEnabled) {
        return NO;
    }
    
    CGPoint location = [gestureRecognizer locationInView:self.navigationBar];
    UIView *view = [self.navigationBar hitTest:location withEvent:nil];
    
    if ([view isKindOfClass:[UIButton class]] && [view isDescendantOfView:self.navigationBar]) {
        UIButton *button = (id)view;
        button.highlighted = NO;
    }
    return YES;
}

#pragma mark - swipeBackEnabled
- (BOOL)swipeBackEnabled {
    NSNumber *enabled = objc_getAssociatedObject(self, @selector(swipeBackEnabled));
    if (enabled == nil) {
        return YES; // default value
    }
    return enabled.boolValue;
}

- (void)setSwipeBackEnabled:(BOOL)enabled {
    objc_setAssociatedObject(self, @selector(swipeBackEnabled), @(enabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    if([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }
    
    BOOL shouldPop = YES;
    UIViewController* vc = [self topViewController];
    if([vc respondsToSelector:@selector(shouldPop)]) {
        shouldPop = [vc shouldPop];
    }
    if(shouldPop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    } else {
        for(UIView *subview in [navigationBar subviews]) {
            if(0. < subview.alpha && subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
    }
    return NO;
}

#pragma mark - Private
- (UIImageView *)findHairlineViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)setupBlurView {
    NSArray *subviews = self.navigationBar.subviews;
    for (UIView *view in subviews) {
        if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
            
        }
    }
}

- (void)setLucency:(BOOL)lucency {
    objc_setAssociatedObject(self, @selector(lucency), @(lucency), OBJC_ASSOCIATION_ASSIGN);
    NSArray *subviews = self.navigationBar.subviews;
    for (UIView *view in subviews) {
        Class cls;
        if (kSystemVersion >= 10) {
            cls = NSClassFromString(@"_UIBarBackground");
        } else {
            cls = NSClassFromString(@"_UINavigationBarBackground");
        }
        if ([view isKindOfClass:cls]) {
            UIView *v = [view viewWithTag:2000];
            if (v) {
                
            } else {
                UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
                UIVisualEffectView *vcview = [[UIVisualEffectView alloc] initWithEffect:effect];
                vcview.frame = CGRectMake(0, 0, kScreenWidth, kSystemTopHeight);
                vcview.tag = 2000;
                CAGradientLayer *gradient = [CAGradientLayer layer];
                gradient.colors = @[(id)RGB_A(0xffffff, 0.5).CGColor, (id)RGB_A(0xffffff, 0.4).CGColor];
                gradient.frame = vcview.bounds;
                gradient.startPoint = CGPointMake(0.5, 0);
                gradient.endPoint = CGPointMake(0.5, 1);
                [vcview.layer addSublayer:gradient];
                v = vcview;
                [view addSubview:vcview];
            }
            v.hidden = lucency;
            break;
        }
    }
}

- (BOOL)lucency {
    NSNumber *obj = objc_getAssociatedObject(self, @selector(lucency));
    if (obj != nil) {
        return obj.boolValue;
    }
    [self setLucency:NO];
    return NO;
}

- (void)hiddenHairLine {
    UIImageView *imgv = [self findHairlineViewUnder:self.navigationBar];
    imgv.alpha = 0.1;
}
- (void)showHairLine {
    UIImageView *imgv = [self findHairlineViewUnder:self.navigationBar];
    imgv.alpha = 1;
}

@end


@implementation UINavigationBar(QTExtention)

- (void)enableBackPattern {
    [self findBackView:self enable:YES];
}
- (void)disableBackPattern {
    [self findBackView:self enable:NO];
}
- (void)findBackView:(UIView *)spview enable:(BOOL)enable{
    for (UIView *one in spview.subviews) {
        if ([one isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")] || [one isKindOfClass:NSClassFromString(@"_UIButtonBarButton")]) {
            if ([one isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")]) {
                one.alpha = enable ? 1 : 0.6;
                one.userInteractionEnabled = !enable;
            } else {
                UIButton *target = (UIButton *)one;
                target.alpha = enable ? 1 : 0.6;
                target.enabled = enable;
            }
            break;
        }
        if (one.subviews.count) {
            [self findBackView:one enable:enable];
        }
    }
}

@end

