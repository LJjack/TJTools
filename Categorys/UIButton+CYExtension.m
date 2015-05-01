//
//  UIButton+ImageWithTitle.m
//  ElephasWashCar
//
//  Created by tofujelly on 14/12/30.
//  Copyright (c) 2014年 tobe No.1. All rights reserved.
//

#import "UIButton+CYExtension.h"
#import <objc/runtime.h>
#import "UIColor+Hex.h"
#define kOptionFont [UIFont systemFontOfSize:17.f]
#define kMainColor [UIColor colorWithHex:0x342937 alpha:0.95]
NSString *const targetBlock = @"CYButtonBlock";

@implementation UIButton (CYExtension)

-(void)setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType{
    
//    CGSize titleSize = [title sizeWithFont:kOptionFont];
    CGSize titleSize = [title boundingRectWithSize:CGSizeMake(80, 80) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kOptionFont} context:nil].size;
    [self.imageView setContentMode:UIViewContentModeCenter];
    [self setImageEdgeInsets:UIEdgeInsetsMake(-30.0,
                                              0.0,
                                              0.0,
                                              -titleSize.width)];
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:kOptionFont];
    [self.titleLabel setTextColor:kMainColor];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(70.0,
                                              -image.size.width,
                                              0.0,
                                              0.0)];
    [self setTitle:title forState:stateType];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = self.bounds;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



- (void)addTargetWithBlock:(CYActionBlock)action forControlEvents:(UIControlEvents)controlEvents{
    
    objc_setAssociatedObject(self, (__bridge const void *)(targetBlock), action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self addTarget:self action:@selector(handleEvent) forControlEvents:controlEvents];
}

- (void)handleEvent{
    CYActionBlock block = objc_getAssociatedObject(self,(__bridge const void *)(targetBlock) );
    block(self);
}

@end
