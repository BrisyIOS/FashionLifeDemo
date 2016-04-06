//
//  MovieCachViewController.m
//  时尚生活
//
//  Created by zhangxu on 15/11/28.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "MovieCachViewController.h"
#import "Header.h"
#import "DownloadMovieTableViewCell.h"
#import "DBCacheSqlite.h"
#import "DBDownloadSqlite.h"
#import "MovieModel.h"
#import "DownloadMovie.h"
#import "DownloadManagment.h"
#import "UIImageView+WebCache.h"
#import "MovieDetailController.h"
#import "MovieViewController.h"

@interface MovieCachViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong)UITableView *tableView;

@end

@implementation MovieCachViewController
{
    BOOL _isSelect;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的缓存";
    
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"arrow_25.6px_1155135_easyicon.net"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    
    
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iconfont-shanchu"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonAction:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];

    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.backgroundColor = [UIColor darkGrayColor];
    [self.tableView registerClass:[DownloadMovieTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    
    
    if ([DBCacheSqlite allCacheing].count == 0 && [DBCacheSqlite allCacheFinish].count == 0) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight / 2 - 100, kScreenWidth, 40)];
        label.text = @"~~暂无缓存~~";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:20];
        [self.view addSubview:label];
    }
}

- (void)leftBarButtonAction:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section == 0) {
    return [DBCacheSqlite allCacheing].count;
//    }else
//    {
//        return [DBCacheSqlite allCacheFinish].count;
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenWidth / 750 * 421;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DownloadMovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
     MovieModel *model = [DBCacheSqlite allCacheing][indexPath.row];
    
    if ([DBDownloadSqlite findDownloadingWithURL:model.video]) {
        cell.tag = indexPath.row;
        cell.button.hidden = NO;
        cell.cacheLabel.hidden = YES;
        cell.blackView.hidden = NO;
        cell.backView.hidden = YES;
        cell.detailLabel.hidden = NO;
        cell.titleLabel.text = model.title;
                [cell.myImageView sd_setImageWithURL:[NSURL URLWithString:model.pimg]];
        
        if (_isSelect) {
            cell.deleteButton.hidden = NO;
            cell.button.hidden = YES;
            
        }else
        {
            cell.deleteButton.hidden = YES;
            cell.button.hidden = NO;
        }
        DownloadMovie *download = [[DownloadManagment shareDownloadManagment]findDownloadWithURL:model.video];
        
        if ([DBDownloadSqlite findDownloadingWithURL:model.video].isResume == 1) {
            cell.detailLabel.text = [NSString stringWithFormat:@"已暂停  %d%%", (int)[DBDownloadSqlite findDownloadingWithURL:model.video].progress];
            cell.blackView.frame = CGRectMake(0, 0,self.view.frame.size.width *[DBDownloadSqlite findDownloadingWithURL:model.video].progress / 100 , kScreenWidth / 750 * 421);
            
            cell.button.selected = YES;
        }else if ([DBDownloadSqlite findDownloadingWithURL:model.video].isResume == 0)
        {
            
            cell.detailLabel.text = [NSString stringWithFormat:@"正在缓存  %d%%", (int)[DBDownloadSqlite findDownloadingWithURL:model.video].progress];
            cell.blackView.frame = CGRectMake(0, 0,self.view.frame.size.width *[DBDownloadSqlite findDownloadingWithURL:model.video].progress / 100 , kScreenWidth / 750 * 421);
            cell.button.selected = NO;
        }
        
        [download downloadFinish:^(NSString *savePath, NSString *url) {
            cell.detailLabel.text = [NSString stringWithFormat:@"已经缓存"];
            
            [self.tableView reloadData];
        } downloading:^(float progress, float byesWritten) {
            
            if (cell.tag == indexPath.row) {
                MovieModel *model = [DBCacheSqlite allCacheing][indexPath.row];
                
                if ([DBDownloadSqlite findDownloadingWithURL:model.video]) {
                    
                    
                    cell.detailLabel.text = [NSString stringWithFormat:@"正在缓存  %d%%",(int)[DBDownloadSqlite findDownloadingWithURL:model.video].progress];
                    NSLog(@"%f", [DBDownloadSqlite findDownloadingWithURL:model.video].progress);
                    
                    cell.blackView.frame = CGRectMake(0, 0, self.view.frame.size.width * (int)[DBDownloadSqlite findDownloadingWithURL:model.video].progress / 100, kScreenWidth / 750 * 421);
                }
                
            }
        }];

    }else
    {
        cell.titleLabel.text = model.title;
        [cell.myImageView sd_setImageWithURL:[NSURL URLWithString:model.pimg]];
        
        cell.detailLabel.hidden = YES;
        cell.blackView.hidden = YES;
        cell.cacheLabel.hidden = NO;
        cell.cacheLabel.text = @"已经缓存";
        cell.button.hidden = YES;
        cell.backView.hidden = NO;
        if (_isSelect) {
            cell.deleteButton.hidden = NO;
            cell.button.hidden = YES;
            
        }else
        {
            cell.deleteButton.hidden = YES;
            cell.button.hidden = YES;
        }
    }
    
    cell.button.tag = indexPath.row;
    [cell.button addTarget:self action:@selector(cellButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    
    cell.deleteButton.tag = indexPath.row;
    [cell.deleteButton addTarget:self action:@selector(downloadFinishButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.backgroundColor = [UIColor darkGrayColor];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadMovieCacheView) name:@"movieCachView" object:nil];
    
    MovieDetailController *movieDetailVc = [[MovieDetailController alloc]init];
    
    MovieModel *model =[DBCacheSqlite allCacheing][indexPath.row];
    DownloadManagentFinish *finishModel = [DBDownloadSqlite findDownloadFinishWithURL:model.video];
    
    model.savePath = finishModel.savePath;
    
    movieDetailVc.model = model;
    
    [self.navigationController pushViewController:movieDetailVc animated:YES];
}

- (void)reloadMovieCacheView
{
    [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"movieCachView" object:nil];
}


- (void)cellButtonAction:(UIButton *)button
{
    for (int i = 0; i < [DBCacheSqlite allCacheing].count; i++) {
        if (button.tag == i) {
            button.selected = !button.selected;
            
            MovieModel *model = [DBCacheSqlite allCacheing][i];
            DownloadMovie *download = [[DownloadManagment shareDownloadManagment]addDownloadWithURL:model.video];
            
            if ([DBDownloadSqlite findDownloadingWithURL:model.video].isResume == 1 ) {
                [download resume];
                [DBDownloadSqlite updateDownloadState:NO withURL:model.video];
            }else if ([DBDownloadSqlite findDownloadingWithURL:model.video].isResume == 0)
            {
                [download suspend];
                [DBDownloadSqlite updateDownloadState:YES withURL:model.video];
            }
        }
    }
    [self.tableView reloadData];
}

- (void)rightButtonAction:(UIButton *)button
{
    _isSelect = !_isSelect;
    
    [self.tableView reloadData];
}

- (void)downloadFinishButtonAction:(UIButton *)button
{
    for (int i = 0; i < [DBCacheSqlite allCacheing].count; i++) {
        if (button.tag == i) {
            MovieModel *model = [DBCacheSqlite allCacheing][i];
            
            if ([DBDownloadSqlite findDownloadingWithURL:model.video]) {
                DownloadMovie *download = [[DownloadManagment shareDownloadManagment]addDownloadWithURL:model.video];
                if ([DBDownloadSqlite findDownloadingWithURL:model.video].isResume == 0) {
                    [download suspend];
                    
                    [DBDownloadSqlite updateDownloadState:YES withURL:model.video];
                }
                
                [DBDownloadSqlite deleteDownloadingWithURL:model.video];
                [DBCacheSqlite deleteCacheingWithURL:model.video];
            }else
            {
                
                DownloadManagentFinish *finishModel = [DBDownloadSqlite findDownloadFinishWithURL:model.video];
                
                [DBDownloadSqlite deleteDownloadFinishWithURL:model.video];
                [DBCacheSqlite deleteCacheingWithURL:model.video];
                NSFileManager *fm =   [NSFileManager defaultManager];
                [fm removeItemAtPath:finishModel.savePath error:nil];
            }
        }
    }
    
    [self.tableView reloadData];
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
