//
//  UIView+Extension.h
//  Categorys
//
//  Created by KWAME on 14-9-22.
//  Copyright (c) 2014年 sxw. All rights reserved.
//

#import <UIKit/UIKit.h>
/*!
 *  @brief UIView扩展，简化代码
 */
@interface UIView (Extension)
@property (nonatomic,assign) CGFloat x ;

@property (nonatomic,assign) CGFloat y ;

@property (nonatomic,assign) CGFloat width ;

@property (nonatomic,assign) CGFloat height ;

@property (nonatomic,assign) CGSize size ;

@property (nonatomic,assign) CGPoint origin ;

// frame

@property (nonatomic,assign,readonly) CGFloat minX ;

@property (nonatomic,assign,readonly) CGFloat minY ;

@property (nonatomic,assign,readonly) CGFloat midX ;

@property (nonatomic,assign,readonly) CGFloat midY ;

@property (nonatomic,assign,readonly) CGFloat maxX ;

@property (nonatomic,assign,readonly) CGFloat maxY ;

// bounds

@property (nonatomic,assign,readonly) CGFloat localMinX ;

@property (nonatomic,assign,readonly) CGFloat localMinY ;

@property (nonatomic,assign,readonly) CGFloat localMidX ;

@property (nonatomic,assign,readonly) CGFloat localMidY ;

@property (nonatomic,assign,readonly) CGFloat localMaxX ;

@property (nonatomic,assign,readonly) CGFloat localMaxY ;

#pragma mark by tofu jelly

/**
 *  view转换image
 */
- (UIImage *)rn_screenshot;
- (UIImage *)rn_screenshotForScrollViewWithContentOffset:(CGPoint)contentOffset;

/**
 *  添加手势点击回收键盘
 */
-(void)addGestureRecognizerWithHidekeyboard;

/**
 *  添加单击手势
 *
 *  @param view
 *  @param sel
 */
-(void)addGestureRecognizer:(id)view action:(SEL)name;

@end
