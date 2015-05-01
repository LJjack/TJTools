//
//  UIAlertView+CYAlertView.h
//  ElephasWashCar
//
//  Created by tofujelly on 15/3/14.
//  Copyright (c) 2015年 tobe No.1. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CYAlertCallBack)(NSInteger buttonIndex);


/*!
 @brief 扩展UIAlertView 带block 回调
 */
@interface UIAlertView (CYAlert)<UIAlertViewDelegate>



/**
 *  一句代码就可以调出alertview
 *
 *  @param callback               回调
 *  @param title                  标题
 *  @param message                描述
 *  @param cancelButtonName       取消
 *  @param otherButtonTitles      其它
 */
+ (void)alertViewWithBlock:(CYAlertCallBack)callback title:(NSString *)title message:(NSString *)message  cancelButtonName:(NSString *)cancelButtonName otherButtonTitles:(NSString *)otherButtonTitles, ...;


@end
