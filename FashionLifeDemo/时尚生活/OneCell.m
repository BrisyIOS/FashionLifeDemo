//
//  OneCell.m
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "OneCell.h"
#import "Header.h"
#import "One_Cell.h"
#import "SlideController.h"

/* 滚动滑条*/
@interface OneCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,assign) BOOL isFist;

@end

@implementation OneCell{
    int i;
}


//#warning mark － 销毁定时器
- (void)dealloc{
    NSLog(@"定时器被销毁了");
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        int width = kScreenWidth;
        int height = kScreenWidth/750*446;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(width, height);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, width, height) collectionViewLayout:layout];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.pagingEnabled = YES;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_collectionView];
        
        
        self.pageControl = [[UIPageControl alloc] init];
        self.pageControl.center = CGPointMake(width/2, height - 30);
        self.pageControl.bounds = CGRectMake(0, 0, kScreenWidth/4.68, kScreenHeight/33.35);
        [self.contentView addSubview:_pageControl];
        self.pageControl.currentPage = 0;
        self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        
        
        // 注册cell
        [self.collectionView registerClass:[One_Cell class] forCellWithReuseIdentifier:@"one_cell"];
        
        
        // 添加定时器
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(playAnimation) userInfo:nil repeats:YES];
        [self.timer fire];
        
    }
    return self;
}


- (void)playAnimation{
    i++;
    if (self.isFist == NO) {
        i = i - 1;
        self.isFist = YES;
        return;
    }
    self.collectionView.contentOffset = CGPointMake(kScreenWidth*(i%self.count), 0);
    self.pageControl.center = CGPointMake(kScreenWidth/2, kScreenWidth/750*446 - kScreenHeight/22.23);
    self.pageControl.numberOfPages = self.count;
}


#pragma mark - 返回多少分组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


#pragma  mark - 返回多少行 
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.slderArray.count;
}


#pragma mark -  返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    One_Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"one_cell" forIndexPath:indexPath];
    self.pageControl.currentPage = indexPath.row;
    // 找到model
    StoreModel *storeModel = self.slderArray[indexPath.row];
    cell.storeModel = storeModel;
    return cell;
    
}


#pragma mark - 选中cell跳转到详情页面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // 找到model
    StoreModel *storeModel = self.slderArray[indexPath.row];
    if (storeModel.topic_url == nil || storeModel.topic_url.length == 0) {
        [self.delegate passContent_id:storeModel.content_id];
    }else{
        [self.delegate passUrl:storeModel.topic_url topic_name:storeModel.topic_name];
    }
}



@end
