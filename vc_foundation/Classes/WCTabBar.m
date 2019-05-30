//
//  WCTabBar.m
//  vci
//
//  Created by 齐江涛 on 2017/11/6.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import "WCTabBar.h"

static NSInteger kWCTabBarBaseTag = 10000;
@interface WCTabBar ()

@property (nonatomic, strong) UIImageView *indicator;
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, assign) NSInteger preIdx;
@property (nonatomic, strong) NSMutableArray<UIButton *> *items;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation WCTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.items = @[].mutableCopy;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    self.indicator = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50.f, 3.f)];
    [self.indicator makeCorner:1.5];
    self.indicator.backgroundColor = kMainTintColor;
    [self addSubview:self.indicator];
//    self.gradientLayer = [CAGradientLayer layer];
//    id clearColor = (__bridge id)[RGB_A(0XFFFFFF, 0) CGColor];
//    id whiteColor = (__bridge id)[RGB_A(0x0, 0.04) CGColor];
//    self.gradientLayer.colors = @[clearColor, whiteColor];
//    self.gradientLayer.locations = @[@0.3, @0.6];
//    self.gradientLayer.startPoint = CGPointMake(0, 0);
//    self.gradientLayer.endPoint = CGPointMake(0, 1);
//    [self.layer addSublayer:self.gradientLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.width / self.items.count;
    CGFloat height = self.height;
    [self.items enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL *stop) {
        obj.frame = CGRectMake(width * (idx), 0, width, height);
    }];
    self.indicator.bottom = self.height;
    self.indicator.centerX = self.width / 2.f / self.items.count * (self.preIdx * 2 + 1);
    [self bringSubviewToFront:self.indicator];
    self.gradientLayer.frame = CGRectMake(0, self.height - 5, self.width, 5);
}

#pragma mark - API
- (void)setTitles:(NSArray<NSString *> *)titles {
    self.datas = titles;
    [self.items makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.items removeAllObjects];
    for (NSInteger idx = 0; idx < titles.count; idx++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = kWCTabBarBaseTag + idx;
        btn.titleLabel.font = kSystemFontOfSize(18);
        if (idx == self.preIdx) {
            [btn setTitleColor:kMainTintColor forState:UIControlStateNormal];
        } else {
            [btn setTitleColor:RGB_A(0x2b2b2b, 1.f) forState:UIControlStateNormal];
        }
        [btn setTitle:titles[idx] forState:UIControlStateNormal];
        @weakify(self)
        [btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton * sender) {
            @strongify(self)
            NSInteger index = sender.tag - kWCTabBarBaseTag;
            _selectedIndex = index;
            if (WCOBJCanRespondsToSelector(self.delegate, @selector(tabBar:didSelectIndex:))) {
                [self.delegate tabBar:self didSelectIndex:index];
            }
            UIButton *pbtn = [self.items objectAtIndex:self.preIdx];
            [pbtn setTitleColor:RGB_A(0x2b2b2b, 1.f) forState:UIControlStateNormal];
            [sender setTitleColor:kMainTintColor forState:UIControlStateNormal];
            self.indicator.centerX = self.width / 2.f / self.items.count * (index * 2 + 1);
            self.preIdx = index;
        }];
        [self.items addObject:btn];
        [self addSubview:btn];
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    if (self.preIdx < self.items.count) {
        UIButton *pbtn = [self.items objectAtIndex:self.preIdx];
        [pbtn setTitleColor:RGB_A(0x2b2b2b, 1.f) forState:UIControlStateNormal];
    }
    UIButton *cbtn = [self.items objectAtIndex:selectedIndex];
    [cbtn setTitleColor:kMainTintColor forState:UIControlStateNormal];
    self.indicator.centerX = self.width / 2.f / self.items.count * (selectedIndex * 2 + 1);
    self.preIdx = selectedIndex;
}

@end
