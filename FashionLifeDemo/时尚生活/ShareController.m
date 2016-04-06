//
//  ShareController.m
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "ShareController.h"
#import "DetailTarentoViewCell.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "detailTarentoModel.h"
#import "ShareCommentViewController.h"
#import "MJRefresh.h"

@interface ShareController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)UICollectionView *collectionView;

@property(nonatomic, strong)NSMutableArray *modelArray;

@property(nonatomic, assign)BOOL isSelecate;

@end

int numberShare = 1;
int numberRowShare = 0;
@implementation ShareController

- (NSMutableArray *)modelArray
{
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.title = @"分享";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) collectionViewLayout:layOut];
    self.collectionView.backgroundColor = [UIColor darkGrayColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    
    [self.collectionView registerClass:[DetailTarentoViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:_collectionView];

    
    NSString *string = [NSString stringWithFormat:@"http://app.iliangcang.com/goods/class?type=100&app_key=Android&build=2015112301&count=20&page=1&self_host=0&v=1.0"];
    
    [self sessionDataTaskWithURLString:string];
    
    [self setupLeftMenuButton];
    [self.collectionView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerAction)];
    [self.collectionView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerAction)];
    
    [MBProgressHUD showMessage:@"loading..." toView:self.view];
    
}

- (void)headerAction
{
    [MBProgressHUD showMessage:@"loading..." toView:self.view];
    
    numberShare = 1;
    NSArray *array = @[@"100", @"1", @"2", @"20", @"3", @"4", @"5", @"7", @"10", @"9", @"23", @"8", @"15"];
    _modelArray = nil;
    for (int i = 0; i < array.count; i++) {
        if (numberRowShare == i) {
            NSString *string = [NSString stringWithFormat:@"http://app.iliangcang.com/goods/class?type=%@&app_key=Android&build=2015112301&count=20&page=1&self_host=0&v=1.0", array[i]];
            [self sessionDataTaskWithURLString:string];
        }
    }

    [self.collectionView reloadData];
    [self.collectionView.header endRefreshing];
}

- (void)footerAction
{
    numberShare++;
    NSArray *array = @[@"100", @"1", @"2", @"20", @"3", @"4", @"5", @"7", @"10", @"9", @"23", @"8", @"15"];

    for (int i = 0; i < array.count; i++) {
        if (numberRowShare == i) {
            NSString *string = [NSString stringWithFormat:@"http://app.iliangcang.com/goods/class?type=%@&app_key=Android&build=2015112301&count=20&page=%d&self_host=0&v=1.0", array[i], numberShare];
            [self sessionDataTaskWithURLString:string];
        }
    }

    [self.collectionView.footer endRefreshing];
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
    DetailTarentoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    detailTarentoModel *model = _modelArray[indexPath.row];
    
    cell.model = model;
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
     return CGSizeMake((self.view.frame.size.width - 50) / 2, (self.view.frame.size.width - 50) / 2);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 15, 5, 15);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShareCommentViewController *showCommentViewVc = [[ShareCommentViewController alloc]init];
    detailTarentoModel *model = _modelArray[indexPath.row];
    showCommentViewVc.detailModel = model;
    [self.navigationController pushViewController:showCommentViewVc animated:YES];
}

- (void)setupLeftMenuButton
{
 
//    MMDrawerBarButtonItem *leftDrawerButton = [[MMDrawerBarButtonItem alloc]initWithTarget:self action:@selector(leftDrawerButtonPress) withTitle:@"左边"];
    
    MMDrawerBarButtonItem *leftDrawerButton = [[MMDrawerBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iconfont-sanhengzongleimu (1)"] style:UIBarButtonItemStyleDone target:self action:@selector(leftDrawerButtonPress)];
    self.navigationItem.leftBarButtonItem = leftDrawerButton;
    
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}
- (void)reloadViewWithData:(NSNotification *)notification
{
    NSInteger *numberRow = (NSInteger *)[notification.object integerValue];
    
    NSArray *array = @[@"100", @"1", @"2", @"20", @"3", @"4", @"5", @"7", @"10", @"9", @"23", @"8", @"15"];
    numberRowShare = (int)numberRow;
    _modelArray = nil;
    numberShare = 1;
    for (int i = 0; i < array.count; i++) {
        if ((int)numberRow == i) {
            NSString *string = [NSString stringWithFormat:@"http://app.iliangcang.com/goods/class?type=%@&app_key=Android&build=2015112301&count=20&page=1&self_host=0&v=1.0", array[i]];
            [self sessionDataTaskWithURLString:string];
        }
    }
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"reloadShare" object:nil];
    _isSelecate = NO;
}
- (void)leftDrawerButtonPress
{
    
    _isSelecate = !_isSelecate;
    
    if (_isSelecate) {
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadViewWithData:) name:@"reloadShare" object:nil];
    }else
    {
        
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"reloadShare" object:nil];
    }
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


- (void)sessionDataTaskWithURLString:(NSString *)string
{
    [[[NSURLSession sharedSession]dataTaskWithURL:[NSURL URLWithString:string] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (data == nil) {
            return ;
        }
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        for (NSMutableDictionary *dataDic in dic[@"data"]) {
            
            detailTarentoModel *model = [[detailTarentoModel alloc]init];
            
            [model setValuesForKeysWithDictionary:dataDic];
            
            [self.modelArray addObject:model];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            [MBProgressHUD hideHUDForView:self.view];
        });
        
    }]resume];

    
}


- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}


//- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
//{
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
