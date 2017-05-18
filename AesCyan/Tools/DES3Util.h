//
//  DES3Util.h
//  ASEPlay2
//
//  Created by cyan on 16/11/25.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DES3Util : NSObject
+(NSData *)AES256ParmEncryptWithKey:(NSString *)key Encrypttext:(NSData *)text;   //加密
+(NSData *)AES256ParmDecryptWithKey:(NSString *)key Decrypttext:(NSData *)text;   //解密
+(NSString *) aes256_encrypt:(NSString *)key Encrypttext:(NSString *)text;
+(NSString *) aes256_decrypt:(NSString *)key Decrypttext:(NSString *)text;

@end
