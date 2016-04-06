//
//  FourCell.h
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FourCellDelegate <NSObject>

- (void)passDataWithID:(NSString *)ID;

@end

@interface FourCell : UITableViewCell
@property (nonatomic,strong) NSMutableArray *FourArray;
@property (nonatomic,assign) id<FourCellDelegate>delegate;
@property (nonatomic,strong) UICollectionView *collectionView;
@end
