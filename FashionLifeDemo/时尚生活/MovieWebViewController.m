//
//  MovieWebViewController.m
//  时尚生活
//
//  Created by zhangxu on 15/11/27.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "MovieWebViewController.h"
#import "Header.h"
@interface MovieWebViewController ()

@end

@implementation MovieWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationItem.title = @"偏好设置";
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"arrow_25.6px_1155135_easyicon.net"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    
    
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 10)];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://magicapi.vmovier.com/magicapi/user/cate?uniqid=868201024649902"]];
    [web loadRequest:request];
    [self.view addSubview:web];
    
    
}

- (void)leftBarButtonAction:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
