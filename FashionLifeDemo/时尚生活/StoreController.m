//
//  StoreController.m
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "StoreController.h"
#import "HomeView.h"
#import "CategoryView.h"
#import "Header.h"
#import "SpecialView.h"
#import "SlideController.h"
#import "ShopController.h"
#import "NavigaView.h"
#import "NavigaCell.h"


@interface StoreController ()<UIScrollViewDelegate,HomeViewDelegate,CategoryViewDelegate,SpecialViewDelegte,NavigaViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollview;
@property (nonatomic,strong) UILabel *lineLabel;
@property (nonatomic,strong) NavigaView *navigaView;



@end

@implementation StoreController{
    int i;
    int tempI;
}


- (void)viewDidLoad{
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationItem.title = @"商店";
    self.view.backgroundColor = [UIColor blackColor];
    
    
    // 添加导航条
    int navigaHeight = kScreenWidth/8.15;
    self.navigaView = [[NavigaView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, navigaHeight)];
    self.navigaView.delegate = self;
    [self.view addSubview:_navigaView];
    
    
    int lineLabelWidth = kScreenWidth/3;
    int lineLabelHieght = kScreenHeight/166.75;
    self.lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(lineLabelWidth, navigaHeight, lineLabelWidth, lineLabelHieght)];
    self.lineLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_lineLabel];
    
    
    int scrollHeight = kScreenHeight - 64;
    int scrollY = kScreenHeight/13.34;
    self.scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, scrollY, kScreenWidth, scrollHeight)];
    self.scrollview.pagingEnabled = YES;
    self.scrollview.bounces = NO;
    self.scrollview.delegate = self;

    
    int scrollCount = 3;
    self.scrollview.contentSize = CGSizeMake(kScreenWidth*scrollCount, scrollHeight);
    self.scrollview.contentOffset = CGPointMake(kScreenWidth, 0);
    [self.view addSubview:self.scrollview];
    
    
    // 分类
    CategoryView *categoryView = [[CategoryView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, scrollHeight)];
    categoryView.delegate = self;
    [self.scrollview addSubview:categoryView];
    
    
    //    // 首页
    HomeView *homeView = [[HomeView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, scrollHeight)];
    homeView.delegate = self;
    [self.scrollview addSubview:homeView];
    
    
    // 专题
    int speciCount = 2;
    SpecialView *specialView = [[SpecialView alloc] initWithFrame:CGRectMake(kScreenWidth*speciCount, 0, kScreenWidth, scrollHeight)];
    specialView.delegate = self;
    [self.scrollview addSubview:specialView];
    
    
}



#pragma mark - 实现首页中协议中的方法
- (void)passWithURL:(NSString *)url ID:(NSString *)ID name:(NSString *)name{
    if ([ID isEqualToString:@"one"]) {
        SlideController *slide = [[SlideController alloc] init];
        slide.url = url;
        slide.name = name;
        [self.navigationController pushViewController:slide animated:YES];
    }else if ([ID isEqualToString:@"two"]){
        ShopController *shop = [[ShopController alloc] init];
        NSString *URL = [NSString stringWithFormat:@"http://api.iliangcang.com/i/appshopgoods?app_key=Android&build=2015110402&list_id=%@&page=1&v=1.0",url];
        shop.url = URL;
        shop.name = name;
        shop.skipToShop = SkipToShopFist;
        [self.navigationController pushViewController:shop animated:YES];
    }
}

#pragma mark - 实现分类中协议中的方法
- (void)passDataWithCategoryCode:(NSString *)code ChildrenName:(NSString *)childrenName categoryArray:(NSMutableArray *)categoryArray IndexPath:(NSIndexPath *)indexPath name:(NSString *)name{
    ShopController *shop = [[ShopController alloc] init];
    NSString *url = [NSString stringWithFormat:@"http://app.iliangcang.com/goods/class?type=100&cat_code=%@&app_key=Android&build=2015110402&count=20&page=1&self_host=1&v=1.0",code];
    shop.skipToShop = SkipToShopCategory;
    shop.url = url;
    shop.name = name;
    shop.childrenName = childrenName;
    shop.categoryArray = categoryArray;
    shop.indexPath = indexPath;
    [self.navigationController pushViewController:shop animated:YES];
}



#pragma mark - 实现专题中协议中的方法
- (void)passDataWithAccess_url:(NSString *)access_url{
    SlideController *slide = [[SlideController alloc] init];
    slide.url = access_url;
    [self.navigationController pushViewController:slide animated:YES];
}


#pragma  mark - 实现正在滚动的方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
 
        i = (scrollView.contentOffset.x + 0.5 * kScreenWidth)/kScreenWidth;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(NSInteger)i inSection:0];
        for (NavigaCell *cell in self.navigaView.collectionView.visibleCells) {
            cell.label.textColor = [UIColor grayColor];
        }
        NavigaCell *cell = (NavigaCell *)[self.navigaView.collectionView cellForItemAtIndexPath:indexPath];
        cell.label.textColor = [UIColor whiteColor];
        
        
        int lineLabelWidth = kScreenWidth/3;
        self.lineLabel.frame = CGRectMake(i*lineLabelWidth, 46, lineLabelWidth, 4);
}



#pragma mark - 实现改变page的方法
- (void)changePage:(int)page{
    int lineLabelWidth = kScreenWidth/4;
    int lineLabelHeight = kScreenHeight/166.75;
    self.lineLabel.frame = CGRectMake(page*lineLabelWidth, 46, lineLabelWidth, lineLabelHeight);
    self.scrollview.contentOffset = CGPointMake(page*kScreenWidth, 0);
}


- (void)viewDidAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}


@end
