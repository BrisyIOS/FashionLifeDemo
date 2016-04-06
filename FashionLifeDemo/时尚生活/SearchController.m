//
//  SearchController.m
//  时尚生活
//
//  Created by zhangxu on 15/11/28.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "SearchController.h"
#import "Header.h"
#import "SearchCell.h"
#import "SearchModel.h"
#import "ShowTarentoViewController.h"
@interface SearchController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UIView *searchView;
@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *searchArray;

@end

@interface SearchController ()

@end

@implementation SearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"搜索";
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"arrow_25.6px_1155135_easyicon.net"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    
    int height = 70;
    self.searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    self.searchView.backgroundColor = [UIColor darkGrayColor];
    
    // 添加搜索框
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    searchBar.placeholder = @"请输入关键词";
    self.searchBar = searchBar;
    [self.searchView addSubview:searchBar];
    
    // 添加搜索按钮
    [self buttonWithX:kScreenWidth/2 Y:40 + 30/2 Title:@"搜索良品"];
   
    [self.view addSubview:_searchView];
    
    
    int width = (kScreenWidth - 40)/2;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(width, width);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 20;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, kScreenHeight - 44 - 64) collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:_collectionView];
    
 
    // 注册cell
    [self.collectionView registerClass:[SearchCell class] forCellWithReuseIdentifier:@"search"];
    
    
    
}

#pragma mark - 快速创建button
- (UIButton *)buttonWithX:(CGFloat)x Y:(CGFloat)y Title:(NSString *)title{
    int width = kScreenWidth - 14;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.center = CGPointMake(x, y);
    button.bounds = CGRectMake(0, 0, width, 30);
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 8;
    button.backgroundColor = [UIColor darkGrayColor];
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor grayColor].CGColor;
    [button setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.searchView addSubview:button];
    return button;
}


#pragma mark - button 点击方法
- (void)searchClick:(UIButton *)button{
    NSString *title = [button titleForState:UIControlStateNormal];
    
    [self.view endEditing:YES];
    
    if ([title isEqualToString:@"搜索良品"]) {
        NSString *titleStr = [self.searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *url = [NSString stringWithFormat:@"http://app.iliangcang.com/search?app_key=Android&build=2015110402&count=18&keywords=%@&page=1&v=1.0",titleStr];
        [self setDataWithURL:url];
    }
}



#pragma mark - 解析数据
- (void)setDataWithURL:(NSString *)url{
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data, NSURLResponse * response, NSError *  error) {
        if (data == nil) {
            return ;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.searchArray = [SearchModel modelWithDic:dic];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
        
    }] resume];
}


#pragma mark - 返回多少分组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

#pragma mark - 返回多少行
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.searchArray.count;
}

#pragma mark - 返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SearchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"search" forIndexPath:indexPath];
    // 找到model
    SearchModel *searchModel = self.searchArray[indexPath.row];
    cell.searchModel = searchModel;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShowTarentoViewController *showTarentoViewVc = [[ShowTarentoViewController alloc]init];
    SearchModel *searchModel = self.searchArray[indexPath.row];
    showTarentoViewVc.modelString = searchModel.goods_id;
    
    [self.navigationController pushViewController:showTarentoViewVc animated:YES];
}

- (void)leftBarButtonAction:(UIBarButtonItem *)button
{
    if (_isPush) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}
@end
