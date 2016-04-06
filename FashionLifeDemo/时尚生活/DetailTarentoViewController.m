//
//  DetailTarentoViewController.m
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "DetailTarentoViewController.h"
#import "TarentoCollectionViewCell.h"
#import "DetailTarentoReusableView.h"
#import "DetailTarentoViewCell.h"
#import "detailTarentoModel.h"
#import "UIImageView+WebCache.h"
#import "DetailCountModel.h"
#import "ShowTarentoViewController.h"
#import "ShareCommentViewController.h"
#import "MJRefresh.h"
#import "CommonActivityIndicatorView.h"
@interface DetailTarentoViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) CommonActivityIndicatorView *activityView;
@property(nonatomic, strong)UICollectionView *collectiomView;
@property(nonatomic, strong)NSMutableArray *followingArray;
@property(nonatomic, strong)NSMutableArray *countArray;
@property(nonatomic, assign)NSInteger number;


@end

int detailNumber = 1;

@implementation DetailTarentoViewController

- (NSMutableArray *)followingArray
{
    if (!_followingArray) {
        _followingArray = [NSMutableArray array];
    }
    return _followingArray;
}

- (NSMutableArray *)countArray
{
    if (!_countArray) {
        _countArray = [NSMutableArray array];
    }
    return _countArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationItem.title = _tarentoModel.user_name;
    
//    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"arrow_25.6px_1155135_easyicon.net"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonAction:)];

    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    self.collectiomView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) collectionViewLayout:layout];
    self.collectiomView.dataSource = self;
    self.collectiomView.delegate = self;
    self.collectiomView.backgroundColor = [UIColor darkGrayColor];
    
    [self.collectiomView registerClass:[TarentoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.collectiomView registerClass:[DetailTarentoViewCell class] forCellWithReuseIdentifier:@"detailCell"];
    
    [self.collectiomView registerClass:[DetailTarentoReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    
    [self.view addSubview:_collectiomView];
    
    _number = 200;
    
    NSString *UrlString = [NSString stringWithFormat:@"http://app.iliangcang.com/user/recommendation?app_key=Android&build=2015110402&count=18&owner_id=%@&page=1&v=1.0", _tarentoModel.user_id];
    [self sessionDataTaskWithURLString:UrlString];
    
    
    [self.collectiomView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerAction)];
    [self.collectiomView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerAction)];
    

    self.activityView = [[CommonActivityIndicatorView alloc] init];
    [self.view addSubview:_activityView];
}

- (void)headerAction
{
    
    detailNumber = 1;
    _followingArray = nil;
    NSString *UrlString = [NSString stringWithFormat:@"http://app.iliangcang.com/user/followed?app_key=Android&build=2015110402&count=18&owner_id=%@&page=1&v=1.0", _tarentoModel.user_id];
    [self sessionDataTaskWithURLString:UrlString];
    
    [self.collectiomView reloadData];
    [self.collectiomView.header endRefreshing];
}

- (void)footerAction
{

    if (_number == 400) {
        detailNumber++;
        NSString *UrlString = [NSString stringWithFormat:@"http://app.iliangcang.com/user/followed?app_key=Android&build=2015110402&count=18&owner_id=%@&page=%d&v=1.0", _tarentoModel.user_id, detailNumber];
        [self sessionDataTaskWithURLString:UrlString];
    }
    
    [self.collectiomView.footer endRefreshing];
}

- (void)leftBarButtonAction:(UIBarButtonItem *)button
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadSuperView" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _followingArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_number == 100 || _number == 200) {
        
        DetailTarentoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"detailCell" forIndexPath:indexPath];
      
        cell.model = _followingArray[indexPath.row];
        
        return cell;
        
    }else
    {
     
        TarentoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        
        cell.model = _followingArray[indexPath.row];
        
        
        return cell;
    }
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    DetailTarentoReusableView *detailTarentoHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
    detailTarentoHeader.model = _tarentoModel;

    detailTarentoHeader.detailModel = _countArray.firstObject;
    
    [detailTarentoHeader.buttonFour addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [detailTarentoHeader.buttonThree addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [detailTarentoHeader.buttonTwo addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [detailTarentoHeader.buttonOne addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    return detailTarentoHeader;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.view.frame.size.width, 150);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_number == 100 || _number == 200) {
        
        return CGSizeMake((self.view.frame.size.width - 40) / 2, (self.view.frame.size.width - 40) / 2);
        
    }else
    {
        return CGSizeMake((self.view.frame.size.width - 50) / 3 , (self.view.frame.size.width - 50) / 3 + 40);
    }
    
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
 
    return UIEdgeInsetsMake(15, 10, 5, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_number == 300 || _number == 400) {
        
        TarentoModel *model = _followingArray[indexPath.row];
        DetailTarentoViewController *detailTarentoViewVc = [[DetailTarentoViewController alloc]init];
        detailTarentoViewVc.tarentoModel = model;
        [self.navigationController pushViewController:detailTarentoViewVc animated:YES];
    }else if (_number == 200)
    {
        ShareCommentViewController *showCommentViewVc = [[ShareCommentViewController alloc]init];
        
        detailTarentoModel *model = _followingArray[indexPath.row];
        showCommentViewVc.detailModel = model;
        [self.navigationController pushViewController:showCommentViewVc animated:YES];
    }
    else
    {
        ShowTarentoViewController *showTarentoViewVc = [[ShowTarentoViewController alloc]init];
        detailTarentoModel *model = _followingArray[indexPath.row];
        showTarentoViewVc.detailModel = model;
        [self.navigationController pushViewController:showTarentoViewVc animated:YES];
    }
}

- (void)buttonAction:(UIButton *)button
{
    self.followingArray = nil;
    detailNumber = 1;
    if (button.tag == 100) {

        _number = 100;
        NSString *UrlString = [NSString stringWithFormat:@"http://app.iliangcang.com/user/like?app_key=Android&build=2015110402&count=18&owner_id=%@&page=1&v=1.0", _tarentoModel.user_id];
        [self sessionDataTaskWithURLString:UrlString];
        
    }else if (button.tag == 200){

        _number = 200;
        NSString *UrlString = [NSString stringWithFormat:@"http://app.iliangcang.com/user/recommendation?app_key=Android&build=2015110402&count=18&owner_id=%@&page=1&v=1.0", _tarentoModel.user_id];
        [self sessionDataTaskWithURLString:UrlString];
        
    }else if (button.tag == 300){

        _number = 300;
        
        NSString *UrlString = [NSString stringWithFormat:@"http://app.iliangcang.com/user/following?app_key=Android&build=2015110402&count=18&owner_id=%@&page=1&v=1.0", _tarentoModel.user_id];
        [self sessionDataTaskWithURLString:UrlString];
    }else if (button.tag == 400){
        
        _number = 400;
        
        NSString *UrlString = [NSString stringWithFormat:@"http://app.iliangcang.com/user/followed?app_key=Android&build=2015110402&count=18&owner_id=%@&page=1&v=1.0", _tarentoModel.user_id];
        [self sessionDataTaskWithURLString:UrlString];
    }
}

- (void)sessionDataTaskWithURLString:(NSString *)string
{
   
    [[[NSURLSession sharedSession]dataTaskWithURL:[NSURL URLWithString:string] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (data == nil) {
            return ;
        }
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSMutableDictionary *dataDic = dic[@"data"];
    
        DetailCountModel *model = [[DetailCountModel alloc]init];
        
        [model setValuesForKeysWithDictionary:dataDic];
        
        [self.countArray addObject:model];
        
        if (_number == 100 || _number == 200) {
            
            for (NSMutableDictionary *userDic in dataDic[@"goods"]) {
                
                detailTarentoModel *model = [[detailTarentoModel alloc]init];
 
                [model setValuesForKeysWithDictionary:userDic];
                [self.followingArray addObject:model];

            }

        }else if (_number == 300 || _number == 400){
            
            for (NSMutableDictionary *userDic in dataDic[@"users"]) {
                
                TarentoModel *model = [[TarentoModel alloc]init];
                [model setValuesForKeysWithDictionary:userDic];
                [self.followingArray addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectiomView reloadData];
            [self.activityView endCommonActivity];
        });
    }]resume];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}


//- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
//    [UIView animateWithDuration:0.25 animations:^{
//        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
//    }];
//}

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
