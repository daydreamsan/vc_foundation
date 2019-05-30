//
//  WCTabContainerViewController.m
//  vci
//
//  Created by 齐江涛 on 2017/11/6.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import "WCTabContainerViewController.h"
#import "WCTabBar.h"

@interface WCTabContainerViewController ()<WCTabBarDelegate>

@property (nonatomic, strong) WCTabBar *tabBar;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, assign) NSInteger numberOfChildViewController;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableDictionary *childVCDict;
@property (nonatomic, strong) NSMutableDictionary *childTitleDict;
@property (nonatomic, strong) NSArray<NSString *> *titles;

@end

@implementation WCTabContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _footerHeight = 90.f;
    [self setupUI];
    [self.tabBar setTitles:self.titles];
    [self makeChildControllerVisibleAtIndex:0];
}

#pragma mark - Getter
- (WCTabBar *)tabBar {
    if (_tabBar) {
        return _tabBar;
    }
    _tabBar = [[WCTabBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 55)];
    _tabBar.delegate = self;
    return _tabBar;
}
- (UIView *)contentView {
    if (_contentView) {
        return _contentView;
    }
    _contentView = [UIView new];
    return _contentView;
}
- (UIView *)footerView {
    if (_footerView) {
        return _footerView;
    }
    _footerView = [UIView new];
    _footerView.backgroundColor = [UIColor clearColor];
    return _footerView;
}
- (NSMutableDictionary *)childVCDict {
    if (_childVCDict) {
        return _childVCDict;
    }
    _childVCDict = @{}.mutableCopy;
    return _childVCDict;
}
- (NSMutableDictionary *)childTitleDict {
    if (_childTitleDict) {
        return _childTitleDict;
    }
    _childTitleDict = @{}.mutableCopy;
    return _childTitleDict;
}
#pragma mark - UI
- (void)setupUI {
    [self.view addSubview:self.tabBar];
    [self.tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(0);
        make.height.mas_equalTo(50);
    }];
    [self.view addSubview:self.footerView];
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(self.footerHeight);
    }];
    [self.view addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tabBar.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.footerView.mas_top);
    }];
}

#pragma mark - WCTabBarDelegate
- (void)tabBar:(WCTabBar *)tabBar didSelectIndex:(NSInteger)idx {
    [self makeChildControllerVisibleAtIndex:idx];
    if (WCOBJCanRespondsToSelector(self.delegate, @selector(tabContainerViewController:didSelectIndex:))) {
        [self.delegate tabContainerViewController:self didSelectIndex:idx];
    }
}

- (void)setFooterHeight:(CGFloat)footerHeight {
    _footerHeight = MAX(footerHeight, CGFLOAT_MIN);
    [self.footerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(footerHeight);
    }];
}
- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title {
    [self.childVCDict setObject:childController forKey:@(self.numberOfChildViewController)];
    [self addChildViewController:childController];
    [self.childTitleDict setObject:title forKey:@(self.numberOfChildViewController)];
    self.numberOfChildViewController++;
    NSArray<NSNumber *> *keys = [self.childTitleDict.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSNumber *  _Nonnull obj1, NSNumber *  _Nonnull obj2) {
        return obj1.integerValue > obj2.integerValue;
    }];
    NSMutableArray *titles = @[].mutableCopy;
    for (NSNumber *idx in keys) {
        [titles addObject:self.childTitleDict[idx]];
    }
    [self.tabBar setTitles:titles];
    self.titles = titles;
}
- (void)setChildViewControllers:(NSArray<UIViewController *> *)childControllers titles:(NSArray<NSString *> *)titles {
    NSAssert(childControllers.count == titles.count, @"Must be equal!!!");
    for (NSInteger i = 0; i < childControllers.count; i++) {
        UIViewController *vc = childControllers[i];
        [self.childVCDict setObject:vc forKey:@(i)];
        [self addChildViewController:vc];
        NSString *title = titles[i];
        [self.childTitleDict setObject:title forKey:@(i)];
    }
    [self.tabBar setTitles:titles];
    self.titles = titles;
}

- (void)setBarTitles:(NSArray<NSString *> *)titles; {
    self.titles = titles;
    [self.tabBar setTitles:titles];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    self.tabBar.selectedIndex = selectedIndex;
    [self makeChildControllerVisibleAtIndex:selectedIndex];
}

#pragma mark - Private
- (void)makeChildControllerVisibleAtIndex:(NSUInteger)index {
    UIViewController *vc = self.childVCDict[@(index)];
    UIView *v = [vc view];
    [self.contentView addSubview:v];
    [v mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [self.view bringSubviewToFront:v];
    _selectedIndex = index;
}

@end
