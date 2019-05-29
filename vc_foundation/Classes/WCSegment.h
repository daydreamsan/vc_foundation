//
//  WCSegment.h
//  vci
//
//  Created by 齐江涛 on 2017/11/2.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WCSegment;
@protocol WCSegmentDelegate <NSObject>

- (void)segment:(WCSegment *)segment didClickIndex:(NSInteger)idx;

@end

@interface WCSegment : UIView

@property (nonatomic, assign, readonly) NSInteger selectedIndex;
@property (nonatomic, weak) id <WCSegmentDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles selectedIndex:(NSInteger)idx;

@end
