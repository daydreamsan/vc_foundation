//
//  UINavigationController+WCExtention.h
//  wclistening
//
//  Created by 齐江涛 on 2017/7/3.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (WCExtention)

@property (nonatomic, assign) BOOL swipeBackEnabled;
@property (nonatomic, assign) BOOL lucency;

- (void)hiddenHairLine;
- (void)showHairLine;

@end

@interface UINavigationBar(QTExtention)

- (void)enableBackPattern;
- (void)disableBackPattern;

@end

