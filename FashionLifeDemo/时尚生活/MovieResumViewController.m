//
//  MovieResumViewController.m
//  时尚生活
//
//  Created by zhangxu on 15/11/27.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "MovieResumViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import "AVMoviePlayer.h"
@interface MovieResumViewController ()

@property(nonatomic, strong)AVMoviePlayer *avMoviePlay;

@end

@implementation MovieResumViewController

- (void)dealloc
{
    NSLog(@"销毁");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = nil;
    
    if (self.model.savePath)
    
    /* 从本地读取视频 */
    {
        url = [NSURL fileURLWithPath:self.model.savePath];
    }
    
    /* 从网络请求视频 */
    else
    {
        url = [NSURL URLWithString:self.model.video];
    }
    
    /* 添加播放器 */
    self.avMoviePlay = [[AVMoviePlayer alloc]initWithFrame:CGRectMake(0, 0, kScreenHeight, kScreenWidth) URL:url];

    
    self.avMoviePlay.backButton.textLabel.text = _model.title;
    [self.avMoviePlay.backButton addTarget:self action:@selector(moviePlayweAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_avMoviePlay];
    
}

#pragma mark - 退出视频播放
- (void)moviePlayweAction:(UIButton *)button
{
    
    // 退出视频播放的时候销毁定时器，暂停播放
    [self.avMoviePlay.timer invalidate];
    [self.avMoviePlay.player pause];
    [self.avMoviePlay.player setRate:0];
    
    [self.avMoviePlay.player.currentItem cancelPendingSeeks];
    [self.avMoviePlay.player.currentItem.asset cancelLoading];

    
    // 退出播放视频的时候，强制竖屏
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    appDelegate.isRotation = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
