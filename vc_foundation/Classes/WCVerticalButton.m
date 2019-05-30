//
//  WCVerticalButton.m
//  ZDClock
//
//  Created by Sea on 15/7/9.
//  Copyright (c) 2015年 ZDworks Co., Ltd. All rights reserved.
//

#import "WCVerticalButton.h"

@interface WCVerticalButton ()

@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSMutableDictionary *titleColorForState;
@property (nonatomic, strong) NSMutableDictionary *imageForState;
@property (nonatomic) IBInspectable CGFloat verticalInterval;
@property (nonatomic, weak) NSLayoutConstraint *topConstraint;
@property (nonatomic, weak) NSLayoutConstraint *bottomConstraint;

@end

@implementation WCVerticalButton

@dynamic icon, title, highlighted, enabled;

- (UIImageView *)iconImage
{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] init];
        [self addSubview:_iconImage];
        
        [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.mas_centerY).offset(4);
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(@(self.cornerSize.height));
        }];
    }
    return _iconImage;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = self.titleFont ?: kSystemFontOfSize(12.5);
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_bottom).offset(self.cornerSize.height);
//            make.top.equalTo(self.mas_centerY).offset(8);
        }];
    }
    return _titleLabel;
}

- (CGSize)intrinsicContentSize
{
    CGSize iconSize = self.iconImage.image.size;
    CGSize titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    return CGSizeMake(MAX(iconSize.width, titleSize.width) + self.cornerSize.width * 2, iconSize.height + titleSize.height + self.cornerSize.height * 2 + self.verticalInterval);
}

- (void)setHighlighted:(BOOL)highlighted
{
    if (self.iconImage.highlightedImage) {
        self.iconImage.highlighted = self.titleLabel.highlighted = super.highlighted = highlighted;
    } else {
//        self.alpha = highlighted ? 0.7 : 1;
    }
}

- (void)setIcon:(UIImage *)icon
{
    self.iconImage.image = icon;
}

- (UIImage *)icon
{
    return self.iconImage.image;
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)setHighlightedIcon:(UIImage *)highlightedIcon
{
    self.iconImage.highlightedImage = highlightedIcon;
}

- (UIImage *)highlightedIcon
{
    return self.iconImage.highlightedImage;
}

- (NSString *)title
{
    return self.titleLabel.text;
}

- (void)setHighlightedTitleColor:(UIColor *)highlightedTitleColor
{
    self.titleLabel.highlightedTextColor = highlightedTitleColor;
}

- (UIColor *)highlightedTitleColor
{
    return self.titleLabel.highlightedTextColor;
}

- (void)setTitleColor:(UIColor *)titleColor
{
    self.titleLabel.textColor = titleColor;
}

- (UIColor *)titleColor
{
    return self.titleLabel.textColor;
}

- (void)setCornerSize:(CGSize)cornerSize
{
    _cornerSize = cornerSize;
}

- (void)setEnabled:(BOOL)enabled
{
    super.enabled = enabled;
    self.highlighted = !enabled;
}

- (void)setValue:(id)value forKeyPath:(NSString *)keyPath
{
    [super setValue:value forKeyPath:keyPath];
}

- (void)sizeToFit {
    [super sizeToFit];
    [self.iconImage sizeToFit];
    [self.titleLabel sizeToFit];
    CGFloat maxWidth = MAX(self.iconImage.width, self.titleLabel.width);
    maxWidth += 8 * 2.f;
    CGFloat maxHeight = self.iconImage.height + self.titleLabel.height + 4.f + 8.f + 4.f;
    self.size = CGSizeMake(maxWidth, maxHeight);
}

@end
