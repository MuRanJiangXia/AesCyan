//
//  ViewController.m
//  AesCyan
//
//  Created by cyan on 2017/5/16.
//  Copyright © 2017年 cyan. All rights reserved.
//

#import "ViewController.h"
#import "AESCyanUtil.h"
#import "SBJSON.h"
#import "CYJson.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


//    [self jsonPlay];
    [self  cyanJsonPlay];
//    [self SBJsonPlay];
 
    
}

-(void)cyanJsonPlay{
    
    //系统json 封装
    //1、创建一个NSDictionary
    NSDictionary *dict = @{
                           @"Name":@"LitterL\n",
                           @"Age":@"20"
                           };
    
    NSString *jsonStr = [CYJson jsonByObject:dict];
    //加密
    NSString *finalStr = [AESCyanUtil AES128Encrypt:jsonStr];
    
    //解密
    NSString *decrypt = [AESCyanUtil AES128Decrypt:finalStr];
    
    //转换前 需要去掉 转义字符
    NSString *newStr = [CYJson stringRemoveEscapeCharacter:decrypt];
    NSDictionary *dic = [CYJson objectByJson:newStr];
    
    NSLog(@"dic : %@",dic);
}
-(void)SBJsonPlay{
    
    //    NSString *mineStr = @"6JiELafWuzWNTZ2b0hXDbf5Uej8X7raeqLkvA8o67ep61QvSn9OMc0VXkJqeHgVhVYAThgWmfKPYQwFeKqosr4Ex9ICDRow51jeMbHtotDetrBhWdCT9pIlJ0Fazzl1saWcAVxoU+cgPtm1yTFwb+XiE5nh/Ya3rAEhSNDaMqe6O76GWj+FDt/hmRnjCvfIGBrkm4JX3U6u3kG3T1BsyILb6k8HMa6sPfpCqHfRufUjOxPVhTZrtu5zSSkLMwnmtl79uBW9zm6D2zgcG7ExCwwTmUGqxuoBvaGJnWjLepbU9vFBxuukPQu1N7SgJ9VFJ+dGXfNdFvYGQ8M75mOLPhA==";
    
    
    NSString *mineStr = @"DscigcvtOtouWA0jsTkMtmGz4fOp7HbZjGwFSCZD/+E=";
    
    //解密
    NSString *decrypt = [AESCyanUtil AES128Decrypt:mineStr];
    
    SBJsonParser *parser = [[SBJsonParser alloc]init];
    
    NSDictionary *dic =  [parser objectWithString:decrypt];
    NSLog(@"解密后的 dic : %@",dic);
    
    //加密
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    //
    NSString *json = [writer stringWithObject:dic];
    
    NSString *finalStr = [AESCyanUtil AES128Encrypt:json];
    
    NSLog(@"加密后的 finalStr : %@",finalStr);
}


//系统方法 转换json
-(void)jsonPlay{
    
    //1、创建一个NSDictionary
    NSDictionary *dict = @{
                           @"Name":@"LitterL\n",
                           @"Age":@"20"
                           };
    
    //
    NSData *data =  [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:nil];
    //打印JSON数据
    NSString *jsonStr =  [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //加密
    NSString *finalStr = [AESCyanUtil AES128Encrypt:jsonStr];
    
    //解密
    NSString *decrypt = [AESCyanUtil AES128Decrypt:finalStr];
    //去掉转义字符
    NSString * str2 = [decrypt stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    str2 = [str2 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str2 = [str2 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    str2 = [str2 stringByReplacingOccurrencesOfString:@"\0" withString:@""];
    str2 = [str2 stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    NSData *jsonData= [str2 dataUsingEncoding:NSASCIIStringEncoding];
    NSError *error = nil;
    NSDictionary *dic =   [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    
    NSLog(@"dic : %@ , error : %@",dic,error);
}

// 将JSON串转化为字典或者数组
- (id)toArrayOrNSDictionary:(NSData *)jsonData{
    
    NSError *error = nil;
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                     
                                                    options:NSJSONReadingAllowFragments
                     
                                                      error:&error];
    
    if (jsonObject != nil && error == nil) {
        
        return jsonObject;
        
    } else {
        
        // 解析错误
        
        return nil;
        
    }
    
}
// 将字典或者数组转化为JSON串
- (NSData *)toJSONData:(id)theData{
    
    NSError *error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                        
                                                       options:NSJSONWritingPrettyPrinted
                        
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        
        return jsonData;
        
    }else{
        
        return nil;
        
    }
    
}



@end
