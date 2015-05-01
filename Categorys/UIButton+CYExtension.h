//
//  UIButton+ImageWithTitle.h
//  ElephasWashCar
//
//  Created by tofujelly on 14/12/30.
//  Copyright (c) 2014年 tobe No.1. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  button点击回调
 */
typedef  void(^CYActionBlock)(UIButton* sender);

@interface UIButton (CYExtension)

/**
 *  图文同时存在，并且上下排列
 *
 *  @param image     图片
 *  @param title     标题
 *  @param stateType 状态
 */
- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType;

/**
 *  颜色转换成图片
 *
 *  @param color
 *
 *  @return image
 */
- (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  扩展button 点击回调函数
 */

-(void)addTargetWithBlock:(CYActionBlock)action forControlEvents:(UIControlEvents)controlEvents;


@end
