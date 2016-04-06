//
//  LeftShareViewController.m
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "LeftShareViewController.h"
#import "ShareLeftModel.h"
#import "TarentoTableViewCell.h"
#import "SearchController.h"
#import "Header.h"
@interface LeftShareViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)TarentoTableViewCell *cell;

@property(nonatomic, strong)NSMutableArray *modelArrary;

@end

@implementation LeftShareViewController

- (void)setModel
{
    _modelArrary = [NSMutableArray array];
    NSArray *array = @[@"全部", @"男士", @"女士", @"家居", @"数码", @"工具", @"玩具", @"美容", @"孩子", @"宠物", @"运动", @"饮食", @"文化"];
    
    for (int i = 0; i < array.count; i++) {
        ShareLeftModel *model = [[ShareLeftModel alloc]init];
        model.nameString = array[i];
        [_modelArrary addObject:model];
    }
    
}

- (void)setViewSearch
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 20, 240, 40)];
    view.layer.cornerRadius = 5;
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 100, 40)];
    nameLabel.text = @"搜索时尚";
    nameLabel.font = [UIFont systemFontOfSize:16];
    [view addSubview:nameLabel];
    
    UIImageView *myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(68, 8, 24, 24)];
    myImageView.image = [UIImage imageNamed:@"iconfont-sousuo"];
    [view addSubview:myImageView];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [view addGestureRecognizer:tap];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    [self setModel];
    
    [self setViewSearch];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, 250, 13 * kScreenHeight/16.67 - 50) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor darkGrayColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    [self.tableView registerClass:[TarentoTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_tableView];
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    SearchController *searchViewVc = [[SearchController alloc]init];
    UINavigationController *searchViewNav = [[UINavigationController alloc]initWithRootViewController:searchViewVc];
    searchViewVc.isPush = YES;
    [self presentViewController:searchViewNav animated:YES completion:nil];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _modelArrary.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenHeight/13.34;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    

    ShareLeftModel *model = _modelArrary[indexPath.row];
    
    self.cell.selectionStyle = NO;
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
    for (ShareLeftModel *model in self.modelArrary) {
        model.isSelect = NO;
    }
    
    
    for (TarentoTableViewCell *cell in tableView.visibleCells) {
        cell.titleLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor darkGrayColor];
    }
    
    ShareLeftModel *model = _modelArrary[indexPath.row];
    
    model.isSelect = YES;
    
    if (0 == indexPath.section) {
        [self buttonActionForUserSetting:self];
    }
    
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadShare" object:[NSNumber numberWithInteger:indexPath.row]];
}


- (void)buttonActionForUserSetting:(id)set
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    self.cell = (TarentoTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    self.cell.titleLabel.textColor = [UIColor cyanColor];
    self.cell.backgroundColor = [UIColor blackColor];
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
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
