//
//  WCVerticalButton.h
//  ZDClock
//
//  Created by Sea on 15/7/9.
//  Copyright (c) 2015年 ZDworks Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCFKFoundation.h"

IB_DESIGNABLE
@interface WCVerticalButton : UIControl

@property (nonatomic, strong) IBInspectable UIImage *icon;
@property (nonatomic, strong) IBInspectable UIImage *highlightedIcon;
@property (nonatomic, copy) IBInspectable NSString *title;
@property (nonatomic, strong) IBInspectable UIColor *titleColor;
@property (nonatomic, strong) IBInspectable UIFont *titleFont;
@property (nonatomic, strong) IBInspectable UIColor *highlightedTitleColor;
@property (nonatomic) IBInspectable CGSize cornerSize;
@property(nonatomic,getter=isHighlighted) IBInspectable BOOL highlighted;
@property (nonatomic, getter=isEnabled) IBInspectable BOOL enabled;

@end
