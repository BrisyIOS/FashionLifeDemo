//
//  StartController.m
//  时尚生活
//
//  Created by zhangxu on 15/11/30.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "StartController.h"
#import "Header.h"
#import "FashionTabBarController.h"

@interface StartController ()
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;

@end

@interface StartController ()<UIScrollViewDelegate>

@end

@implementation StartController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth*7, kScreenHeight);
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.pagingEnabled = YES;
    
    
    
    for (int i = 0; i < 7; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"launchScreen_0%d",i + 1]];
        [self.scrollView addSubview:imageView];
        
        if (i == 6) {
            UIButton *button = [self creatButton];
            [imageView addSubview:button];
        }
    }
    
    
    [self.view addSubview:_scrollView];
    
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.center = CGPointMake(kScreenWidth/2, kScreenHeight - 100);
    self.pageControl.numberOfPages = 7;
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.bounds = CGRectMake(0, 0, 100, 20);
    [self.view addSubview:_pageControl];
}



#pragma mark - 开始减速滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage = (int)scrollView.contentOffset.x/kScreenWidth;
    
}


- (UIButton *)creatButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.center = CGPointMake(kScreenWidth/2, kScreenHeight - 200);
    button.bounds = CGRectMake(0, 0, kScreenWidth/4, 40);
    button.backgroundColor = [UIColor greenColor];
    button.layer.cornerRadius = 10;
    [button setTitle:@"立即进入" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(openFashion:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}



#pragma mark - 跳转到首页
- (void)openFashion:(UIButton *)button{
    FashionTabBarController *tabBar = [[FashionTabBarController alloc] init];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"first"];
    [self presentViewController:tabBar animated:YES completion:nil];
}


@end
