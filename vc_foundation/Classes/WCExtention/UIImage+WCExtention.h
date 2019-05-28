//
//  UIImage+WCExtention.h
//  WCJunior
//
//  Created by 齐江涛 on 2017/4/6.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WCExtention)

- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;

- (UIImage *)imageWithTintColor:(UIColor *)tintColor;

- (UIImage *)imageByClipedByRect:(CGRect)rect;

- (UIImage *)imageWithRoundedCornerRadius:(CGFloat)radius;

- (UIImage *)imageWithSize:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)resizableColorImage:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius;

+ (UIImage *)circularImageWithSideLength:(CGFloat)length color:(UIColor *)color borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

+ (UIImage *)resizableImageWithImageName:(NSString *)imageName;

/**
 获取图片的主色
 
 @param img 目标图片
 @return 主色
 */
+ (UIColor *)dominatHueForImage:(UIImage *)img;

@end
