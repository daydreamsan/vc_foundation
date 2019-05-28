//
//  UIImage+WCExtention.m
//  WCJunior
//
//  Created by 齐江涛 on 2017/4/6.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import "UIImage+WCExtention.h"

@implementation UIImage (WCExtention)

- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGContextDrawImage(ctx, area, self.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)imageWithTintColor:(UIColor *)tintColor {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [tintColor setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)imageByClipedByRect:(CGRect)rect {
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, self.scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -rect.size.height);
    CGContextSetAlpha(ctx, 1.f);
    CGContextDrawImage(ctx, rect, self.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)imageWithRoundedCornerRadius:(CGFloat)radius {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGRect bounds =CGRectMake(0, 0, self.size.width, self.size.height);
    [[UIBezierPath bezierPathWithRoundedRect:bounds
                                cornerRadius:radius] addClip];
    [self drawInRect:bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)imageWithSize:(CGSize)size {
    UIImage *target;
    CGSize itemSize = size;
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0);//*1
    CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
    [self drawInRect:imageRect];
    target = UIGraphicsGetImageFromCurrentImageContext();//*2
    UIGraphicsEndImageContext();//*3
    return target;
}

#pragma mark - Class Method
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)resizableColorImage:(UIColor *)color cornerRadius:(CGFloat)cornerRadius {
    return [[[UIImage imageWithColor:color size:CGSizeMake(1 + 2 * cornerRadius, 1 + 2 * cornerRadius)] imageWithRoundedCornerRadius:cornerRadius] resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius)];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius {
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, size.width, size.height);
    layer.cornerRadius = cornerRadius;
    if (borderWidth > DBL_EPSILON) {
        layer.borderWidth = borderWidth;
        layer.borderColor = [borderColor CGColor];
    }
    layer.masksToBounds = YES;
    layer.backgroundColor = [color CGColor];
    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)circularImageWithSideLength:(CGFloat)length color:(UIColor *)color borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    return [self imageWithColor:color size:CGSizeMake(length, length) borderWidth:borderWidth borderColor:borderColor cornerRadius:0.5 * length];
}

+ (UIImage *)resizableImageWithImageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat top = image.size.height * .5f;
    CGFloat bottom = image.size.height * .5f ;
    CGFloat left = image.size.width * .5f;
    CGFloat right = image.size.width * .5f;
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    return image;
}

+ (UIColor *)dominatHueForImage:(UIImage *)img {
    CGBitmapInfo bitmapinfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
    CGSize thumbsize = CGSizeMake(img.size.width/2, img.size.height/2);
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(NULL, thumbsize.width, thumbsize.height, 8, thumbsize.width * 4, colorspace, bitmapinfo);
    CGRect rect = (CGRect){0, 0, thumbsize};
    CGContextDrawImage(ctx, rect, img.CGImage);
    CGColorSpaceRelease(colorspace);
    u_char * data = CGBitmapContextGetData(ctx);
    if (!data) {
        return nil;
    }
    NSCountedSet *set = [NSCountedSet setWithCapacity:thumbsize.width * thumbsize.height];
    for (int x = 0; x < thumbsize.width; x++) {
        for (int y = 0; y < thumbsize.height; y++) {
            int offset = 4 * x * y;
            int r = data[offset];
            int g = data[offset + 1];
            int b = data[offset + 2];
            int alpha = data[offset + 3];
            if (alpha > 0) {
                if (r == 255 && g == 255 && b == 255) {
                    continue;
                }
                [set addObject:@[@(r), @(g), @(b), @(alpha)]];
            }
        }
    }
    CGContextRelease(ctx);
    NSEnumerator *enumerator = set.objectEnumerator;
    NSArray<NSNumber *> *currentcolor, *maxcolor;
    NSUInteger maxcount = 0;
    while (currentcolor = [enumerator nextObject]) {
        NSUInteger tmpcount = [set countForObject:currentcolor];
        if (tmpcount < maxcount) {
            continue;
        }
        maxcount = tmpcount;
        maxcolor = currentcolor;
    }
    UIColor *color = [UIColor colorWithRed:maxcolor[0].integerValue/255.f green:maxcolor[1].integerValue/255.f blue:maxcolor[2].integerValue/255.f alpha:maxcolor[3].integerValue/255.f];
    return color;
}

@end
