//
//  SVProgressHUD+WCExtention.m
//  WCJunior
//
//  Created by 齐江涛 on 2017/4/7.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import "SVProgressHUD+WCExtention.h"

#define WCSV(...)     \
[SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark]; \
[SVProgressHUD setMinimumSize:CGSizeMake(120, 120)]; \
[SVProgressHUD setCornerRadius:8]; \
[SVProgressHUD setRingThickness:2]; \
[SVProgressHUD setRingRadius:30];   \
[SVProgressHUD setMinimumDismissTimeInterval:.7f]; \
__VA_ARGS__

@implementation SVProgressHUD (WCExtention)

+ (void)showError:(NSString *)errorMsg {
    WCSV([SVProgressHUD showErrorWithStatus:errorMsg]);
}

+ (void)showSuccess:(NSString *)success {
    WCSV([SVProgressHUD showSuccessWithStatus:success];);
}

+ (void)showMessage:(NSString *)msg {
    WCSV([SVProgressHUD showWithStatus:msg]);
}

+ (void)showStatus:(NSString *)status {
    WCSV([SVProgressHUD showWithStatus:status]);
}

+ (void)showInfo:(NSString *)info {
    WCSV([SVProgressHUD showInfoWithStatus:info]);
}


@end
