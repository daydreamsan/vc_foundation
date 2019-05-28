//
//  NSArray+WCExtention.m
//  vci
//
//  Created by 齐江涛 on 2017/11/14.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import "NSArray+WCExtention.h"

@implementation NSArray (WCExtention)

- (BOOL)isNull {
    return [self isKindOfClass:[NSNull class]];
}
- (BOOL)isNil {
    if (self.isNull) {
        return YES;
    }
    return self.count == 0;
}

@end
