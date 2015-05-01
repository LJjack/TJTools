//
//  BarItemButton.m
//  JiuLingLing
//
//  Created by tofu_jelly on 14/11/15.
//  Copyright (c) 2014年 对酒当歌. All rights reserved.
//

#import "BarItemButton.h"

@implementation BarItemButton
- (UIEdgeInsets)alignmentRectInsets
{
    
    UIEdgeInsets insets;
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        
    {
        if([self isLeftButton])
            insets = UIEdgeInsetsMake(0, 10, 0, 0);
        else
            insets = UIEdgeInsetsMake(0, 0, 0, 13);
    } else {
        insets = UIEdgeInsetsZero;
 
    }
    
    
    
    return insets;
    
}


- (BOOL)isLeftButton

{
    return self.frame.origin.x < (self.superview.frame.size.width / 2);
    
}

@end
