//
//  NSData+WCExtention.h
//  WCJunior
//
//  Created by 齐江涛 on 2017/4/19.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (WCExtention)

/**
 *  AES-将string转成带密码的data
 */
+ (NSData*)encryptAESData:(NSString*)string withPublicKey:(NSString *)publicKey;
/**
 *  AES-将带密码的data转成string
 */
+ (NSString*)decryptAESData:(NSData*)data withPublicKey:(NSString *)publicKey;

@end
