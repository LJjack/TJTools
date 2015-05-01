//
//  Common.h
//  JiuLingLing
//
//  Created by tofu_jelly on 14/11/18.
//  Copyright (c) 2014年 对酒当歌. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSString *const kReleaseNotesViewVersionKey = @"com.hey900.VersionKey";
@interface Common : NSObject

/*! @brief 验证手机号
 *
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;


//判断有没有网络
+ (void) isHasNetWork:(void(^)(void))complietBlock;


//检查更新
+ (void) checkUpdateVersion:(BOOL)isShowAlert complietBlock:(void (^)(NSString *releaseNotes, NSError *error,BOOL isUpdate))complietBlock;
+ (void) openAppFromAppStore;



/** @name Checking the app version */

/**
 Checks for app update state, using the `CFBundleVersion` key in the application `Info.plist`.
 @return  Returns `YES` if a previous app version string was stored and if it does not match the current version string, `NO` otherwise.
 */
+ (BOOL)isAppVersionUpdated;

/**
 Checks if the app version key is currently stored or not.
 @return  Returns `YES` if no previous app version string was stored, `NO` otherwise.
 */
+ (BOOL)isAppOnFirstLaunch;


/*! 打开评分
 *
 */
+ (void) evaluateWithAPPID:(UIViewController *)control;
@end
