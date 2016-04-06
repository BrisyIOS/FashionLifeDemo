//
//  MovieDetailController.m
//  时尚生活
//
//  Created by zhangxu on 15/11/27.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "MovieDetailController.h"
#import "Header.h"
#import "UIImageView+WebCache.h"
#import "MovieDetailTableViewCell.h"
#import "MovieResumViewController.h"
#import "AppDelegate.h"
#import "UMSocial.h"

@interface MovieDetailController ()<UITableViewDataSource, UITableViewDelegate, UMSocialUIDelegate, UMSocialDataDelegate>

@property(nonatomic, strong)UITableView *tableView;

@end

@implementation MovieDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"视频详情";
    
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"arrow_25.6px_1155135_easyicon.net"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.backgroundColor = [UIColor darkGrayColor];
    [self.tableView registerClass:[MovieDetailTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];

    
    UIView *tapView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth / 750 * 421)];

    [self.view addSubview:tapView];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [tapView addGestureRecognizer:tap];
    
    [MBProgressHUD showMessage:@"loading..." toView:self.view];
    
}

- (void)tapAction:(UIGestureRecognizer *)tap
{
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    appDelegate.isRotation = YES;
    
    MovieResumViewController *moviePlayer = [[MovieResumViewController alloc]init];
    moviePlayer.model = _model;
    [self presentViewController:moviePlayer animated:YES completion:nil];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MovieDetailTableViewCell heightForCell:_model];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = _model;
    cell.selectionStyle = NO;
    cell.backgroundColor = [UIColor darkGrayColor];
    [cell.shareButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)shareButtonAction:(UIButton *)button
{
    NSLog(@"分享");
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    UIImage *imge = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.pimg]]];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5658406467e58ebfc9002494"
                                      shareText:[NSString stringWithFormat:@"%@ %@", self.model.title , self.model.video]
                                     shareImage:imge
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren, UMShareToDouban, nil]
                                       delegate:self];
    
    
    
    
}


- (void)didFinishGetUMSocialDataResponse:(UMSocialResponseEntity *)response
{
    if (response.responseCode == UMSResponseCodeSuccess) {
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)leftBarButtonAction:(UIBarButtonItem *)button
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadMovieView" object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"movieCachView" object:nil];
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
