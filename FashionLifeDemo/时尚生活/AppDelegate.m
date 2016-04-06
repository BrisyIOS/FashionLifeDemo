//
//  AppDelegate.m
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "AppDelegate.h"
#import "FashionTabBarController.h"
#import "UMSocial.h"
#import "UMSocialSinaHandler.h"
#import "StartController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //添加APPKey
    [UMSocialData setAppKey:@"5658406467e58ebfc9002494"];
    
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。若在新浪后台设置我们的回调地址，“http://sns.whalecloud.com/sina2/callback”，这里可以传nil
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
   
      // 用户第一次使用此软件
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"launchScreen"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"launchScreen"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"first"];
    }
    
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"first"]) {
        StartController *start = [[StartController alloc] init];
        self.window.rootViewController = start;
    }else{
        FashionTabBarController *fashiontabBar = [[FashionTabBarController alloc] init];
        self.window.rootViewController = fashiontabBar;
    }
   
    [self.window makeKeyAndVisible];
    
    return YES;
}



#pragma mark 添加回调处理方法
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}


- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (self.isRotation) {
        return UIInterfaceOrientationMaskLandscape;
    }else
    {
        return UIInterfaceOrientationMaskPortrait;
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
