//
//  NavigaView.h
//  时尚生活
//
//  Created by zhangxu on 15/11/27.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavigaViewDelegate <NSObject>

- (void)changePage:(int)page;

@end

@interface NavigaView : UIView
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,assign) id<NavigaViewDelegate>delegate;

@end
