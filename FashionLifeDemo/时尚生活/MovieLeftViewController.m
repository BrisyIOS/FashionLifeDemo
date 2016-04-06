//
//  MovieLeftViewController.m
//  时尚生活
//
//  Created by zhangxu on 15/11/27.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "MovieLeftViewController.h"
#import "MovieSetTableViewCell.h"
#import "Header.h"
#import "ShareLeftModel.h"
#import "MovieWebViewController.h"
#import "SDImageCache.h"
#import "MovieShareSaveController.h"
#import "ShareSaveViewController.h"
#import "MovieCachViewController.h"
@interface MovieLeftViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)MovieSetTableViewCell *cell;

@property(nonatomic, strong)NSMutableArray *modelArray;

@end

@implementation MovieLeftViewController


- (void)setModel
{
    _modelArray = [NSMutableArray array];
    NSArray *array = @[@"我的分享收藏", @"我的达人收藏", @"我的视频收藏", @"视频偏好设置", @"我的缓存", @"清除缓存"];
    
    for (int i = 0; i < array.count; i++) {
        ShareLeftModel *model = [[ShareLeftModel alloc]init];
        model.nameString = array[i];
        [_modelArray addObject:model];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"我的";
    
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"arrow_25.6px_1155135_easyicon.net"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    
    
    
    [self setModel];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.backgroundColor = [UIColor darkGrayColor];
    [self.tableView registerClass:[MovieSetTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    ShareLeftModel *model = _modelArray[indexPath.row];
    
    NSArray *array = @[@"iconfont-fenxiang-9",@"iconfont-gezicopwujiaoxing4",@"iconfont-shipin_10",@"iconfont-shezhi",@"iconfont-huancunmy",@"iconfont-qingchuhuancun"];

    self.cell.selectionStyle = NO;
    self.cell.firstImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", array[indexPath.row]]];
    self.cell.titleLabel.text = model.nameString;
    self.cell.backgroundColor = [UIColor darkGrayColor];
    
    
    if (model.isSelect) {
        self.cell.titleLabel.textColor = [UIColor cyanColor];
        self.cell.backgroundColor = [UIColor blackColor];
    }else
    {
        self.cell.titleLabel.textColor = [UIColor whiteColor];
        self.cell.backgroundColor = [UIColor darkGrayColor];
    }

    return _cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (ShareLeftModel *model in self.modelArray) {
        model.isSelect = NO;
    }
    
    
    for (MovieSetTableViewCell *cell in tableView.visibleCells) {
        cell.titleLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor darkGrayColor];
    }
    
    ShareLeftModel *model = _modelArray[indexPath.row];
    
    model.isSelect = YES;
    
    if (0 == indexPath.section) {
        [self buttonActionForUserSetting:self];
    }
    
    
    if (indexPath.row == 3) {
        
        MovieWebViewController *movieWebView = [[MovieWebViewController alloc]init];
        [self.navigationController pushViewController:movieWebView animated:YES];
    }else if (indexPath.row == 5)
    {
        [[SDImageCache sharedImageCache]clearDisk];
   
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"清除缓存成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else if (indexPath.row == 2)
    {
        MovieShareSaveController *movieShare = [[MovieShareSaveController alloc]init];
        [self.navigationController pushViewController:movieShare animated:YES];
    }else if (indexPath.row == 0){
        ShareSaveViewController  *shareSave = [[ShareSaveViewController alloc]init];
        [self.navigationController pushViewController:shareSave animated:YES];
    }else if (indexPath.row == 1){
        ShareSaveViewController *shareSave = [[ShareSaveViewController alloc]init];
        shareSave.isShare = YES;
        [self.navigationController pushViewController:shareSave animated:YES];
    }else if (indexPath.row == 4){
        
        MovieCachViewController *movieCachVc = [[MovieCachViewController alloc]init];
        [self.navigationController pushViewController:movieCachVc animated:YES];
    }
}

- (void)buttonActionForUserSetting:(id)set
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    self.cell = (MovieSetTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    self.cell.titleLabel.textColor = [UIColor cyanColor];
    self.cell.backgroundColor = [UIColor blackColor];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
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
