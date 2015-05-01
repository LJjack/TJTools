//
//  CYDropMenu.h
//  JiuLingLing
//
//  Created by tofu_jelly on 14-9-27.
//  Copyright (c) 2014年 对酒当歌. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYDropMenu;

typedef void(^CYDropMenuBlock) (NSInteger menuIndex);
@interface CYDropMenu : UIView



/*
 * @brief 初始化顶部排序菜单
 */
- (CYDropMenu *)initWithArray:(NSArray *)array selectedColor:(UIColor *)color frame:(CGRect)frame;

/*
 * @brief 排序按钮点击回调block
 */
-(void)CYDropMenuDidTappedUsingBlock:(CYDropMenuBlock)block;

@end
