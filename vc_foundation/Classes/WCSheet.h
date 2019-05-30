//
//  WCSheet.h
//  wc_comp_rj_bsd_wy_yl
//
//  Created by 齐江涛 on 2017/6/14.
//  Copyright © 2017年 Daydream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCFKFoundation.h"

#define kWCScreenWidth      ([UIScreen mainScreen].bounds.size.width)
#define kWCScreenHeight     ([UIScreen mainScreen].bounds.size.height)
#define kWCContentRadio     (0.5f)
#define kWCCancelButtonHeight   (50.f)
#define kWCCancelButtonTop      (-1.f)
#define kWCTopMargin            (10.f)

@interface WCSheet : UIToolbar
{
    @protected
    UIView *_contentView;
    __weak UIView *_keyView;
}
@property (nonatomic, strong, readonly) UIView *contentView;
@property (nonatomic, weak,   readonly) UIView *keyView;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, copy  ) NSString *titleForCancel;
@property (nonatomic, copy  ) void (^cancelCallbackBlock)(void);

- (instancetype)initWithContentView:(UIView *)contentView;
- (void)showIn:(UIView *)view;
- (void)dismiss;
- (void)dismissWithCompletionHandler:(void(^)(void))handler;

@end
