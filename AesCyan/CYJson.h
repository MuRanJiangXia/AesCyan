//
//  CYJson.h
//  AesCyan
//
//  Created by cyan on 2017/5/18.
//  Copyright © 2017年 cyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYJson : NSObject
/**数组字典 转成 json*/
+(NSString *)jsonByObject:(id)object;

/**json 转成 数组字典*/
+(id)objectByJson:(NSString *)json;

/**去掉转义字符(加密会出现转义字符)*/
+(NSString *)stringRemoveEscapeCharacter:(NSString *)decrypt;

@end
