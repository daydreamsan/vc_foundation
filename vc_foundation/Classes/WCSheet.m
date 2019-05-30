//
//  WCSheet.m
//  wc_comp_rj_bsd_wy_yl
//
//  Created by 齐江涛 on 2017/6/14.
//  Copyright © 2017年 Daydream. All rights reserved.
//

#import "WCSheet.h"
#import "VCFKFoundation.h"

@interface WCSheet()

/**
 用于背景
 */
@property (nonatomic, strong) UIView *bgView;

/**
 内容容器
 */
@property (nonatomic, strong) UIView *contentView;

/**
 用于取消
 */
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, weak) UIView *keyView;

@end

@implementation WCSheet

- (instancetype)initWithContentView:(UIView *)con {
    if (self = [super initWithFrame:CGRectZero]) {
        [self setupUI];
        self.keyView = con;
        [_contentView addSubview:con];
    }
    return self;
}

- (void)setupUI {
     
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWCScreenWidth, kWCScreenHeight)];
    self.bgView.backgroundColor = self.bgColor?:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3f];
    self.bgView.alpha = 0.f;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.bgView addGestureRecognizer:tap];
    _contentView = [UIView new];
    self.contentView.frame = CGRectMake(0, 0, kWCScreenWidth, kWCScreenHeight);
    [self addSubview:self.contentView];
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelButton setTitle:@"取    消" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(didClickCancel:) forControlEvents:UIControlEventTouchUpInside];
    self.cancelButton.backgroundColor = RGB_A(0xffffff, 1.f);
    self.cancelButton.frame = CGRectMake(0, 0, kWCScreenWidth, kWCCancelButtonHeight);
    [self.contentView addSubview:self.cancelButton];
}

- (void)showIn:(UIView *)zView {
    CGFloat sHeight = (self.keyView.height) > (zView.height - kWCCancelButtonHeight - kWCTopMargin) ? zView.height * kWCContentRadio : self.keyView.height;
    self.frame = CGRectMake(0, kWCScreenHeight - kWCCancelButtonHeight - kWCCancelButtonTop - kWCTopMargin - sHeight, kWCScreenWidth, sHeight + kWCCancelButtonHeight + kWCCancelButtonTop + kWCTopMargin);
    self.contentView.frame = self.bounds;
    self.keyView.frame = CGRectMake((kWCScreenWidth - self.keyView.width) / 2.f, kWCTopMargin, self.keyView.width, sHeight);
    self.cancelButton.frame = CGRectMake(0, self.contentView.height - kWCCancelButtonHeight, kWCScreenWidth, kWCCancelButtonHeight);
    if (self.titleForCancel.length) {
        [self.cancelButton setTitle:self.titleForCancel forState:UIControlStateNormal];
    }
    
    [zView addSubview:self.bgView];
    [zView addSubview:self];
    self.top = zView.bottom;
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.alpha = 1.f;
        self.bottom = zView.bottom;
    }];
}

- (void)dismiss {
    [self dismissWithCompletionHandler:nil];
}

- (void)dismissWithCompletionHandler:(void(^)(void))handler {
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.alpha = 0.2f;
        self.top = kWCScreenHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.bgView removeFromSuperview];
        if (handler) {
            handler();
        }
    }];
}

#pragma mark - Action
- (void)didClickCancel:(UIButton *)sender {
    if (self.cancelCallbackBlock) {
        self.cancelCallbackBlock();
    } else {
        [self dismiss];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self bringSubviewToFront:self.contentView];
}

/**
 * 获取变换的旋转角度
 *
 * @return 角度
 */
- (CGAffineTransform)getTransformRotationAngle {
    // 状态条的方向已经设置过,所以这个就是你想要旋转的方向
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    // 根据要进行旋转的方向来计算旋转的角度
    if (orientation == UIInterfaceOrientationPortrait) {
        return CGAffineTransformIdentity;
    } else if (orientation == UIInterfaceOrientationLandscapeLeft){
        return CGAffineTransformMakeRotation(-M_PI_2);
    } else if(orientation == UIInterfaceOrientationLandscapeRight){
        return CGAffineTransformMakeRotation(M_PI_2);
    }
    return CGAffineTransformIdentity;
}

@end
