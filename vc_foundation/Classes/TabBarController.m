 //
//  TabBarController.m
//  WCJunior
//
//  Created by 齐江涛 on 2017/4/6.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import "TabBarController.h"
#import "VCFKBase.h"

@interface TabBarController ()<UITabBarControllerDelegate>

@end

@implementation TabBarController

+ (void)initialize {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = RGB_A(0x4b4b4b, 1.f);
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = kMainTintColor;
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    [[UITabBar appearance] setTintColor:kMainTintColor];
}

- (void)dealloc {
    NSLog(@"%@ deallocing...", self);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.hidesBottomBarWhenPushed = YES;
    [self prepare];
}

#pragma mark - private
- (void)prepare {}

- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage wapper:(BOOL)wapper {
    UIImage *img1 = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    if (img1) {
        vc.tabBarItem.image = img1;
    }
    UIImage *img2 = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    if (img2) {
        vc.tabBarItem.selectedImage = img2;
    }
    if (title.length) {
        vc.tabBarItem.title = title;
    } else {
        vc.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    }
    
    if (wapper) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self addChildViewController:nav];
    } else {
        [self addChildViewController:vc];
    }
}

- (void)adjustCenterBarItem {}

#pragma mark - API
+ (UINavigationController *)currentNavigationController {
    UINavigationController *nav = (UINavigationController *)[self global].selectedViewController;
    return nav;
}

+ (TabBarController *)global {
    UIViewController *target = [UIApplication sharedApplication].delegate.window.rootViewController;
    if ([target isKindOfClass:[TabBarController class]]){
        return (TabBarController *)target;
    }
    return nil;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    //数据上报
}

- (void)badgeAt:(NSInteger)index show:(BOOL)isShow {
    NSArray *sub = self.tabBar.subviews;
    if (sub.count < index + 1) {
        return;
    }
    NSInteger cnt = wc_counts_of_barbuttons(self.tabBar);
    if (cnt < index + 1) {
        return;
    }
    id last = sub[index + 1];
    if ([last isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
        UIView *targetView = last;

        if (!isShow) {
            UIView *badge = [targetView viewWithTag:1000];
            badge.backgroundColor = [UIColor clearColor];
            [badge removeFromSuperview];
            return;
        }
        UIView *badge = [targetView viewWithTag:1000];
        if (!badge) {
            badge = [[UIView alloc] initWithFrame:CGRectMake(targetView.width * 3/5.0, 5, 10, 10)];
            badge.layer.masksToBounds = YES;
            badge.layer.cornerRadius = 5.f;
            badge.backgroundColor = [UIColor redColor];
            badge.tag = 1000;
            [last addSubview:badge];
        }
    }
}

__unused static inline int wc_counts_of_barbuttons(UIView *bar) {
    NSArray *subs = bar.subviews;
    int cnt = 0;
    for (UIView *v_ in subs) {
        if ([v_ isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            cnt++;
        }
    }
    return cnt;
}

@end
