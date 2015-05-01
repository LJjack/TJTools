//
//  UIColor+Hex.h
//  jiulingling 
//
//  Created by tofu_jelly on 14-8-20.
//  Copyright (c) 2014年 对酒当歌. All rights reserved.
//
//  16进制转RGB,Color
//
//
#import <UIKit/UIKit.h>


/**
 *  16进制颜色扩展
 */

@interface UIColor (Hex)

+ (UIColor*)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;     //可设置alpha值的color
+ (UIColor*)colorWithHex:(NSInteger)hexValue;                                            //16进制转rgb
+ (UIColor*)whiteColorWithAlpha:(CGFloat)alphaValue;                                 //16进制白色
+ (UIColor*)blackColorWithAlpha:(CGFloat)alphaValue;                                 //16进制黑色

+(UIColor *) colorWithHexString: (NSString *) stringToConvert;                    //16进制String转rgb
@end
