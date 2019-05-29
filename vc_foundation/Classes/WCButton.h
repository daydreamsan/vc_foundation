//
//  WCButton.h
//  wclistening
//
//  Created by 齐江涛 on 2017/7/19.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SPButtonImagePosition) {
    SPButtonImagePositionDefault,   // 默认在左边
    SPButtonImagePositionLeft,      // 图片在左边
    SPButtonImagePositionTop,       // 图片在上面
    SPButtonImagePositionRight,     // 图片在右边
    SPButtonImagePositionBottom     // 图片在下面
};

@interface WCButton : UIButton

@property (nonatomic, assign) CGFloat imageRatio;
@property (nonatomic, assign) SPButtonImagePosition imagePosition;

- (instancetype)initWithImageRatio:(CGFloat)ratio;

@end
