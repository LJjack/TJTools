//
//  CYSha1.h
//  jiulingling
//
//  Created by tofu_jelly on 14-9-18.
//  Copyright (c) 2014年 对酒当歌. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CYEncrypt : NSObject

//获取时间
+(NSString *) CYGetDateWithString;

//sha1 加密
+(NSString *) sha1:(NSString *)input;

//md5
+(NSString *)md5:(NSString *)input;

//生成随机整数
+(int) CYGetRandomNum;

@end
