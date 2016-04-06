//
//  FourCell.m
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "FourCell.h"
#import "Header.h"
#import "Four_Cell.h"

@interface FourCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@end

@implementation FourCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        int height = kScreenWidth/2;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kScreenWidth/2, height);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height) collectionViewLayout:layout];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.scrollEnabled = NO;
        self.collectionView.bounces = NO;
        self.collectionView.backgroundColor = [UIColor brownColor];
        [self.contentView addSubview:_collectionView];
        
        
        // 注册cell
        [self.collectionView registerClass:[Four_Cell class] forCellWithReuseIdentifier:@"four_cell"];
    }
    return self;
}
#pragma mark - 返回多少分组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


#pragma mark - 返回多少行 
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.FourArray.count;
}


#pragma  mark - 返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Four_Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"four_cell" forIndexPath:indexPath];
    cell.storeModel = self.FourArray[indexPath.row];
    return cell;
    
}


#pragma mark - 选中cell跳转到详情页面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    StoreModel *storeModel = self.FourArray[indexPath.row];
    [self.delegate passDataWithID:storeModel.content_id];
}

@end
