//
//  NSString+Ext.h
//  JiuLingLing
//
//  Created by tofu_jelly on 14/11/5.
//  Copyright (c) 2014年 对酒当歌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString(Ext)

/**
 *  格式化时间戳
 */
+(NSString *)dateToStringWithFormate:(NSUInteger)timestamp dateFormatter:(NSString *)formatter;

@end
