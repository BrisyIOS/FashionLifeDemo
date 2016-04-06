//
//  MovieViewController.m
//  时尚生活
//
//  Created by zhangxu on 15/11/27.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieTableViewCell.h"
#import "Header.h"
#import "MovieModel.h"
#import "MovieDetailController.h"
#import "MJRefresh.h"
#import "MovieLeftViewController.h"

@interface MovieViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)NSMutableArray *movieArray;

@end


NSInteger numberRefresh = 1;
@implementation MovieViewController

- (NSMutableArray *)movieArray
{
    if (!_movieArray) {
        _movieArray = [NSMutableArray array];
    }
    return _movieArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"视频";
    
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iconfont-shezhi-2"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.backgroundColor = [UIColor darkGrayColor];
    [self.tableView registerClass:[MovieTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    
    
    for (int i = 1; i < 4; i++ ) {
        [self getPostRequestUrlChannel:i];
    }
    
    [MBProgressHUD showMessage:@"loading..." toView:self.view];
    
    
}

- (void)rightBarButtonAction:(UIBarButtonItem *)barButton
{
    MovieLeftViewController *movieWebVc =[[MovieLeftViewController alloc]init];
    
    [self.navigationController pushViewController:movieWebVc animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.movieArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenWidth / 750 * 421;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    MovieModel *model = _movieArray[indexPath.row];
    
    cell.model = model;
    cell.selectionStyle = NO;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieDetailController *movieDetailVc = [[MovieDetailController alloc]init];
    MovieModel *model = _movieArray[indexPath.row];
    
    movieDetailVc.model = model;
    [self.navigationController pushViewController:movieDetailVc animated:YES];
}

- (void)getPostRequestUrlChannel:(NSInteger)Channel
{
    NSString *UrlString = @"http://magicapi.vmovier.com/magicapi/find";
    NSString *postString = [NSString stringWithFormat:@"json=1&p=%ld", (long)Channel];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:UrlString]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSession *sesson = [NSURLSession sessionWithConfiguration:configuration];
    [[sesson dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data == nil) {
            return ;
        }
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        for (NSMutableDictionary *dataDic in dic[@"data"]) {
            MovieModel *model = [[MovieModel alloc]init];
            NSMutableArray *backuplinkArray = dataDic[@"backuplink"];
            if (backuplinkArray.count != 0) {
                NSMutableArray *backuplinkArrayOne = backuplinkArray.firstObject;
                NSMutableDictionary *backuplinkDic = backuplinkArrayOne.firstObject;
                [model setValuesForKeysWithDictionary:dataDic];
                [model setValuesForKeysWithDictionary:backuplinkDic];
                [self.movieArray addObject:model];
            }

            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_movieArray.count == 30) {
                [self.tableView reloadData];
            }
        });
        
    }] resume];
    
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    [UIView animateWithDuration:0.25 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
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
