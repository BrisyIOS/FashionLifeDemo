//
//  ShopController.m
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "ShopController.h"
#import "Header.h"
#import "ShopModel.h"
#import "ShopCell.h"
#import "CategoryModel.h"
#import "ShopDetailView.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "ShowTarentoViewController.h"

@interface ShopController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,ShopDetailviewDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *shopArray;
@property (nonatomic,strong) ShopDetailView *shopDetailView;
@property (nonatomic,strong) UIImageView *brandImageview;
@property (nonatomic,assign) int page;


@end

@implementation ShopController

// 懒加载
- (NSMutableArray *)shopArray{
    if (!_shopArray) {
        _shopArray = [NSMutableArray array];
    }
    return _shopArray;
}


#pragma mark - 实现shopDetailView中的协议方法
- (void)changeHeight:(CGFloat)height{
    self.shopDetailView.frame = CGRectMake(0, 0, kScreenWidth, 40 + height);
    [self.view insertSubview:self.shopDetailView aboveSubview:self.collectionView];
}


#pragma mark - 实现shopDetailView中的协议中的方法
- (void)passDataWithCode:(NSString *)code{
   
    NSString *url = [NSString stringWithFormat:@"http://app.iliangcang.com/goods/class?type=100&cat_code=%@&app_key=Android&build=2015110402&count=20&page=1&self_host=1&v=1.0",code];
    self.url = url;
    self.page = 1;
    [self setDataWithURL:url];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
    self.shopArray = [NSMutableArray array];
    [self.collectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.name;
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"arrow_25.6px_1155135_easyicon.net"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    
    
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor blackColor];
    int height = 0;
    int width = (kScreenWidth - 30)/2;
    
    switch (self.skipToShop) {
            // 首页
        case SkipToShopFist:
            height = 0;
            break;
            // 分类
        case SkipToShopCategory:
        {
            height = 40;
            ShopDetailView *shopDetailView = [[ShopDetailView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
            shopDetailView.alpha = 0.8;
            shopDetailView.delegate = self;
            shopDetailView.categoryArray = self.categoryArray;
            shopDetailView.indexPath = self.indexPath;
            shopDetailView.name = self.childrenName;
            shopDetailView.categoryHeight = height;
            [self.view addSubview:shopDetailView];
            self.shopDetailView = shopDetailView;
        }
            break;
                default:
            break;
    }
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(width, width + 65);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.minimumInteritemSpacing = 10;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, kScreenHeight - 64 - height) collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    
    
    // 注册cell
    [self.collectionView registerClass:[ShopCell class] forCellWithReuseIdentifier:@"shopcell"];
    
    [MBProgressHUD showMessage:@"loading..." toView:self.view];

    
    
    // 加载数据
    [self setDataWithURL:self.url];
    
    
    // 上拉刷新
    __weak typeof(self) BlockSelf = self;
    [self.collectionView addLegendHeaderWithRefreshingBlock:^{
        [MBProgressHUD showMessage:@"loading..." toView:BlockSelf.view];
        BlockSelf.page = 1;
        BlockSelf.shopArray = [NSMutableArray array];
        [BlockSelf setDataWithURL:BlockSelf.url];
        [BlockSelf.collectionView reloadData];
        [BlockSelf.collectionView.header endRefreshing];
    }];
    
    
    // 下拉加载更多
    self.page = 1;

    [self.collectionView addLegendFooterWithRefreshingBlock:^{
        BlockSelf.page++;
        NSString *pageString = [NSString stringWithFormat:@"page=%d",BlockSelf.page];
        NSString *url = [BlockSelf.url stringByReplacingOccurrencesOfString:@"page=1" withString:pageString];
        [BlockSelf setDataWithURL:url];
        [BlockSelf.collectionView reloadData];
        [BlockSelf.collectionView.footer endRefreshing];
    }];

    
    
}


#pragma mark - 数据解析
- (void)setDataWithURL:(NSString *)url{
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *  data, NSURLResponse *  response, NSError *  error) {
        if (data == nil) {
            return ;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *array = [NSMutableArray array];
        switch (self.skipToShop) {
            case SkipToShopFist:
            {
                array = [ShopModel modelWithDic:dic];
                [self.shopArray addObjectsFromArray:array];
            }
                break;
            case SkipToShopCategory:
            {
                
                array = [ShopModel categoryModelWithDic:dic];
                [self.shopArray addObjectsFromArray:array];
            }
                break;
            default:
                break;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.collectionView reloadData];
            [MBProgressHUD hideHUDForView:self.view];
        });
    }] resume];
}


#pragma mark - 返回多少分组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

#pragma mark - 返回多少行
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.shopArray.count;
}

#pragma mark - 返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shopcell" forIndexPath:indexPath];
    ShopModel *shopModel = self.shopArray[indexPath.row];
    cell.shopModel = shopModel;
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShowTarentoViewController *showTarentoViewVc = [[ShowTarentoViewController alloc]init];
    
    
    switch (self.skipToShop) {
        case SkipToShopFist:
        {
            ShopModel *shopModel = _shopArray[indexPath.row];
            
            showTarentoViewVc.modelString = shopModel.goods_id;
            
            [self.navigationController pushViewController:showTarentoViewVc animated:YES];
        }
            break;
            
        case SkipToShopCategory:
        {
            ShopModel *shopModel = _shopArray[indexPath.row];
            
            showTarentoViewVc.modelString = shopModel.goods_id;
            
            [self.navigationController pushViewController:showTarentoViewVc animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)leftBarButtonAction:(UIBarButtonItem *)button
{

    [self.navigationController popViewControllerAnimated:YES];
}

@end
