//
//  WCSegment.m
//  vci
//
//  Created by 齐江涛 on 2017/11/2.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import "WCSegment.h"
#import "VCFKFoundation.h"

static NSInteger kWCSegmentBaseTag = 1000;

@interface WCSegment ()

@property (nonatomic, strong) NSArray<UIButton *> *items;
@property (nonatomic, strong) NSArray<UIView *> *lines;
@property (nonatomic, copy) NSArray<NSString *> *titles;
@property (nonatomic, assign) NSInteger currentIdx;

@end

@implementation WCSegment

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles selectedIndex:(NSInteger)idx {
    if (self = [super initWithFrame:frame]) {
        self.titles = titles;
        self.currentIdx = idx;
        [self setupUI];
        [self highlightButton:self.items[idx]];
    }
    return self;
}

- (void)setupUI {
    NSMutableArray *tmp = @[].mutableCopy;
    NSMutableArray *tmpLines = @[].mutableCopy;
    for (NSInteger i = 0; i < self.titles.count; i++) {
        NSString *title = self.titles[i];
        UIButton *btn = [self buttonWithTitle:title tag:kWCSegmentBaseTag + i];
        [tmp addObject:btn];
        [self addSubview:btn];
        
        if (i != self.titles.count - 1) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 3, 1.f, 1)];
            line.backgroundColor = kBackgroundColor;
            [tmpLines addObject:line];
            [self addSubview:line];
        }
    }
    self.items = tmp;
    self.lines = tmpLines;
}

- (UIButton *)buttonWithTitle:(NSString *)title tag:(NSInteger)tag {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.tag = tag;
    @weakify(self)
    [btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {
        @strongify(self)
        [self highlightButton:sender];
        NSInteger idx = sender.tag - kWCSegmentBaseTag;
        _selectedIndex = idx;
        if (WCOBJCanRespondsToSelector(self.delegate, @selector(segment:didClickIndex:))) {
            [self.delegate segment:self didClickIndex:idx];
        }
    }];
    return btn;
}

- (void)layout {
    CGFloat width = self.width / self.titles.count;
    for (NSInteger i = 0; i < self.titles.count; i++) {
        UIButton *btn = self.items[i];
        btn.frame = CGRectMake(width * i, 0, width, self.height);
        
        if (i != self.titles.count - 1) {
            UIView *line = self.lines[i];
            line.frame = CGRectMake((i + 1) * width, 2, 1, self.height - 4);
            [self bringSubviewToFront:line];
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layout];
}

- (void)highlightButton:(UIButton *)btn {
    for (UIButton *btn in self.items) {
        [btn setTitleColor:RGB_A(0x2b2b2b, 1.) forState:UIControlStateNormal];
    }
    [btn setTitleColor:kMainTintColor forState:UIControlStateNormal];
}

@end

