//
//  WCTopTabBar.m
//  wc_composite_bsd_yl_wy
//
//  Created by 齐江涛 on 17/2/28.
//  Copyright © 2017年 Daydream. All rights reserved.
//

#import "WCTopTabBar.h"
#import "VCFKFoundation.h"

@implementation WCTopTabBar

- (void)awakeFromNib {
    [super awakeFromNib];
    [self reset];
    [self didClickedAtIndex:0];
}

+ (instancetype)tabBar {
    return [[NSBundle mainBundle] loadNibNamed:kClassName(self) owner:nil options:nil].lastObject;
}

#pragma mark - Action
- (IBAction)teachBtnDidClicked:(UIButton *)sender {
    [self didClickedAtIndex:0];
}

- (IBAction)letterBtnDidClicked:(UIButton *)sender {
    [self didClickedAtIndex:1];
}

- (IBAction)levelBtnDidClicked:(UIButton *)sender {
    [self didClickedAtIndex:2];
}

- (void)reset {
    self.teachIndicator.backgroundColor = self.letterIndicator.backgroundColor = self.levelIndicator.backgroundColor = [UIColor whiteColor];
    [self.teachMaterialBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.letterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.levelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (void)configUIWithIndex:(NSInteger)idx {
    if (idx == 0) {
        [self.teachMaterialBtn setTitleColor:kMainTintColor forState:UIControlStateNormal];
        self.teachIndicator.backgroundColor = kMainTintColor;
    } else if(idx == 1) {
        [self.letterBtn setTitleColor:kMainTintColor forState:UIControlStateNormal];
        self.letterIndicator.backgroundColor = kMainTintColor;
    } else if(idx == 2) {
        [self.levelBtn setTitleColor:kMainTintColor forState:UIControlStateNormal];
        self.levelIndicator.backgroundColor = kMainTintColor;
    }
}

- (void)didClickedAtIndex:(NSInteger)idx {
    [self reset];
    [self configUIWithIndex:idx];
    if (self.delegate && [self.delegate respondsToSelector:@selector(topTabBar:didClickIndex:)]) {
        [self.delegate topTabBar:self didClickIndex:idx];
    }
}

- (void)setTitles:(NSArray<NSString *> *)titles {
    NSArray *btns = @[self.teachMaterialBtn, self.letterBtn, self.levelBtn];
    for (NSInteger i = 0; i < titles.count; i++) {
        NSString *title = titles[i];
        UIButton *btn = btns[i];
        [btn setTitle:title forState:UIControlStateNormal];
    }
}

@end
