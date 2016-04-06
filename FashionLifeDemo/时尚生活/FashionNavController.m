//
//  FashionNavController.m
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "FashionNavController.h"
#import "StoreController.h"
#import "SearchController.h"
#import "MovieViewController.h"
@implementation FashionNavController


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if ([viewController isKindOfClass:[StoreController class]]) {
        [self buttonWithController:viewController Action:@selector(search) ImageName:@"search" IsOk:YES];
        
    }else if ([viewController isKindOfClass:[MovieViewController class]]){
  
        
    }
    else
    {
        [self buttonWithController:viewController Action:@selector(back) ImageName:@"arrow_25.6px_1155135_easyicon.net" IsOk:YES];
    }
    
   
    [super pushViewController:viewController animated:animated];
}


#pragma mark - 快速创建左右按钮
- (void)buttonWithController:(UIViewController *)viewController Action:(SEL)action ImageName:(NSString *)imageName IsOk:(BOOL)isOk{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 25, 25);
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (isOk) {
        viewController.navigationItem.leftBarButtonItem = leftBarButton;
    }else{
        viewController.navigationItem.rightBarButtonItem = leftBarButton;
    }
}



#pragma mark - 返回
- (void)back{
    [self popViewControllerAnimated:NO];
}



#pragma mark - 搜索
- (void)search{
    
    SearchController *searchVc = [[SearchController alloc] init];
    [self pushViewController:searchVc animated:YES];
}


@end
