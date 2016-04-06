//
//  SlideController.m
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "SlideController.h"


@interface SlideController ()<UIWebViewDelegate>


@end

@implementation SlideController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"arrow_25.6px_1155135_easyicon.net"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    
    
    self.navigationItem.title = self.name;
    if (self.url == nil || self.url.length == 0) {
        return;
    }
   

    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.bounds];
    web.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [web loadRequest:request];
     [self.view addSubview:web];
    
    [MBProgressHUD showMessage:@"loading..." toView:self.view];
}


#pragma mark - 加载完毕停掉菊花
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:self.view];
}


- (void)leftBarButtonAction:(UIBarButtonItem *)button
{

    [self.navigationController popViewControllerAnimated:YES];
}

@end
