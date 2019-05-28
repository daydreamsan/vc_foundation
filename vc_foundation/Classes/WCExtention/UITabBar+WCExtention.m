//
//  UITabBar+WCExtention.m
//  vcistudent
//
//  Created by 齐江涛 on 2018/11/20.
//  Copyright © 2018 daydream. All rights reserved.
//

#import "UITabBar+WCExtention.h"
#import <objc/runtime.h>
#import <YYKit/YYKit.h>

NS_INLINE BOOL
OverrideImplementation(Class targetClass, SEL targetSelector, id (^implementationBlock)(Class originClass, SEL originCMD, IMP originIMP)) {
    Method originMethod = class_getInstanceMethod(targetClass, targetSelector);
    if (!originMethod) {
        return NO;
    }
    IMP originIMP = method_getImplementation(originMethod);
    method_setImplementation(originMethod, imp_implementationWithBlock(implementationBlock(targetClass, targetSelector, originIMP)));
    return YES;
}

@implementation UITabBar (WCExtention)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 12.1, *)) {
            OverrideImplementation(NSClassFromString(@"UITabBarButton"), @selector(setFrame:), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP originIMP) {
                return ^(UIView *selfObject, CGRect firstArgv) {
                    if ([selfObject isKindOfClass:originClass]) {
                        if (!CGRectIsEmpty(selfObject.frame) && CGRectIsEmpty(firstArgv)) {
                            return;
                        }
                        if (!CGRectIsEmpty(selfObject.frame) && !CGRectIsEmpty(firstArgv)) {
                            if (selfObject.size.height - firstArgv.size.height > 4) {
                                return;
                            }
                        }
                    }
                    void (*originSelectorIMP)(id, SEL, CGRect);
                    originSelectorIMP = (void (*)(id, SEL, CGRect))originIMP;
                    originSelectorIMP(selfObject, originCMD, firstArgv);
                };
            });
        }
    });
}

@end
