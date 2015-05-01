//
//  LXActivity.m
//  LXActivityDemo
//
//  Created by lixiang on 14-3-17.
//  Copyright (c) 2014年 lcolco. All rights reserved.
//

#import "LXActivity.h"

#define TOPLINE_COLOR                           [UIColor colorWithRed:255/255.0 green:177/255.0 blue:0/255.0 alpha:1]

#define WINDOW_COLOR                            [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]
//#define ACTIONSHEET_BACKGROUNDCOLOR             [UIColor colorWithRed:106/255.00f green:106/255.00f blue:106/255.00f alpha:0.8]
#define ACTIONSHEET_BACKGROUNDCOLOR             [UIColor colorWithRed:255/255.00f green:255/255.00f blue:255/255.00f alpha:0.8]
#define ANIMATE_DURATION                        0.25f

#define CORNER_RADIUS                           5
#define SHAREBUTTON_BORDER_WIDTH                0.5f
#define SHAREBUTTON_BORDER_COLOR                [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.8].CGColor
#define SHAREBUTTONTITLE_FONT                   [UIFont fontWithName:@"HelveticaNeue-Bold" size:18]

//#define CANCEL_BUTTON_COLOR                     [UIColor colorWithRed:53/255.00f green:53/255.00f blue:53/255.00f alpha:1]
#define CANCEL_BUTTON_COLOR                     [UIColor colorWithRed:239/255.00f green:238/255.00f blue:244/255.00f alpha:1]

#define SHAREBUTTON_WIDTH                       55
#define SHAREBUTTON_HEIGHT                      55
#define SHAREBUTTON_INTERVAL_WIDTH              25
#define SHAREBUTTON_INTERVAL_HEIGHT             35

#define SHARETITLE_WIDTH                        75
#define SHARETITLE_HEIGHT                       20
#define SHARETITLE_INTERVAL_WIDTH               15
#define SHARETITLE_INTERVAL_HEIGHT              SHAREBUTTON_WIDTH + SHAREBUTTON_INTERVAL_HEIGHT
#define SHARETITLE_FONT                         [UIFont fontWithName:@"Helvetica" size:18]

#define TITLE_INTERVAL_Y                        10
#define TITLE_INTERVAL_X                        10
#define TITLE_HEIGHT                            35
#define TITLE_WIDTH                             [UIScreen mainScreen].bounds.size.width - 2 * \
                                                                             TITLE_INTERVAL_X \

#define TITLE_FONT                              [UIFont fontWithName:@"Helvetica" size:12]
#define SHADOW_OFFSET                           CGSizeMake(0, 0.8f)
#define TITLE_NUMBER_LINES                      2

#define BUTTON_INTERVAL_HEIGHT                  10
#define BUTTON_HEIGHT                           40
#define BUTTON_INTERVAL_WIDTH                   10
#define BUTTON_WIDTH                            [UIScreen mainScreen].bounds.size.width - 2 * \
                                                                        BUTTON_INTERVAL_WIDTH \

#define BUTTONTITLE_FONT                        [UIFont fontWithName:@"HelveticaNeue" size:18]
#define BUTTON_BORDER_WIDTH                     0.5f
//#define BUTTON_BORDER_COLOR                     [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.6].CGColor
#define BUTTON_BORDER_COLOR                     [UIColor lightGrayColor].CGColor

#define TOTALCOLUMNS                            3
@interface UIImage (custom)

+ (UIImage *)imageWithColor:(UIColor *)color;

@end


@implementation UIImage (custom)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end

@interface LXActivity ()

@property (nonatomic,strong) UIView *backGroundView;
@property (nonatomic,strong) NSString *actionTitle;
@property (nonatomic,assign) NSInteger postionIndexNumber;
@property (nonatomic,assign) BOOL isHadTitle;
@property (nonatomic,assign) BOOL isHadShareButton;
@property (nonatomic,assign) BOOL isHadCancelButton;
@property (nonatomic,assign) CGFloat LXActivityHeight;
@property (nonatomic,assign) id<LXActivityDelegate>delegate;

@property (nonatomic,copy,readwrite)   LXActivityBlock activityBlock;


@end

@implementation LXActivity

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - Public method
/**
 *  使用代理创建分享组件
 *
 *  @param title                      标题
 *  @param delegate                   代理
 *  @param cancelButtonTitle          取消按钮标题
 *  @param shareButtonTitlesArray     分享按钮标题数组
 *  @param shareButtonImagesNameArray 分享按钮图片数组
 *
 *  @return self
 */
- (instancetype)initWithTitle:(NSString *)title delegate:(id<LXActivityDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle ShareButtonTitles:(NSArray *)shareButtonTitlesArray withShareButtonImagesName:(NSArray *)shareButtonImagesNameArray;
{
        return [self initWithTitle:title
                          delegate:delegate
                            option:nil
                 cancelButtonTitle:cancelButtonTitle
                 ShareButtonTitles:shareButtonTitlesArray
         withShareButtonImagesName:shareButtonImagesNameArray];
}

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
+(instancetype)initWithTitle:(NSString *)title  option:(LXActivityBlock)optionIndex cancelButtonTitle:(NSString *)cancelButtonTitle ShareButtonTitles:(NSArray *)shareButtonTitlesArray withShareButtonImagesName:(NSArray *)shareButtonImagesNameArray
{
    
//    return [[self alloc] initWithTitle:title
//                              delegate:nil
//                                option:optionIndex
//                     cancelButtonTitle:cancelButtonTitle
//                     ShareButtonTitles:shareButtonTitlesArray
//             withShareButtonImagesName:shareButtonImagesNameArray];
    
    
    LXActivity *activity = [[self alloc] initWithTitle:title
                                      delegate:nil
                                        option:optionIndex
                             cancelButtonTitle:cancelButtonTitle
                             ShareButtonTitles:shareButtonTitlesArray
                     withShareButtonImagesName:shareButtonImagesNameArray];
    [activity showInView];
    
    return activity;
}


/**
 *  使用block 创建分享控件
 *
 *  @param title                      标题
 *  @param delegate                   代理
 *  @param optionIndex                选项的索引block
 *  @param cancelButtonTitle          取消按钮标题
 *  @param shareButtonTitlesArray     分享按钮标题数组
 *  @param shareButtonImagesNameArray 分享按钮图片数组
 *
 *  @return self
 */
-(instancetype)initWithTitle:(NSString *)title delegate:(id<LXActivityDelegate>)delegate option:(LXActivityBlock)optionIndex cancelButtonTitle:(NSString *)cancelButtonTitle ShareButtonTitles:(NSArray *)shareButtonTitlesArray withShareButtonImagesName:(NSArray *)shareButtonImagesNameArray
{
    if (self = [super init]) {
        //初始化背景视图，添加手势
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.backgroundColor = WINDOW_COLOR;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
        [self addGestureRecognizer:tapGesture];
        
        if (delegate) {
            self.delegate = delegate;
        }
        if (optionIndex) {
            self.activityBlock = optionIndex;
        }
        [self creatButtonsWithTitle:title cancelButtonTitle:cancelButtonTitle shareButtonTitles:shareButtonTitlesArray withShareButtonImagesName:shareButtonImagesNameArray];
    }
    
    return self;
}

- (void)showInView
{
//    [[UIApplication sharedApplication].delegate.window.rootViewController.view
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}




#pragma mark - Praviate method

- (void)creatButtonsWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle shareButtonTitles:(NSArray *)shareButtonTitlesArray withShareButtonImagesName:(NSArray *)shareButtonImagesNameArray
{
    //初始化
    self.isHadTitle = NO;
    self.isHadShareButton = NO;
    self.isHadCancelButton = NO;
    
    //初始化LXACtionView的高度为0
    self.LXActivityHeight = 0;
    
    //初始化IndexNumber为0;
    self.postionIndexNumber = 0;
    
    //生成LXActionSheetView
    self.backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
    self.backGroundView.backgroundColor = ACTIONSHEET_BACKGROUNDCOLOR;
    
    
    
    //内容按钮背景
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectZero];
    contentView.backgroundColor = CANCEL_BUTTON_COLOR;
    int row = (int)ceil((float)(shareButtonImagesNameArray.count)/3);
    CGFloat contentViewHeight = row * (SHAREBUTTON_HEIGHT + TITLE_INTERVAL_Y + SHARETITLE_HEIGHT) + TITLE_HEIGHT + 2*TITLE_INTERVAL_Y;
    [contentView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, contentViewHeight)];
    contentView.layer.borderWidth = BUTTON_BORDER_WIDTH;
    contentView.layer.borderColor = BUTTON_BORDER_COLOR;
    [self.backGroundView addSubview:contentView];
    
    
    //顶部线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 3)];
    line.backgroundColor = TOPLINE_COLOR;
    [self.backGroundView addSubview:line];
    
    
    
    //给LXActionSheetView添加响应事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedBackGroundView)];
    [self.backGroundView addGestureRecognizer:tapGesture];
    
    [self addSubview:self.backGroundView];
    
    if (title) {
        self.isHadTitle = YES;
        UILabel *titleLabel = [self creatTitleLabelWith:title];
        self.LXActivityHeight = self.LXActivityHeight + 2*TITLE_INTERVAL_Y+TITLE_HEIGHT;
        [self.backGroundView addSubview:titleLabel];
    }

    if (shareButtonImagesNameArray) {
        if (shareButtonImagesNameArray.count > 0) {
            
            self.isHadShareButton = YES;
            
            CGFloat shareButtonLeftMargin = ([UIScreen mainScreen].bounds.size.width - (TOTALCOLUMNS * SHAREBUTTON_WIDTH + (SHAREBUTTON_INTERVAL_WIDTH* 2 * (TOTALCOLUMNS - 1)))) * 0.5;
            
            for (int i = 1; i < shareButtonImagesNameArray.count+1; i++) {
                //计算出行数，与列数
                int row = (int)ceil((float)(i)/TOTALCOLUMNS); //行
                int column = (i)%TOTALCOLUMNS; //列
                if (column == 0) {
                    column = TOTALCOLUMNS;
                }
                UIButton *shareButton = [self creatShareButtonWithRow:row andColumn:column];
                shareButton.tag = self.postionIndexNumber;
                [shareButton addTarget:self action:@selector(didClickOnImageIndex:) forControlEvents:UIControlEventTouchUpInside];
                
                [shareButton setBackgroundImage:[UIImage imageNamed:[shareButtonImagesNameArray objectAtIndex:i-1]] forState:UIControlStateNormal];
                //有Title的时候
                if (self.isHadTitle == YES) {
                    [shareButton setFrame:CGRectMake(shareButtonLeftMargin +((column-1)*(SHAREBUTTON_INTERVAL_WIDTH*2+SHAREBUTTON_WIDTH)), self.LXActivityHeight+((row-1)*(SHAREBUTTON_INTERVAL_HEIGHT+SHAREBUTTON_HEIGHT)), SHAREBUTTON_WIDTH, SHAREBUTTON_HEIGHT)];
                }
                else{
                    [shareButton setFrame:CGRectMake(SHAREBUTTON_INTERVAL_WIDTH+((column-1)*(SHAREBUTTON_INTERVAL_WIDTH*2+SHAREBUTTON_WIDTH)), SHAREBUTTON_INTERVAL_HEIGHT+((row-1)*(SHAREBUTTON_INTERVAL_HEIGHT+SHAREBUTTON_HEIGHT)), SHAREBUTTON_WIDTH, SHAREBUTTON_HEIGHT)];
                }
                
                CGFloat line1X = shareButtonLeftMargin + column * (SHAREBUTTON_WIDTH + SHAREBUTTON_INTERVAL_WIDTH) + (column == 1?0:SHAREBUTTON_INTERVAL_WIDTH);
                
                UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(line1X, self.LXActivityHeight+((row-1)*(SHAREBUTTON_INTERVAL_HEIGHT+SHAREBUTTON_HEIGHT)), 1, SHAREBUTTON_HEIGHT)];
                line1.image = [UIImage imageNamed:@"share_line"];
                [self.backGroundView addSubview:line1];
                if (column == 3) {
                    [line1 removeFromSuperview];
                }
                [self.backGroundView addSubview:shareButton];
                
                self.postionIndexNumber++;
            }
            
        }
    }
    
    if (shareButtonTitlesArray) {
        
        if (shareButtonTitlesArray.count > 0 && shareButtonImagesNameArray.count > 0) {
            
            CGFloat shareButtonTitleLeftMargin = ([UIScreen mainScreen].bounds.size.width - (TOTALCOLUMNS * SHARETITLE_WIDTH + (SHARETITLE_INTERVAL_WIDTH* 2 * (TOTALCOLUMNS - 1)))) * 0.5;
            
            for (int j = 1; j < shareButtonTitlesArray.count+1; j++) {
                //计算出行数，与列数
                int row = (int)ceil((float)(j)/TOTALCOLUMNS); //行
                int column = (j)%TOTALCOLUMNS; //列
                if (column == 0) {
                    column = TOTALCOLUMNS;
                }
                UILabel *shareLabel = [self creatShareLabelWithRow:row andColumn:column];
                shareLabel.text = [shareButtonTitlesArray objectAtIndex:j-1];
                //有Title的时候
                if (self.isHadTitle == YES) {
                    [shareLabel setFrame:CGRectMake(shareButtonTitleLeftMargin+((column-1)*(SHARETITLE_INTERVAL_WIDTH*2+SHARETITLE_WIDTH)), self.LXActivityHeight+SHAREBUTTON_HEIGHT+4+((row-1)*(SHARETITLE_INTERVAL_HEIGHT)), SHARETITLE_WIDTH, SHARETITLE_HEIGHT)];
                }
                [self.backGroundView addSubview:shareLabel];
            }
        }
    }
    
    //再次计算加入shareButtons后LXActivity的高度
    if (shareButtonImagesNameArray && shareButtonImagesNameArray.count > 0) {
        int totalRows = (int)ceil((float)(shareButtonImagesNameArray.count)/TOTALCOLUMNS);
        if (self.isHadTitle  == YES) {
            self.LXActivityHeight = self.LXActivityHeight + totalRows*(SHAREBUTTON_INTERVAL_HEIGHT+SHAREBUTTON_HEIGHT);
        }
        else{
            self.LXActivityHeight = SHAREBUTTON_INTERVAL_HEIGHT + totalRows*(SHAREBUTTON_INTERVAL_HEIGHT+SHAREBUTTON_HEIGHT);
        }
    }
    
    if (cancelButtonTitle) {
        self.isHadCancelButton = YES;
        UIButton *cancelButton = [self creatCancelButtonWith:cancelButtonTitle];
        cancelButton.tag = self.postionIndexNumber;
        [cancelButton addTarget:self action:@selector(didClickOnImageIndex:) forControlEvents:UIControlEventTouchUpInside];
        
        //当没title destructionButton otherbuttons时
        if (self.isHadTitle == NO && self.isHadShareButton == NO) {
            self.LXActivityHeight = self.LXActivityHeight + cancelButton.frame.size.height+(2*BUTTON_INTERVAL_HEIGHT);
        }
        //当有title或destructionButton或otherbuttons时
        if (self.isHadTitle == YES || self.isHadShareButton == YES) {
            [cancelButton setFrame:CGRectMake(cancelButton.frame.origin.x, self.LXActivityHeight, cancelButton.frame.size.width, cancelButton.frame.size.height)];
            self.LXActivityHeight = self.LXActivityHeight + cancelButton.frame.size.height+BUTTON_INTERVAL_HEIGHT;
        }
        [self.backGroundView addSubview:cancelButton];
        
        self.postionIndexNumber++;
    }
    
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-self.LXActivityHeight, [UIScreen mainScreen].bounds.size.width, self.LXActivityHeight)];
    } completion:^(BOOL finished) {
    }];
}


- (UIButton *)creatCancelButtonWith:(NSString *)cancelButtonTitle
{
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(BUTTON_INTERVAL_WIDTH, BUTTON_INTERVAL_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT)];
    //    cancelButton.layer.masksToBounds = YES;
    //    cancelButton.layer.cornerRadius = CORNER_RADIUS;
    
    cancelButton.layer.borderWidth = BUTTON_BORDER_WIDTH;
    cancelButton.layer.borderColor = BUTTON_BORDER_COLOR;
    
    UIImage *image = [UIImage imageWithColor:CANCEL_BUTTON_COLOR];
    [cancelButton setBackgroundImage:image forState:UIControlStateNormal];
    
    [cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
    cancelButton.titleLabel.font = BUTTONTITLE_FONT;
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    return cancelButton;
}

- (UIButton *)creatShareButtonWithRow:(int)row andColumn:(int)column
{
    UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake(SHAREBUTTON_INTERVAL_WIDTH+((column-1)*(SHAREBUTTON_INTERVAL_WIDTH+SHAREBUTTON_WIDTH)), SHAREBUTTON_INTERVAL_HEIGHT+((row-1)*(SHAREBUTTON_INTERVAL_HEIGHT+SHAREBUTTON_HEIGHT)), SHAREBUTTON_WIDTH, SHAREBUTTON_HEIGHT)];
    return shareButton;
}

- (UILabel *)creatShareLabelWithRow:(int)row andColumn:(int)column
{
    UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(SHARETITLE_INTERVAL_WIDTH+((column-1)*(SHARETITLE_INTERVAL_WIDTH+SHARETITLE_WIDTH)), SHARETITLE_INTERVAL_HEIGHT+((row-1)*(SHARETITLE_INTERVAL_HEIGHT)), SHARETITLE_WIDTH, SHARETITLE_HEIGHT)];
    
    shareLabel.backgroundColor = [UIColor clearColor];
    shareLabel.textAlignment = NSTextAlignmentCenter;
    shareLabel.font = TITLE_FONT;
    shareLabel.textColor = [UIColor blackColor];
    return shareLabel;
}

- (UILabel *)creatTitleLabelWith:(NSString *)title
{
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_INTERVAL_X, TITLE_INTERVAL_Y, TITLE_WIDTH, TITLE_HEIGHT)];
    titlelabel.backgroundColor = [UIColor clearColor];
    titlelabel.textAlignment = NSTextAlignmentLeft;
    //    titlelabel.shadowColor = [UIColor blackColor];
    //    titlelabel.shadowOffset = SHADOW_OFFSET;
    titlelabel.font = SHARETITLE_FONT;
    titlelabel.text = title;
    titlelabel.textColor = [UIColor blackColor];
    titlelabel.numberOfLines = TITLE_NUMBER_LINES;
    return titlelabel;
}

- (void)didClickOnImageIndex:(UIButton *)button
{
    if (self.delegate) {
        if (button.tag != self.postionIndexNumber-1) {
            if ([self.delegate respondsToSelector:@selector(didClickOnImageIndex:)] == YES) {
                [self.delegate didClickOnImageIndex:button.tag];
            }
        }
        else{
            if ([self.delegate respondsToSelector:@selector(didClickOnCancelButton)] == YES){
                [self.delegate didClickOnCancelButton];
            }
        }
    }
    if (self.activityBlock) {
        self.activityBlock(button.tag);
    }
    [self tappedCancel];
}

- (void)tappedCancel
{
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self removeFromSuperview];
        }
    }];
}

- (void)tappedBackGroundView
{
    //
    
}

-(void)dealloc{
    _activityBlock = nil;
}
@end
