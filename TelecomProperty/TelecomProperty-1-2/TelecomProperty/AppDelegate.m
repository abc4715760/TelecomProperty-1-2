//
//  AppDelegate.m
//  TelecomProperty
//
//  Created by 邓成其 on 13-3-10.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.

#import "AppDelegate.h"
#import "CusotomViewController.h"
#import "Reachability.h"
#define ScreenHeight [UIScreen mainScreen].bounds.size.height;

@implementation AppDelegate


#pragma mark -

- (void)changeProgressValue
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"温馨" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alert show];
}
//是否有网络
-(BOOL)isNetworkRunning;
{
   
    Reachability *r = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            return FALSE;
            break;
        case ReachableViaWWAN:
            return TRUE;
            break;
        case ReachableViaWiFi:
            return TRUE;
            break;
    }
    return YES;
    
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    //判断手机是否联网
//    if ( ![self isNetworkRunning]) {
//        UIAlertView *myalert = [[UIAlertView alloc]
//                                initWithTitle:NSLocalizedString(@"网络", @"Network error")
//                                message:NSLocalizedString(@"未连接请检查网络",@"Network isnt connected.Please check.")
//                                delegate:self
//                                cancelButtonTitle:NSLocalizedString(@"确定", @"Cancel")
//                                otherButtonTitles:nil];
//        
//        [myalert show];
//        [myalert release];
//        return YES;
//    }
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
//    //捕获异常
//    @try {
//        <#statements#>
//    }
//    @catch (NSException *exception) {
//        [exception.name ];//异常名字
//        [exception  reason];//异常原因
//    }
//    @finally {
//        <#statements#>
//    }
    
    /*
    新的方法获取 OPENUDID
     */
//  1f5ec4f8d769b75f7032f4766ece6b0a59b590a2  手机UDID
//  8e900f7f53b2d1549a87c891cf9edb457138db51  IPD UDID
//     [OpenUDID  setOptOut:NO];
//     NSLog(@"-----%@----",[OpenUDID value]);
//    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:[OpenUDID value] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//     [alert show];
    /*
     私有IPA
     */
    //     NSString *My=CTSettingCopyMyPhoneNumber();
    //    NSString *MyPhone=[NSString  stringWithFormat:@"本机号码%@",My];
    //    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:MyPhone delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    //    [alert show];
    /*
     通过registerForRemoteNotificationTypes方法，告诉应用程序，能接受push来的通知。
     */
  
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    [self appcancelAllLocalNotifications]; //删除通知
    [self.window makeKeyAndVisible];
    InformationViewController *inform=[[InformationViewController alloc]init];
    UINavigationController *navigation=[[UINavigationController alloc]initWithRootViewController:inform];
    self.window.rootViewController=navigation;
    [navigation release];
    [inform release];
//    CusotomViewController *cusotom=[[CusotomViewController alloc]init];
//    application.applicationIconBadgeNumber = 0;
//    self.window.rootViewController=cusotom;
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application
{
  
}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
}
- (void)applicationWillEnterForeground:(UIApplication *)application
{
}
////当程序还在后天运行
- (void)applicationDidBecomeActive:(UIApplication *)application
{
//    [self appcancelAllLocalNotifications]; //删除通知
//    application.applicationIconBadgeNumber= 10;
//    [self appcancelAllLocalNotifications]; //删除通知
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"iWeibo" message:@"11" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    [alert show];
//    [alert release];
}
- (void)applicationWillTerminate:(UIApplication *)application
{
     
}
////得到设备的token
//-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
//{
//    NSString *token = [NSString stringWithFormat:@"%@", deviceToken];
//    NSLog(@"My token is:%@", token);
//}
//-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
//{
//    //上传服务器
//    [application setApplicationIconBadgeNumber:0];
//
//}
//如果应用还是在前台运行,而且应用委托实现 接受本地推送
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"iWeibo" message:notification.alertBody delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    [alert show];
//    [alert release];
//        [self appcancelAllLocalNotifications]; //删除通知
    // 图标上的数字减1
//    application.applicationIconBadgeNumber=1;
}
//删除通知
-(void)appcancelAllLocalNotifications{
    
    UIApplication *app = [UIApplication sharedApplication];
    //获取本地推送数组
    NSArray *localArray = [app scheduledLocalNotifications];
    //声明本地通知对象
    UILocalNotification *localNotification=nil;
    if (localArray) {
        for (UILocalNotification *noti in localArray) {
            NSDictionary *dict = noti.userInfo;
            if (dict) {
                NSString *inKey = [dict objectForKey:@"someKey"];
                if ([inKey isEqualToString:@"someValue"]) {
                    if (localNotification){
                        NSLog(@"=====");
                        [app cancelAllLocalNotifications];
                        [localNotification release];
                        localNotification = nil;
                    }
                    localNotification = [noti retain];
                    break;
                }
            }
        }
        
        //判断是否找到已经存在的相同key的推送
        if (!localNotification) {
            NSLog(@"===1==");
            //不存在初始化
            localNotification = [[UILocalNotification alloc] init];
//              [app cancelAllLocalNotifications];
        }
        if (localNotification) {
            NSLog(@"===2==");
            //不推送 取消推送
            [app cancelLocalNotification:localNotification];
//              [app cancelAllLocalNotifications];
            [localNotification release];
            return;
        }
    }
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//    NSString *error_str = [NSString stringWithFormat: @"%@", error];
//    NSLog(@"Failed to get token, error:%@", error_str);
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return NO;
}

@end
