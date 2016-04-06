//
//  WaterFlowLayout.h
//  LessonCollectionView
//
//  Created by I三生有幸I on 15/7/18.
//  Copyright (c) 2015年 盛辰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WaterFlowLayout;

/**
 *  UICollectionView扩展协议，获取每个item的高度
 */
@protocol UICollectionViewDelegateWaterFlowLayout <UICollectionViewDelegate>

- (CGFloat)collectionView:(UICollectionView *)collectionView
          waterFlowLayout:(WaterFlowLayout *)layout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface WaterFlowLayout : UICollectionViewLayout

@property (nonatomic, assign) NSUInteger numberOfColumns;   //瀑布流的列数
@property (nonatomic, assign) CGSize itemSize;              //每一个item的大小
@property (nonatomic, assign) UIEdgeInsets sectionInsets;   //分区的上、下、左、右、四个边距
@property (nonatomic, assign) CGFloat interitemSpacing;     //item的列间距(与行间距使用统一大小)
@property (nonatomic, assign) id<UICollectionViewDelegateWaterFlowLayout> delegate;

@end
