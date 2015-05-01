//
//  NSString+Ext.m
//  JiuLingLing
//
//  Created by tofu_jelly on 14/11/5.
//  Copyright (c) 2014年 对酒当歌. All rights reserved.
//

#import "NSString+Ext.h"

@implementation NSString(Ext)

/**
 *  格式化时间戳
 */
+(NSString *)dateToStringWithFormate:(NSUInteger)timestamp dateFormatter:(NSString *)formatter{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:formatter];
    //    [df setTimeStyle:NSDateFormatterShortStyle];
    //    [df setDateStyle:NSDateFormatterFullStyle];
    
    //    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [df setLocale:[NSLocale currentLocale]];
    //    NSString *dateString = [NSString stringWithFormat:@"%@",[NSDate dateWithTimeIntervalSince1970:unixTimestamp]];
    //    NSDate *date = [df dateFromString:dateString];
    NSString *dateStr = [df stringFromDate:[NSDate dateWithTimeIntervalSince1970:timestamp]];
    
    return dateStr;
}
@end
