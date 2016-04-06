//
//  ShareSaveViewController.m
//  时尚生活
//
//  Created by zhangxu on 15/11/28.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "ShareSaveViewController.h"
#import "DetailTarentoViewCell.h"
#import "DBSaveSqlite.h"
#import "detailTarentoModel.h"
#import "ShareCommentViewController.h"
#import "TarentoCollectionViewCell.h"
#import "TarentoModel.h"
#import "DetailTarentoViewController.h"
#import "Header.h"
@interface ShareSaveViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>


@property(nonatomic, strong)UICollectionView *collectionView;

@property(nonatomic, strong)NSMutableArray *modelArray;

@end

@implementation ShareSaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"arrow_25.6px_1155135_easyicon.net"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    
    
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) collectionViewLayout:layOut];
    self.collectionView.backgroundColor = [UIColor darkGrayColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.view addSubview:_collectionView];
    
    if (_isShare) {
        self.navigationItem.title = @"达人收藏";

        [self.collectionView registerClass:[TarentoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        self.modelArray = (NSMutableArray *)[DBSaveSqlite allTarentoModelSave];
        
        if (_modelArray.count == 0) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight / 2 - 100, kScreenWidth, 40)];
            label.text = @"~~暂无收藏~~";
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont boldSystemFontOfSize:20];
            [self.view addSubview:label];
        }
        
        
    }else
    {
        self.navigationItem.title = @"分享收藏";

        [self.collectionView registerClass:[DetailTarentoViewCell class] forCellWithReuseIdentifier:@"cell"];
        self.modelArray = (NSMutableArray *)[DBSaveSqlite allShareModelSave];
        
        
        if (_modelArray.count == 0) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight / 2 - 100, kScreenWidth, 40)];
            label.text = @"~~暂无收藏~~";
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont boldSystemFontOfSize:20];
            [self.view addSubview:label];
        }
        
    }
}

- (void)leftBarButtonAction:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _modelArray.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    if (_isShare) {
        TarentoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        TarentoModel *model = _modelArray[indexPath.row];
        
        cell.model = model;
        return cell;
    }else
    {
        DetailTarentoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        detailTarentoModel *model = _modelArray[indexPath.row];
        
        cell.model = model;
        return cell;
    }
}

- (void)reloadSuperView
{
    
    if (_isShare) {
        self.modelArray = (NSMutableArray *)[DBSaveSqlite allTarentoModelSave];
    }else
    {
        self.modelArray = (NSMutableArray *)[DBSaveSqlite allShareModelSave];
    }

    
    [self.collectionView reloadData];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"reloadSuperView" object:nil];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isShare) {
        
        return CGSizeMake((self.view.frame.size.width - 50) / 3 , (self.view.frame.size.width - 50) / 3 + 40);
        
    }else
    {
        return CGSizeMake((self.view.frame.size.width - 50) / 2, (self.view.frame.size.width - 50) / 2);
    }
    
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    if (_isShare) {
        
        return UIEdgeInsetsMake(15, 10, 5, 10);
        
    }else
    {
        return UIEdgeInsetsMake(15, 15, 5, 15);
    }
    
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadSuperView) name:@"reloadSuperView" object:nil];

    if (_isShare) {
        
        DetailTarentoViewController *detailTarentoViewVc = [[DetailTarentoViewController alloc]init];
        TarentoModel *model = _modelArray[indexPath.row];
        
        detailTarentoViewVc.tarentoModel = model;
        [self.navigationController pushViewController:detailTarentoViewVc animated:YES];
        
    }else
    {
        ShareCommentViewController *showCommentViewVc = [[ShareCommentViewController alloc]init];
        detailTarentoModel *model = _modelArray[indexPath.row];
        
        showCommentViewVc.detailModel = model;
        [self.navigationController pushViewController:showCommentViewVc animated:YES];
    }
    
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
