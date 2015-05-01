//
//  UIImage+jLLScale.h
//  JiuLingLing
//
//  Created by tofu_jelly on 14-9-29.
//  Copyright (c) 2014年 对酒当歌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (jLLScale)
//按比例截取图片
-(UIImage*)jLLSubImageWithRect:(CGRect)rect;
@end
