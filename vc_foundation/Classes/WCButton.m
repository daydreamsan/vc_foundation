//
//  WCButton.m
//  wclistening
//
//  Created by 齐江涛 on 2017/7/19.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import "WCButton.h"

#define kWCButtonMargin 5

@implementation WCButton

- (instancetype)initWithImageRatio:(CGFloat)ratio {
    if (self = [super init]) {
        _imageRatio = ratio;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initialize];
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
        [self initialize];
        
    }
    return self;
}

- (void)initialize {
    _imageRatio = 0.5;
    _imagePosition = SPButtonImagePositionDefault;
}

- (void)setHighlighted:(BOOL)highlighted {}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    if (!self.currentTitle) { // 如果没有文字，则图片占据整个button，空格算一个文字
        return [super imageRectForContentRect:contentRect];
    }
    switch (self.imagePosition) {
        case SPButtonImagePositionDefault:
        case SPButtonImagePositionLeft: {
            _imageRatio = _imageRatio == 0.0 ? 0.5 : _imageRatio;
            CGFloat imageW =  contentRect.size.width * _imageRatio;
            CGFloat imageH = contentRect.size.height;
            return CGRectMake(0, 0, imageW, imageH);
        }
            break;
        case SPButtonImagePositionTop: {
            _imageRatio = _imageRatio == 0.0 ? 2.0/3.0 : _imageRatio;
            CGFloat imageW = contentRect.size.width;
            CGFloat imageH = contentRect.size.height * _imageRatio;
            return CGRectMake(0, 0, imageW, imageH);
        }
            break;
        case SPButtonImagePositionRight: {
            _imageRatio = _imageRatio == 0.0 ? 0.5 : _imageRatio;
            CGFloat imageW =  contentRect.size.width * _imageRatio;
            CGFloat imageH = contentRect.size.height;
            CGFloat imageX = contentRect.size.width - imageW;
            return CGRectMake(imageX, 0, imageW, imageH);
        }
            break;
        case SPButtonImagePositionBottom: {
            _imageRatio = _imageRatio == 0.0 ? 2.0/3.0 : _imageRatio;
            CGFloat imageW =  contentRect.size.width;
            CGFloat imageH = contentRect.size.height * _imageRatio;
            CGFloat imageY = contentRect.size.height - imageH;
            return CGRectMake(0, imageY, imageW, imageH);
        }
            break;
        default:
            break;
    }
    return CGRectZero;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    if (!self.currentImage) {  // 如果没有图片
        return [super titleRectForContentRect:contentRect];
    }
    switch (self.imagePosition) {
        case SPButtonImagePositionDefault:
        case SPButtonImagePositionLeft: {
            _imageRatio = _imageRatio == 0.0 ? 0.5 : _imageRatio;
            CGFloat titleX = contentRect.size.width * _imageRatio;
            CGFloat titleW = contentRect.size.width - titleX;
            CGFloat titleH = contentRect.size.height;
            return CGRectMake(titleX, 0, titleW, titleH);
        }
            break;
        case SPButtonImagePositionTop: {
            _imageRatio = _imageRatio == 0.0 ? 2.0/3.0 : _imageRatio;
            CGFloat titleY = contentRect.size.height * _imageRatio;
            CGFloat titleW = contentRect.size.width;
            CGFloat titleH = contentRect.size.height - titleY;
            return CGRectMake(0, titleY, titleW, titleH);
        }
            break;
        case SPButtonImagePositionRight: {
            _imageRatio = _imageRatio == 0.0 ? 0.5 : _imageRatio;
            CGFloat titleW = contentRect.size.width * (1-_imageRatio);
            CGFloat titleH = contentRect.size.height;
            return CGRectMake(0, 0, titleW, titleH);
        }
            break;
        case SPButtonImagePositionBottom: {
            _imageRatio = _imageRatio == 0.0 ? 2.0/3.0 : _imageRatio;
            CGFloat titleW = contentRect.size.width;
            CGFloat titleH = contentRect.size.height * (1 - _imageRatio);
            return CGRectMake(0, 0, titleW, titleH);
        }
            break;
        default:
            break;
    }
    return CGRectZero;
    
}

- (void)setImagePosition:(SPButtonImagePosition)imagePosition {
    _imagePosition = imagePosition;
    switch (imagePosition) {
        case SPButtonImagePositionDefault:
        case SPButtonImagePositionLeft:
            self.imageView.contentMode = UIViewContentModeCenter;
            self.titleLabel.textAlignment = NSTextAlignmentLeft;
            break;
        case SPButtonImagePositionTop:
            
            self.imageView.contentMode = UIViewContentModeCenter;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            break;
        case SPButtonImagePositionRight:
            self.imageView.contentMode = UIViewContentModeCenter;
            self.titleLabel.textAlignment = NSTextAlignmentRight;
            break;
        case SPButtonImagePositionBottom:
            self.imageView.contentMode = UIViewContentModeCenter;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            break;
        default:
            break;
    }
    [self setNeedsDisplay];
}

- (void)setImageRatio:(CGFloat)imageRatio {
    _imageRatio = imageRatio;
    [self setNeedsDisplay];
}

@end
