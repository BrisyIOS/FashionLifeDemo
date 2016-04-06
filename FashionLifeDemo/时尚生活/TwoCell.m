//
//  TwoCell.m
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "TwoCell.h"
#import "Header.h"
#import "StoreModel.h"
#import "Two_Cell.h"
#import "WaterFlowLayout.h"

@interface TwoCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateWaterFlowLayout>


@end

@implementation TwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        int height = kScreenWidth/2 + kScreenWidth / 1.55;
        // item宽和高 列数 以及列间距 是结合使用的
        WaterFlowLayout * layout = [[WaterFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kScreenWidth/2, 0); // item 宽和高
        layout.sectionInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.numberOfColumns = 2; // 列数
        layout.interitemSpacing = 0; // 列间距
        layout.delegate = self;

        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height) collectionViewLayout:layout];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.scrollEnabled = NO;
        self.collectionView.bounces = NO;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_collectionView];
        
        
        // 注册cell
        [self.collectionView registerClass:[Two_Cell class] forCellWithReuseIdentifier:@"two_cell"];
    }
    return self;
}

#pragma mark - 返回多少分组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

#pragma mark - 返回多少行
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _listArray.count;
}


#pragma mark - 返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Two_Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"two_cell" forIndexPath:indexPath];
    
    // 找到model
    StoreModel *storeModel = self.listArray[indexPath.row];
    cell.storeModel = storeModel;
    
    return cell;
    
}


#pragma mark - 选中cell跳转到详情界面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    StoreModel *storeModel = self.listArray[indexPath.row];
    
    if (storeModel.topic_url.length == 0 || storeModel.topic_url == nil) {
        [self.delegate passDataWithContent_id:storeModel.content_id];
    }else{
        [self.delegate passDataWithtopic_url:storeModel.topic_url topic_name:storeModel.topic_name];
    }
}


- (CGFloat)collectionView:(UICollectionView *)collectionView waterFlowLayout:(WaterFlowLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    StoreModel *storeModel = _listArray[indexPath.row];
    switch (indexPath.row) {
        case 0:
            storeModel.pic_urlHeight = kScreenWidth / 1.55;
            break;
        case 1:
            storeModel.pic_urlHeight = kScreenWidth/2;
            break;
        case 2:
            storeModel.pic_urlHeight =  kScreenWidth/1.55;
            break;
        case 3:
            storeModel.pic_urlHeight = kScreenWidth / 2;
        default:
            break;
    }
    CGFloat itemHeight = storeModel.pic_urlHeight;
    return itemHeight;

}

@end
