//
//  WaterFlowLayout.m
//  LessonCollectionView
//
//  Created by I三生有幸I on 15/7/18.
//  Copyright (c) 2015年 盛辰. All rights reserved.
//

#import "WaterFlowLayout.h"


@interface  WaterFlowLayout ()

@property (nonatomic, assign) NSUInteger numberOfItems;//item的数量
@property (nonatomic, retain) NSMutableArray *columnHeights;//用来保存每列的总高度的数组(根据瀑布流的最终列数，数组对象的个数不同)
@property (nonatomic, retain) NSMutableArray *itemAttributes;//用来保存最终计算出的每个item的数据的数组（数据保存在layoutAttribut对象的各个属性中）

//获取最长列的索引
- (NSInteger)p_indexForLongestColumn;

//获取最短列的索引
- (NSInteger)p_indexForShortestColumn;

@end

@implementation WaterFlowLayout


- (NSMutableArray *)columnHeights{
    
//    NSLog(@"%s",__FUNCTION__);
    
    
    if (!_columnHeights) {
        self.columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

- (NSMutableArray *)itemAttributes{
    
//    NSLog(@"%s",__FUNCTION__);
    
    if (!_itemAttributes) {
        self.itemAttributes = [NSMutableArray array];
    }
    return _itemAttributes;
}

//获取最长列的索引
- (NSInteger)p_indexForLongestColumn
{
    //初始最大值
    NSInteger longestIndex = 0;
    CGFloat longestHeight = 0;
    
    for (NSInteger i = 0; i < self.numberOfColumns; i ++) {
        
        //获取当前列的高度
        CGFloat currentHeight = [self.columnHeights[i] floatValue];
        
        //如果当前列的高度大于最大高度，重新设置最大高度
        if (currentHeight > longestHeight) {
            
            longestHeight = currentHeight;
            longestIndex = i;
        }
    }
    
    return longestIndex;
}

//获取最短列的索引
- (NSInteger)p_indexForShortestColumn
{
    //初始最小值
    NSInteger shortestIndex = 0;
    CGFloat shortestHeight = MAXFLOAT;
    
    for (NSInteger i = 0; i < self.numberOfColumns; i ++) {
        
        //获取当前列的高度
        CGFloat currentHeight = [self.columnHeights[i] floatValue];
        
        //如果当前列的高度小于最小高度，重新设置最小高度
        if (currentHeight < shortestHeight) {
            
            shortestHeight = currentHeight;
            shortestIndex = i;
        }
    }
    
    return shortestIndex;

}

- (void)prepareLayout
{
    [super prepareLayout];
    
    
    //给columnHeights设置默认的初值，每一列的高度默认都是top
    for (int i = 0; i < self.numberOfColumns; i ++) {
        
        self.columnHeights[i] = @(self.sectionInsets.top);
        
    }
    
    
    //计算并设置每个item的位置
    
    //获取item的总数量
    self.numberOfItems = [self.collectionView numberOfItemsInSection:0];
    //设置每个item的位置
    for (int i = 0; i < self.numberOfItems; i ++) {
        
        
        //先找到高度最小的列
        NSInteger shortestColumnIndex = [self p_indexForShortestColumn];
        
        
        CGFloat shortestColumnHeight = [self.columnHeights[shortestColumnIndex] floatValue];
        
        //item的x计算公式：内边界left + (item的width + item的间距) * 列的索引
        CGFloat deltaX = self.sectionInsets.left + (self.itemSize.width + self.interitemSpacing) * shortestColumnIndex;
        
        NSLog(@"delta x = %f",deltaX);
        
        //item的y计算公式：当前列的最小高度 + item的间距
        CGFloat deltaY = shortestColumnHeight + self.interitemSpacing;
        
        //设置当前item对应的indexPath对象
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes * layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
//        CGFloat itemHeight = arc4random()%200 + 10;
        
        CGFloat itemHeight = 0;
        
        //从数据源中获取item的高度
        if (_delegate && [_delegate respondsToSelector:@selector(collectionView:waterFlowLayout:heightForItemAtIndexPath:)]) {
            
            itemHeight = [_delegate collectionView:self.collectionView waterFlowLayout:self heightForItemAtIndexPath:indexPath];
        }
        
        layoutAttributes.frame = CGRectMake(deltaX, deltaY, self.itemSize.width, itemHeight);
        
        //将item对应的layoutAttributes添加到数组中
        [self.itemAttributes addObject:layoutAttributes];
        
        //记录当前列的最新的高度: y + item高度
        self.columnHeights[shortestColumnIndex] = @(deltaY + itemHeight);
        
        NSLog(@"%@",self.columnHeights);
        
        
    }
    
    
    
}

- (CGSize)collectionViewContentSize
{
//    NSLog(@"%s",__FUNCTION__);
    
    //获取高度最大的列的索引
    NSInteger longestColumnIndex = [self p_indexForLongestColumn];
    
    //获取高度最大的列的值
    CGFloat longestColumnHeight = [self.columnHeights[longestColumnIndex] floatValue];
    
    //计算当前contentSize的高度：高度最大值 + bottom
    
    CGSize contentSize = self.collectionView.frame.size;
    contentSize.height = longestColumnHeight + self.sectionInsets.bottom;
    
    return contentSize;
}



- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
//    NSLog(@"%s",__FUNCTION__);
    return self.itemAttributes;
}




@end
