//
//  CYLabel.m
//  jiulingling
//
//  Created by tofu_jelly on 14-9-13.
//  Copyright (c) 2014年 对酒当歌. All rights reserved.
//

#import "CYLabel.h"

@implementation CYLabel

#pragma mark - Initialization Method
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization
        self.strikeThroughEnabled = NO;
    }
    return self;
}

-(void)drawTextInRect:(CGRect)rect{
    [super drawTextInRect:rect];
    
    if (self.lineType != CYLabelLineTypeNone) {   //不需要任何线
        //字体大小
        CGSize textSize = [[self text] sizeWithAttributes:@{NSFontAttributeName : [self font]}];
        //线的宽度
        CGFloat  strikeWidth = textSize.width+6.0;
        CGRect   lineRect;              //线的rect
        CGFloat  line_x,line_y = 0.0;   //线的x,y
        
        if ([self textAlignment] == NSTextAlignmentRight) {
            line_x = rect.size.width - strikeWidth;
        }else if ([self textAlignment] == NSTextAlignmentCenter){
            line_x = (rect.size.width - strikeWidth) / 2;
        }else{
            line_x = 0.0;
        }
        
        if (self.lineType == CYLabelLineTypeTop) {   //上
            line_y = 2.0;
        }
        if (self.lineType == CYLabelLineTypeMiddle) {   //中
            line_y = rect.size.height / 2.0;
        }
        if (self.lineType == CYLabelLineTypeDown) {   //下
            line_y = rect.size.height - 2.0;
        }
        
        lineRect = CGRectMake(line_x-2.0, line_y, strikeWidth, 1*0.5);
        
        if (self.strikeThroughEnabled) {
            CGContextRef context = UIGraphicsGetCurrentContext();   //设置上下文
            
            CGContextSetFillColorWithColor(context, [self strikeColor].CGColor);  //设置画线颜色
            
            CGContextFillRect(context, lineRect);  //将线画入label中
        }
        

    }
}

@end
