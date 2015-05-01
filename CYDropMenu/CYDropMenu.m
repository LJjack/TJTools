//
//  CYDropMenu.m
//  JiuLingLing
//
//  Created by tofu_jelly on 14-9-27.
//  Copyright (c) 2014年 对酒当歌. All rights reserved.
//

#import "CYDropMenu.h"
#import "UIColor+Hex.h"
@interface CYDropMenu()


@property (copy, nonatomic) CYDropMenuBlock  menuBlock;

@end

@implementation CYDropMenu
{
    UIColor         *_menuColor;    //排序按钮颜色
    NSMutableArray  *_titles;       //排序按钮标题
    
    NSMutableArray *_indicators;    //指示箭头
    
    
    NSInteger _currentSelectedMenudIndex;   //当前选择的按钮索引
    
    NSInteger _numOfMenu;                   //按钮个数
    
    NSArray *_array;                        //按钮数组
    
    BOOL    isClick;                        //是否点击
    
    UIView  *_sliderImage;

}


-(CYDropMenu *)initWithArray:(NSArray *)array selectedColor:(UIColor *)color frame:(CGRect)frame{
    self = [super init];
    if (self) {
        
        self.frame = frame;
        
        _menuColor = [UIColor colorWithRed:164.0/255.0 green:166.0/255.0 blue:169.0/255.0 alpha:1.0];
        
        _array = array;
        _numOfMenu = _array.count;
        
        CGFloat textLayerInterval = self.frame.size.width / _numOfMenu;
        
        _titles = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
        _indicators = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
        
        for (int i = 0; i < _numOfMenu; i++) {
            //文字位置
            CGPoint position = CGPointMake( i * textLayerInterval + (textLayerInterval / 2), self.frame.size.height / 2);
            UILabel *title = [self createTextLabelWithNSString:_array[i] withColor:_menuColor andPosition:position];
            title.tag=i+100;
            [self addSubview:title];
            [_titles addObject:title];
            if (i== 0) {
                title.textColor = color;
                title.font = [UIFont boldSystemFontOfSize:15.f];
            }
            UIView *verLine = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / _numOfMenu + self.frame.size.width / _numOfMenu * i, (frame.size.height-15)/2, 1, 15)];
            verLine.backgroundColor = [UIColor lightGrayColor];
            [self addSubview:verLine];
        }

        // 设置menu, 并添加手势
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMenu:)];
        [self addGestureRecognizer:tapGesture];
        _currentSelectedMenudIndex = 0;
        isClick = YES;
        
        
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-1*0.5, frame.size.width, 1*0.5)];
        line.backgroundColor = [UIColor colorWithHex:0xD0D0D0];
        [self addSubview:line];
        
        _sliderImage = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-2, self.frame.size.width / _numOfMenu, 2)];
        _sliderImage.backgroundColor = [UIColor colorWithHex:0xc70112];
        [self addSubview:_sliderImage];

    }
    return self;
}


#pragma mark - menu点击
- (void)tapMenu:(UITapGestureRecognizer *)paramSender{
    
    CGPoint touchPoint = [paramSender locationInView:self];
    
    // 得到tapIndex
    NSInteger tapIndex = touchPoint.x / (self.frame.size.width / _numOfMenu);
    
    //将点击的index传递到VC
    if (_menuBlock) {
        _menuBlock(tapIndex);
    }
    
    for (int i = 0; i < _numOfMenu; i++) {
        if (i != tapIndex) {  //不是当前点击
            [self animateTitle:_titles[i] selected:NO complete:^{}];
        }
    }
    
    if (tapIndex == _currentSelectedMenudIndex) {
        return;
    }else{
        _currentSelectedMenudIndex = tapIndex;
        [self animateTitle:_titles[tapIndex] selected:YES complete:nil];
        [self animationSlider:tapIndex];
    }
}



#pragma mark - 绘制text
-(UILabel *)createTextLabelWithNSString:(NSString *)string withColor:(UIColor *)color andPosition:(CGPoint)point{
    UILabel *label = [[UILabel alloc] init];
    CGFloat width = self.frame.size.width / _numOfMenu;
    [label setFrame:CGRectMake(0, 0, width, 40)];
    label.text = string;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:13.f];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = color;
    label.center = point;
    return label;
}
- (CATextLayer *)creatTextLayerWithNSString:(NSString *)string withColor:(UIColor *)color andPosition:(CGPoint)point
{
    
    CGSize size = [self calculateTitleSizeWithString:string];
    
    CATextLayer *layer = [CATextLayer new];
    CGFloat sizeWidth = (size.width < (self.frame.size.width / _numOfMenu) - 25) ? size.width : self.frame.size.width / _numOfMenu - 25;
    layer.bounds = CGRectMake(0, 0, sizeWidth, size.height);
    layer.string = string;
    layer.fontSize = 13.0;
    layer.alignmentMode = kCAAlignmentCenter;
    layer.foregroundColor = color.CGColor;
    
    layer.contentsScale = [[UIScreen mainScreen] scale];
    
    layer.position = point;
    
    return layer;
}

- (CGSize)calculateTitleSizeWithString:(NSString *)string
{
    CGFloat fontSize = 13.0;
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(280, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size;
}



#pragma mark - 改变选中的label、image状态
- (void)animateIndicator:(UIImageView *)indicator Forward:(BOOL)forward complete:(void(^)())complete
{
    [UIView animateWithDuration:0.3 animations:^{
        if (forward){
            indicator.transform = CGAffineTransformMakeRotation(M_PI);
        }else
        {
            indicator.transform = CGAffineTransformMakeRotation(0);
        }
    } completion:^(BOOL finish){
    }];
    
    complete();
}


- (void)animateTitle:(UILabel *)title selected:(BOOL)isSelected complete:(void(^)())complete{
    if (isSelected){
        title.textColor = [UIColor colorWithHex:0xc70112];
        title.font = [UIFont boldSystemFontOfSize:15.f];
    }
    else{
        title.textColor = _menuColor;
        title.font = [UIFont systemFontOfSize:13.f];
    }
}
-(void)animationSlider:(NSInteger)index{
    [UIView animateWithDuration:0.3 animations:^{
        [_sliderImage setFrame:CGRectMake(self.frame.size.width / _numOfMenu * index, self.frame.size.height-2, self.frame.size.width / _numOfMenu, 2)];
    }];
}
#pragma mark - block

-(void)CYDropMenuDidTappedUsingBlock:(CYDropMenuBlock)block{
    if (block) {
        self.menuBlock = block;
        
        if (_menuBlock) {
            _menuBlock(0);
        }
    }
}

@end
