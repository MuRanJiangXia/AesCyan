//
//  CYJson.m
//  AesCyan
//
//  Created by cyan on 2017/5/18.
//  Copyright © 2017年 cyan. All rights reserved.
//

#import "CYJson.h"

@implementation CYJson

+(NSString *)jsonByObject:(id)object{
    NSError *error = nil;
    NSData *data =  [NSJSONSerialization dataWithJSONObject:object options:kNilOptions error:&error];
    //打印JSON数据
    NSString *jsonStr =  [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    if (error) {
        NSLog(@"error : %@",error);
    }
    return jsonStr;
}


+(id)objectByJson:(NSString *)json{

    NSData *jsonData= [json dataUsingEncoding:NSASCIIStringEncoding];
    NSError *error = nil;
    id object =   [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        
        NSLog(@"error : %@",error);
    }
    return object;
    
}


+(NSString *)stringRemoveEscapeCharacter:(NSString *)decrypt{
    
    //去掉转义字符
    NSString * newStr = [decrypt stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"\0" withString:@""];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    return newStr;
}
@end
