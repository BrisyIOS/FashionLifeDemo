//
//  MovieShareSaveController.m
//  时尚生活
//
//  Created by zhangxu on 15/11/28.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "MovieShareSaveController.h"
#import "MovieTableViewCell.h"
#import "Header.h"
#import "MovieDetailController.h"
#import "DBSaveSqlite.h"
@interface MovieShareSaveController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)NSMutableArray *modelArray;

@end

@implementation MovieShareSaveController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"视频收藏";
    
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"arrow_25.6px_1155135_easyicon.net"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.backgroundColor = [UIColor darkGrayColor];
    [self.tableView registerClass:[MovieTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    
    self.modelArray = (NSMutableArray *)[DBSaveSqlite allMovieModelSave];
    
    
    if (_modelArray.count == 0) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight / 2 - 100, kScreenWidth, 40)];
        label.text = @"~~暂无收藏~~";
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
    return self.modelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenWidth / 750 * 421;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    MovieModel *model = _modelArray[indexPath.row];
    
    cell.model = model;
    cell.selectionStyle = NO;
    
    return cell;
}



- (void)reloadSuperView
{
    
    self.modelArray = (NSMutableArray *)[DBSaveSqlite allMovieModelSave];
    [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"reloadMovieView" object:nil];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadSuperView) name:@"reloadMovieView" object:nil];
    
    MovieDetailController *movieDetailVc = [[MovieDetailController alloc]init];
    MovieModel *model = _modelArray[indexPath.row];
    
    movieDetailVc.model = model;
    [self.navigationController pushViewController:movieDetailVc animated:YES];
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
