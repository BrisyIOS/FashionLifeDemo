//
//  MagazineDetailController.m
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "MagazineDetailController.h"
#import "MagazineDetailCell.h"
#import "MagazineDetailModel.h"
#import "MagazineItem.h"
#import "DIYButton.h"
#import "Header.h"
#import "MagazineController.h"


@interface MagazineDetailController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tArray;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *cArray;


@end

static NSString *tCellIdentifier = @"cell";
static NSString *itemIdentifier = @"item";

@implementation MagazineDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 创建上面的分类和作者btn
    [self createBtn];
    
    // 创建下面的View
    [self creatDownView];
    
    
    if (self.isAuthor) {
        [self createTableView];
        self.isAuthor = NO;
    } else {
        [self createCollectionView];
    }
   
}

#pragma mark -- 创建Button --
- (void)createBtn
{
    // 分类
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, (kScreenWidth-20)/2-5, 44);
    [leftBtn setTitle:@"分类" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [leftBtn addTarget:self action:@selector(leftBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    // 作者
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(leftBtn.frame.size.width+20, 0, (kScreenWidth-20)/2-5, 44);
    [rightBtn setTitle:@"作者" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
}
#pragma mark -- 分类 --
- (void)leftBtn:(UIButton *)btn
{
    [self createCollectionView];
}
#pragma mark -- 作者 --
- (void)rightBtn:(UIButton *)btn
{
    // 创建tableView
    [self createTableView];
}
#pragma mark -- 创建下面的View --
- (void)creatDownView
{
    UIView *downView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-44, kScreenWidth, 44)];
    downView.backgroundColor = [UIColor blackColor];
    
    DIYButton *backBtn = [[DIYButton alloc] initWithFrame:CGRectMake((kScreenWidth-100)/2, 7, 100, 30)];
    backBtn.tlLabel.text = @"杂志";
    backBtn.tlLabel.textColor = [UIColor whiteColor];
    backBtn.iconImageView.image = [UIImage imageNamed:@"up"];
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [downView addSubview:backBtn];
    [self.view addSubview:downView];
}
#pragma mark -- 返回 --
- (void)backBtnAction
{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark ----------------- tableView ----------------------
#pragma mark -- 创建tableView --
- (void)createTableView
{
    if (self.tableView) {
        [self.tableView removeFromSuperview];
    }
    if (self.tArray) {
        [self.tArray removeAllObjects];
    }
    
    // 请求数据
    [self getTableView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-44) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = (kScreenHeight-64-44)/7;
    [self.tableView registerClass:[MagazineDetailCell class] forCellReuseIdentifier:tCellIdentifier];
    [self.view addSubview:self.tableView];
}
#pragma mark -- 请求tableView的数据 --
- (void)getTableView
{
    // 数据请求解析
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"http://app.iliangcang.com/topic/listauthor?app_key=Android&build=2015110402&v=1.0"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (data == nil) {
            return ;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        self.tArray = [NSMutableArray array];
        for (NSDictionary *dataDic in dic[@"data"]) {
            MagazineDetailModel *model = [[MagazineDetailModel alloc] init];
            [model setValuesForKeysWithDictionary:dataDic];
            [self.tArray addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            
        });
    }];
    [dataTask resume];
    
}
#pragma mark -- 返回cell个数 --
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tArray.count;
}
#pragma mark -- 返回cell --
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MagazineDetailModel *model = self.tArray[indexPath.row];
    MagazineDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:tCellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[MagazineDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tCellIdentifier];
    }
    [cell setModel:model];
    return cell;
}
#pragma mark -- 点击cell --
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.hidesBottomBarWhenPushed = YES;
    MagazineDetailModel *model = self.tArray[indexPath.row];

    MagazineController *magazineVc = [[MagazineController alloc] initWithStyle:UITableViewStylePlain];
    magazineVc.isAuthor = YES;
    magazineVc.author_name = model.author_name;
    magazineVc.url = [NSString stringWithFormat:@"http://app.iliangcang.com/topic/listinfo?app_key=Android&author_id=%@&build=2015110402&v=1.0", model.author_id];
    
    [self.navigationController pushViewController:magazineVc animated:NO];
    self.hidesBottomBarWhenPushed = NO;
    
}

#pragma mark ----------------- collectionView ----------------------

#pragma mark -- 创建collectionView --
- (void)createCollectionView
{
    if (self.collectionView) {
        [self.collectionView removeFromSuperview];
    }
    if (self.cArray) {
        [self.cArray removeAllObjects];
    }
    
    // 数据请求
    [self getCollectionView];
    
    // 创建collectionView
    CGFloat width = (kScreenWidth - 60)/2;
    CGFloat height = (kScreenHeight-64-44)/5;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(width, height);
    layout.minimumInteritemSpacing = 20;
    layout.minimumLineSpacing = 20;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-44) collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor colorWithRed:244/255.5 green:244/255.0 blue:244/255.0 alpha:1];
    [self.collectionView registerClass:[MagazineItem class] forCellWithReuseIdentifier:itemIdentifier];
    [self.view addSubview:self.collectionView];
}
#pragma mark -- 返回Item的个数 --
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.cArray.count;
}
#pragma mark -- 返回item --
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MagazineItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:itemIdentifier forIndexPath:indexPath];
    MagazineDetailModel *model = self.cArray[indexPath.row];
    [item setModel:model];
    return item;
}
#pragma mark -- 点击iten --
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.hidesBottomBarWhenPushed = YES;
    MagazineDetailModel *model = self.cArray[indexPath.row];
    MagazineController *magazineVc = [[MagazineController alloc] initWithStyle:UITableViewStylePlain];
    magazineVc.isClassify = YES;
    magazineVc.cat_name = model.cat_name;
    magazineVc.url = [NSString stringWithFormat:@"http://app.iliangcang.com/topic/listinfo?app_key=Android&build=2015110402&cat_id=%@&v=1.0", model.cat_id];
    [self.navigationController pushViewController:magazineVc animated:NO];
    self.hidesBottomBarWhenPushed = NO;
}
#pragma mark -- 返回Item距离边框的距离 --
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 20, 20, 20);
}
#pragma mark -- 请求collection的数据 --
- (void)getCollectionView
{
    // 数据请求解析
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"http://app.iliangcang.com/topic/listcat?app_key=Android&build=2015110402&v=1.0"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data == nil) {
            return ;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        self.cArray = [NSMutableArray array];
        for (NSDictionary *dataDic in dic[@"data"]) {
            MagazineDetailModel *model = [[MagazineDetailModel alloc] init];
            [model setValuesForKeysWithDictionary:dataDic];
            [self.cArray addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.collectionView reloadData];
        });
    }];
    [dataTask resume];

}

@end
