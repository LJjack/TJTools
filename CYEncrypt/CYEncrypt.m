//
//  CYSha1.m
//  jiulingling
//
//  Created by tofu_jelly on 14-9-18.
//  Copyright (c) 2014年 对酒当歌. All rights reserved.
//

#import "CYEncrypt.h"
#import "CommonCrypto/CommonDigest.h"

@implementation CYEncrypt

#pragma mark - 获取时间 ep:2014-09-18
+(NSString *)CYGetDateWithString{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    //输出格式为：2010-10-27 10:22:13
//    NSLog(@"%@",currentDateStr);
    
    return currentDateStr;
}

#pragma mark - md5
+(NSString *)md5:(NSString *)input{
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return result;
}

#pragma mark - sha1加密
+(NSString *)sha1:(NSString *)input{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (uint32_t)data.length, digest);
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}

#pragma mark - 生成随机整数 [0 to 50)
+(int)CYGetRandomNum{
    return abs((int)arc4random() % 50);
}

@end
