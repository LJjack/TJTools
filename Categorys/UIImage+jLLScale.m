//
//  UIImage+jLLScale.m
//  JiuLingLing
//
//  Created by tofu_jelly on 14-9-29.
//  Copyright (c) 2014年 对酒当歌. All rights reserved.
//

#import "UIImage+jLLScale.h"

@implementation UIImage (jLLScale)

-(UIImage *)jLLSubImageWithRect:(CGRect)rect{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    
    
    UIGraphicsBeginImageContext(smallBounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawImage(context, smallBounds, subImageRef);
    
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    
    UIGraphicsEndImageContext();
    CGImageRelease(subImageRef);
    return smallImage;
}
@end
