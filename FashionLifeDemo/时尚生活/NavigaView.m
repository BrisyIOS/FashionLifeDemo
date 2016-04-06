//
//  NavigaView.m
//  时尚生活
//
//  Created by zhangxu on 15/11/27.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "NavigaView.h"
#import "Header.h"
#import "NavigaCell.h"

@interface NavigaView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) NSArray *array;

@end

@implementation NavigaView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.itemSize = CGSizeMake(kScreenWidth/3, 46);
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 46) collectionViewLayout:layout];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.scrollEnabled = NO;
        [self addSubview:_collectionView];

        
        
        // 注册cell
        [self.collectionView registerClass:[NavigaCell class] forCellWithReuseIdentifier:@"cell"];
        
        self.array = @[@"分类",@"首页",@"专题"];
        [self.collectionView reloadData];
    }
    return self;
}


#pragma mark - 返回多少分组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


#pragma mark - 返回多少行
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.array.count;
}

#pragma mark - 返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NavigaCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == 1) {
        cell.label.textColor = [UIColor whiteColor];
    }
    cell.label.text = self.array[indexPath.row];
    return cell;
}


#pragma mark - 选中cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    for (NavigaCell *cell in self.collectionView.visibleCells) {
        cell.label.textColor = [UIColor grayColor];
    }
    NavigaCell *cell = (NavigaCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.label.textColor = [UIColor whiteColor];
     [self.delegate changePage:(int)indexPath.row];
}


@end
