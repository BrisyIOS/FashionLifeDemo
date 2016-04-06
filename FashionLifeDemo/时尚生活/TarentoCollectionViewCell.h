//
//  TarentoCollectionViewCell.h
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TarentoModel.h"
@interface TarentoCollectionViewCell : UICollectionViewCell


@property(nonatomic, strong)UIImageView *myImageView;
@property(nonatomic, strong)UILabel *myLabel;
@property(nonatomic, strong)UILabel *titleLabel;

@property(nonatomic, strong)TarentoModel *model;

@end
