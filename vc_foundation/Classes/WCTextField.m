//
//  WCTextField.m
//  vci
//
//  Created by 齐江涛 on 2017/10/18.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import "WCTextField.h"

@implementation WCTextField

- (CGRect)textRectForBounds:(CGRect)bounds {
//    CGRect rect = [super textRectForBounds:bounds];
    return CGRectInset(bounds, 3, 0);
}
- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    CGRect rect = [super placeholderRectForBounds:bounds];
    return CGRectInset(rect, 3, 0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 3, 0);
}

@end
