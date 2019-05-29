//
//  SVProgressHUD+WCExtention.h
//  WCJunior
//
//  Created by 齐江涛 on 2017/4/7.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

@interface SVProgressHUD (WCExtention)

+ (void)showError:(NSString *)errorMsg;
+ (void)showSuccess:(NSString *)success;
+ (void)showMessage:(NSString *)msg;
+ (void)showStatus:(NSString *)status;
+ (void)showInfo:(NSString *)info;

@end
