//
//  AESCyanUtil.h
//  AesCyan
//
//  Created by cyan on 2017/5/16.
//  Copyright © 2017年 cyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AESCyanUtil : NSObject
//加密
+ (NSString*) AES128Encrypt:(NSString *)plainText;
//解密
+ (NSString*) AES128Decrypt:(NSString *)encryptText;
@end
