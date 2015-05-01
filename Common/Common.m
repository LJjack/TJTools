//
//  Common.m
//  JiuLingLing
//
//  Created by tofu_jelly on 14/11/18.
//  Copyright (c) 2014年 对酒当歌. All rights reserved.
//

#import "Common.h"
#import <StoreKit/StoreKit.h>
@interface Common()<UIAlertViewDelegate,SKStoreProductViewControllerDelegate>

@end

@implementation Common


#pragma mark - 验证手机号码
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /*
     
     中国移动：134（不含1349）、135、136、137、138、139、147、150、151、152、157、158、159、182、183、184、187、188
     中国联通：130、131、132、145（上网卡）、155、156、185、186
     中国电信：133、1349（卫星通信）、153、180、181、189
     4G号段：170：[1700(电信)、1705(移动)、1709(联通)]、176(联通)、177(电信)、178(移动)
     未知号段：140、141、142、143、144、146、148、149、154
     
     */
    
    NSString *MOBILE = @"^1(3[0-9]|4[0-9]|5[0-35-9]|7[0678]|8[025-9])\\d{8}$";
    
    NSString  *CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[1278])\\d)\\d{7}$";
    
    NSString *CU = @"^1(3[0-2]|5[2456]|8[56])\\d{8}$";
    
    NSString *CT = @"^1((33|53|70[059]|8[09])[0-9]|349)\\d{7}$";
    
    //
    //    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate  *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    NSPredicate *regextestcm = [NSPredicate  predicateWithFormat:@"SELF MATCHES %@",CM];
    
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CU];
    
    NSPredicate  *regextestct = [NSPredicate  predicateWithFormat:@"SELF MATCHES %@",CT];
    
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)||
        ([regextestcm evaluateWithObject:mobileNum] == YES)||
        ([regextestct evaluateWithObject:mobileNum] == YES)||
        ([regextestcu evaluateWithObject:mobileNum]== YES))
    {
        return  YES;
    }else{
        return NO;
    }
    
}


+(void)checkUpdateVersion:(BOOL)isShowAlert complietBlock:(void (^)(NSString *, NSError *, BOOL))complietBlock{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",@"284910350"]]];
    
    [request setHTTPMethod:@"GET"];
//    NSError *error;
//    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        BOOL isUpdate = NO;
        if (!data) {
            complietBlock(nil,connectionError,nil);
            return;
        }
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSString *latestVersion = jsonData[@"results"][0][@"version"];
        
        NSDictionary *appInfoDict = [[NSBundle mainBundle] infoDictionary];
        NSString *version = [appInfoDict objectForKey:@"CFBundleVersion"];
        //    __block BOOL wup = isUpdate;
        //    dispatch_async(dispatch_get_main_queue(), ^{
        //        BOOL strong = wup;
        if ([latestVersion isEqualToString:version] && isShowAlert) {
            
            isUpdate = NO;
        }
        if (latestVersion.floatValue > version.floatValue)
        {
            isUpdate = YES;
        }
        
        complietBlock(jsonData[@"results"][0][@"releaseNotes"],connectionError,isUpdate);
    }];
    
    
//    });
    

}

//在appstore 中打开应用
+(void)openAppFromAppStore{
    NSString *str = @"itms-apps://itunes.apple.com/app/id284910350";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

//是否第一次启动
+ (BOOL)isAppOnFirstLaunch
{
    // Read stored version string
    NSString *previousAppVersion = [[NSUserDefaults standardUserDefaults] stringForKey:kReleaseNotesViewVersionKey];
    
    // Flag app as on first launch if no previous app string is found
    BOOL isFirstLaunch = (!previousAppVersion) ? YES : NO;
    
    if (isFirstLaunch)
    {
        // Store current app version if needed
        [self storeCurrentAppVersionString];
    }
    
    return isFirstLaunch;
}
//应用是否是最新版本
+ (BOOL)isAppVersionUpdated
{
    // Read stored version string and current version string
    NSString *previousAppVersion = [[NSUserDefaults standardUserDefaults] stringForKey:kReleaseNotesViewVersionKey];
    NSString *currentAppVersion = [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];
    
    // Flag app as updated if a previous version string is found and it does not match with the current version string
    BOOL isUpdated = (previousAppVersion && ![previousAppVersion isEqualToString:currentAppVersion]) ? YES : NO;
    
    if (isUpdated || !previousAppVersion)
    {
        // Store current app version if needed
        [self storeCurrentAppVersionString];
    }
    
    return isUpdated;
}
//保存版本信息

+ (void)storeCurrentAppVersionString
{
    // Store current app version string in the user defaults
    NSString *currentAppVersion = [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];
    [[NSUserDefaults standardUserDefaults] setObject:currentAppVersion forKey:kReleaseNotesViewVersionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//打开应用
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [Common openAppFromAppStore];
    }
}

//检查网络
+(void)isHasNetWork:(void (^)(void))complietBlock{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSOperationQueue *operationQueue = manager.operationQueue;
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        DLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                NSLog(@"WIFI");
                complietBlock();
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:
            {
                [operationQueue setSuspended:YES];
                NSLog(@"oflline, baby");
                JLLTiShiKuang *hub = [[JLLTiShiKuang alloc] init];
                [hub showWithTitle:@"请检查网络连接" type:fail];
                return;
                break;
            }
                
        }
    }];
}

#pragma mark 打开评分页面
+ (void) evaluateWithAPPID:(UIViewController *)control  {
    
    //初始化控制器
    SKStoreProductViewController *storeProductViewContorller = [[SKStoreProductViewController alloc] init];
    //设置代理请求为当前控制器本身
    storeProductViewContorller.delegate = control;
    
    //模态弹出appstore
    [control presentViewController:storeProductViewContorller animated:YES completion:^{
        JLLTiShiKuang *view = (JLLTiShiKuang *)[[UIApplication sharedApplication].keyWindow viewWithTag:2000];
        [view hide];
    }
     ];
    //加载一个新的视图展示
    [storeProductViewContorller loadProductWithParameters:
     //appId唯一的
     @{SKStoreProductParameterITunesItemIdentifier : @"284910350"} completionBlock:^(BOOL result, NSError *error) {
         //block回调
         if(error){
             NSLog(@"error %@ with userInfo %@",error,[error userInfo]);
             JLLTiShiKuang *view = (JLLTiShiKuang *)[[UIApplication sharedApplication].keyWindow viewWithTag:2000];
             [view hide];
             
             NSString *str = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",@"284910350"];
             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
             
         }
     }];
}

@end
