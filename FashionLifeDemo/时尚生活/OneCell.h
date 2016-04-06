//
//  OneCell.h
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreModel.h"

@protocol OneCellDelegate <NSObject>

- (void)passUrl:(NSString *)url topic_name:(NSString *)topic_name;
- (void)passContent_id:(NSString *)content_id;

@end

@interface OneCell : UITableViewCell
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) NSMutableArray *slderArray;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,assign) id<OneCellDelegate>delegate;
@property (nonatomic,assign) int count;


@end
