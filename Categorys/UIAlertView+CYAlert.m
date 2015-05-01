//
//  UIAlertView+CYAlertView.m
//  ElephasWashCar
//
//  Created by tofujelly on 15/3/14.
//  Copyright (c) 2015年 tofu.jelly. All rights reserved.
//

#import "UIAlertView+CYAlert.h"
#import <objc/runtime.h>

NSString const* UIAlertViewKey = @"UIAlertViewKey";


@interface UIAlertView()

@property (nonatomic, copy) CYAlertCallBack alertBlock;

@end

@implementation UIAlertView (CYAlert)



+ (void)alertViewWithBlock:(CYAlertCallBack)callback title:(NSString *)title message:(NSString *)message  cancelButtonName:(NSString *)cancelButtonName otherButtonTitles:(NSString *)otherButtonTitles, ... {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonName otherButtonTitles: otherButtonTitles, nil];
    NSString *other = nil;
    va_list args;
    if (otherButtonTitles) {
        va_start(args, otherButtonTitles);
        while ((other = va_arg(args, NSString*))) {
            [alert addButtonWithTitle:other];
        }
        va_end(args);
    }
    alert.delegate = alert;
    [alert show];
    alert.alertBlock = callback;
}


- (void)setAlertBlock:(CYAlertCallBack)alertBlock {
    
    [self willChangeValueForKey:@"callbackBlock"];
    objc_setAssociatedObject(self, &UIAlertViewKey, alertBlock, OBJC_ASSOCIATION_COPY);
    [self didChangeValueForKey:@"callbackBlock"];
}

-(CYAlertCallBack)alertBlock{
    return objc_getAssociatedObject(self, &UIAlertViewKey);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (self.alertBlock) {
        self.alertBlock(buttonIndex);
    }
}

@end
