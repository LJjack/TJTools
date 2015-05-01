//
//  CYLabel.h
//  jiulingling
//
//  Created by tofu_jelly on 14-9-13.
//  Copyright (c) 2014年 对酒当歌. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    CYLabelLineTypeNone,       //无
    CYLabelLineTypeTop,        //上边线
    CYLabelLineTypeMiddle,     //删除线
    CYLabelLineTypeDown        //下划线
} CYLabelLineType;

@interface CYLabel : UILabel

@property (assign, nonatomic) CYLabelLineType   lineType;     //label类型
@property (strong, nonatomic) UIColor           *strikeColor; //画线颜色
@property (assign, nonatomic) BOOL      strikeThroughEnabled; // 是否画线
@end
