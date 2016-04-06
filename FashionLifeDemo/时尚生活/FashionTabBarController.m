
//
//  FashionTabBarController.m
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "FashionTabBarController.h"
#import "FashionNavController.h"
#import "StoreController.h"
#import "MagazineController.h"
#import "ShareController.h"
#import "TarentoController.h"
#import "MovieViewController.h"
#import "LeftTarentoController.h"
#import "MMDrawerController.h"
#import "LeftShareViewController.h"
#import "MovieLeftViewController.h"

@implementation FashionTabBarController


- (instancetype)init{
    if (self = [super init]) {
        
        // 商店
        StoreController *storeVc = [[StoreController alloc] init];
        FashionNavController *storeNav = [[FashionNavController alloc] initWithRootViewController:storeVc];
        storeNav.tabBarItem.title = @"商店";
        storeNav.tabBarItem.image = [UIImage imageNamed:@"iconfont-bag"];
//        [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
        
        
        
        
        // 杂志
        MagazineController *magazineVc = [[MagazineController alloc] initWithStyle:UITableViewStyleGrouped];
        FashionNavController *magazineNav = [[FashionNavController alloc] initWithRootViewController:magazineVc];
        magazineNav.tabBarItem.title = @"杂志";
        magazineNav.tabBarItem.image = [UIImage imageNamed:@"iconfont-shu"];
        
        
        
        // 分享
        ShareController *shareVc = [[ShareController alloc] init];
        FashionNavController *shareNav = [[FashionNavController alloc] initWithRootViewController:shareVc];
        
        LeftShareViewController *leftShareVc = [[LeftShareViewController alloc]init];
        MMDrawerController *MMDrawerShareViewVc = [[MMDrawerController alloc]initWithCenterViewController:shareNav leftDrawerViewController:leftShareVc];
        
        MMDrawerShareViewVc.tabBarItem.title = @"分享";
        MMDrawerShareViewVc.tabBarItem.image = [UIImage imageNamed:@"iconfont-fenxiang-2"];
        
        
        
        // 达人
        TarentoController *tarentoVc = [[TarentoController alloc] init];
        FashionNavController *tarentoNav = [[FashionNavController alloc] initWithRootViewController:tarentoVc];
        
        LeftTarentoController *leftTarentoVc = [[LeftTarentoController alloc]init];

        
        MMDrawerController *MMDrawerViewVc = [[MMDrawerController alloc]initWithCenterViewController:tarentoNav leftDrawerViewController:leftTarentoVc];
        
        MMDrawerViewVc.tabBarItem.title = @"达人";
        MMDrawerViewVc.tabBarItem.image = [UIImage imageNamed:@"iconfont-star-hollow"];
        
        
        
        self.viewControllers = @[storeNav,magazineNav,MMDrawerShareViewVc,MMDrawerViewVc];
        
        self.tabBar.tintColor = [UIColor whiteColor];
        self.tabBar.barTintColor = [UIColor blackColor];
    }
    return self;
}


@end
