//
//  TwoCell.h
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TwoCellDelegate <NSObject>

// 传递content_id 用于拼接URL
- (void)passDataWithContent_id:(NSString *)content_id;

// 传递topic_url
- (void)passDataWithtopic_url:(NSString *)topic_url  topic_name:(NSString *)topic_name;


@end

@interface TwoCell : UITableViewCell
@property (nonatomic,strong) NSMutableArray *listArray;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,assign) id<TwoCellDelegate>delegate;
@end
