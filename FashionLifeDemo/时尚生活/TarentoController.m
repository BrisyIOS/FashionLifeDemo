//
//  TarentoController.m
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "TarentoController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "TarentoCollectionViewCell.h"
#import "TarentoModel.h"
#import "DetailTarentoViewController.h"
#import "MJRefresh.h"
#import "CommonActivityIndicatorView.h"
@interface TarentoController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong)UICollectionView *collectionView;

@property(nonatomic, strong)NSMutableArray *modelArray;

@property(nonatomic, assign)BOOL isSelecate;

@property(nonatomic, assign)BOOL isRefresh;

@property (nonatomic,strong) CommonActivityIndicatorView *activityView;

@end
int number = 1;
int numberRowStay = 0;
@implementation TarentoController

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
//    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationItem.title = @"达人";

    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) collectionViewLayout:layOut];
    self.collectionView.backgroundColor = [UIColor darkGrayColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    
    [self.collectionView registerClass:[TarentoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:_collectionView];
    
    
    [self setupLeftMenuButton];
    
    
    NSString *string = [NSString stringWithFormat:@"http://app.iliangcang.com/expert?app_key=Android&build=2015110402&count=18&page=1&v=1.0"];
    
    
    [self sessionDataTaskWithURLString:string];
    
    
    [self.collectionView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerAction)];
    [self.collectionView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerAction)];
    
    self.activityView = [[CommonActivityIndicatorView alloc] init];
    [self.view addSubview:_activityView];
    
}

- (void)headerAction
{
    
    number = 1;
    _modelArray = nil;
    if (numberRowStay == 0) {
        NSString *string = [NSString stringWithFormat:@"http://app.iliangcang.com/expert?app_key=Android&build=2015110402&count=18&page=1&v=1.0"];
        [self sessionDataTaskWithURLString:string];
    }else if (numberRowStay == 1)
    {
        NSString *string = [NSString stringWithFormat:@"http://app.iliangcang.com/expert?orderby=goods_sum&app_key=Android&build=2015110402&count=18&page=1&v=1.0"];
        [self sessionDataTaskWithURLString:string];
    }else if (numberRowStay == 2)
    {
        NSString *string = [NSString stringWithFormat:@"http://app.iliangcang.com/expert?orderby=followers&app_key=Android&build=2015110402&count=18&page=1&v=1.0"];
        [self sessionDataTaskWithURLString:string];
    }else if (numberRowStay == 3)
    {
        NSString *string = [NSString stringWithFormat:@"http://app.iliangcang.com/expert?orderby=action_time&app_key=Android&build=2015110402&count=18&page=1&v=1.0"];
        [self sessionDataTaskWithURLString:string];
    }else if (numberRowStay == 4)
    {
        NSString *string = [NSString stringWithFormat:@"http://app.iliangcang.com/expert?orderby=reg_time&app_key=Android&build=2015110402&count=18&page=1&v=1.0"];
        [self sessionDataTaskWithURLString:string];
    }

    
    [self.collectionView reloadData];
    [self.collectionView.header endRefreshing];
}

- (void)footerAction
{
    number++;
    
    if (numberRowStay == 0) {
        NSString *string = [NSString stringWithFormat:@"http://app.iliangcang.com/expert?app_key=Android&build=2015110402&count=18&page=%d&v=1.0", number];
        [self sessionDataTaskWithURLString:string];
        
    }else if (numberRowStay == 1)
    {
        NSString *string = [NSString stringWithFormat:@"http://app.iliangcang.com/expert?orderby=goods_sum&app_key=Android&build=2015110402&count=18&page=%d&v=1.0", number];

        [self sessionDataTaskWithURLString:string];
    
    }else if (numberRowStay == 2)
    {
        NSString *string = [NSString stringWithFormat:@"http://app.iliangcang.com/expert?orderby=followers&app_key=Android&build=2015110402&count=18&page=%d&v=1.0", number];

        [self sessionDataTaskWithURLString:string];
        
    }else if (numberRowStay == 3)
    {
        NSString *string = [NSString stringWithFormat:@"http://app.iliangcang.com/expert?orderby=action_time&app_key=Android&build=2015110402&count=18&page=%d&v=1.0", number];
        [self sessionDataTaskWithURLString:string];
        
    }else if (numberRowStay == 4)
    {
        NSString *string = [NSString stringWithFormat:@"http://app.iliangcang.com/expert?orderby=reg_time&app_key=Android&build=2015110402&count=18&page=%d&v=1.0", number];
        [self sessionDataTaskWithURLString:string];
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
    TarentoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    TarentoModel *model = _modelArray[indexPath.row];
   
    cell.model = model;
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.frame.size.width - 50) / 3 , (self.view.frame.size.width - 50) / 3 + 40);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 10, 5, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailTarentoViewController *detailTarentoViewVc = [[DetailTarentoViewController alloc]init];
    TarentoModel *model = _modelArray[indexPath.row];

    detailTarentoViewVc.tarentoModel = model;
    [self.navigationController pushViewController:detailTarentoViewVc animated:YES];
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

    numberRowStay = (int)numberRow;
    number = 1;
    _modelArray = nil;
    if (numberRow == 0) {
        NSString *string = [NSString stringWithFormat:@"http://app.iliangcang.com/expert?app_key=Android&build=2015110402&count=18&page=1&v=1.0"];
        [self sessionDataTaskWithURLString:string];
    }else if ((int)numberRow == 1)
    {
        NSString *string = [NSString stringWithFormat:@"http://app.iliangcang.com/expert?orderby=goods_sum&app_key=Android&build=2015110402&count=18&page=1&v=1.0"];
       [self sessionDataTaskWithURLString:string];
    }else if ((int)numberRow == 2)
    {
        NSString *string = [NSString stringWithFormat:@"http://app.iliangcang.com/expert?orderby=followers&app_key=Android&build=2015110402&count=18&page=1&v=1.0"];
       [self sessionDataTaskWithURLString:string];
    }else if ((int)numberRow == 3)
    {
        NSString *string = [NSString stringWithFormat:@"http://app.iliangcang.com/expert?orderby=action_time&app_key=Android&build=2015110402&count=18&page=1&v=1.0"];
       [self sessionDataTaskWithURLString:string];
    }else if ((int)numberRow == 4)
    {
        NSString *string = [NSString stringWithFormat:@"http://app.iliangcang.com/expert?orderby=reg_time&app_key=Android&build=2015110402&count=18&page=1&v=1.0"];
       [self sessionDataTaskWithURLString:string];
    }
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"reload" object:nil];
    
    _isSelecate = NO;
}

- (void)leftDrawerButtonPress
{

    _isSelecate = !_isSelecate;
    
    if (_isSelecate) {

       [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadViewWithData:) name:@"reload" object:nil];
    }else
    {
  
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"reload" object:nil];
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
            
            TarentoModel *model = [[TarentoModel alloc]init];
            
            [model setValuesForKeysWithDictionary:dataDic];
            
            [self.modelArray addObject:model];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            [self.activityView endCommonActivity];
        });
        
    }]resume];

}


- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden =NO;
}

//- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
//{
//   
//    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
//    [UIView animateWithDuration:0.25 animations:^{
//        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
//    }];
//
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
