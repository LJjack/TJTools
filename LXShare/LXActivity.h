//
//  LXActivity.h
//  LXActivity
//
//  Created by lixiang on 14-3-17.
//  Copyright (c) 2014年 lcolco. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^LXActivityBlock) (NSInteger optionIndex);

@protocol LXActivityDelegate <NSObject>
- (void)didClickOnImageIndex:(NSInteger)imageIndex;
@optional
- (void)didClickOnCancelButton;



@end

@interface LXActivity : UIView

@property (nonatomic,copy,readonly)   LXActivityBlock activityBlock;


/**
    使用delegate 初始化Activity
 */
- (instancetype)initWithTitle:(NSString *)title
                     delegate:(id<LXActivityDelegate>)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle
            ShareButtonTitles:(NSArray *)shareButtonTitlesArray
    withShareButtonImagesName:(NSArray *)shareButtonImagesNameArray;


- (void)showInView;


/**
 *  使用block 创建分享控件
 *
 *  @param title                      标题
 *  @param optionIndex                选项的索引
 *  @param cancelButtonTitle          取消按钮标题
 *  @param shareButtonTitlesArray     分享按钮标题数组
 *  @param shareButtonImagesNameArray 分享按钮图片数组
 *
 *  @return self
 */
+(instancetype)initWithTitle:(NSString *)title
                      option:(LXActivityBlock)optionIndex
           cancelButtonTitle:(NSString *)cancelButtonTitle
           ShareButtonTitles:(NSArray *)shareButtonTitlesArray
   withShareButtonImagesName:(NSArray *)shareButtonImagesNameArray;


@end
