//
//  MagazineWebController.m
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "MagazineWebController.h"
#import "Header.h"
#import "UMSocial.h"


@interface MagazineWebController ()<UMSocialDataDelegate, UMSocialUIDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UILabel *label;

@end

@implementation MagazineWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建webView
    [self createWebView];
    
}

#pragma mark -- 创建webview --
- (void)createWebView
{
    [self createPushView];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.topic_url]]];
    [self.view addSubview:self.webView];
}
#pragma mark -- 返回的Button --
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark -- 分享的Button --
- (void)shareAction
{
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    UIImage *imge = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.cover_img_new]]];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5658406467e58ebfc9002494"
                                      shareText:[NSString stringWithFormat:@"%@ %@", self.topic_name , self.topic_url]
                                     shareImage:imge
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren, UMShareToDouban, nil]
                                       delegate:self];
}
- (void)didFinishGetUMSocialDataResponse:(UMSocialResponseEntity *)response
{
    if (response.responseCode == UMSResponseCodeSuccess) {
    }
}
#pragma mark -- push过来的 --
- (void)createPushView
{
    // 创建返回分享和标题
    [self createBackAndShareAndTitle];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.shareBtn];

    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    self.navigationItem.titleView = self.label;
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}
#pragma mark -- 创建返回分享和标题 --
- (void)createBackAndShareAndTitle
{
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(0, 20, 50, 44);
    [self.backBtn setImage:[UIImage imageNamed:@"arrow_25.6px_1155135_easyicon.net"] forState:UIControlStateNormal];
    [self.backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, kScreenWidth-100, 44)];
    self.label.text = self.topic_name;
    self.label.textColor = [UIColor blackColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    
    self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shareBtn.frame = CGRectMake(kScreenWidth-50, 20, 50, 44);
    [self.shareBtn setImage:[UIImage imageNamed:@"iconfont-fenxiang-3"] forState:UIControlStateNormal];
    [self.shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
}

@end
