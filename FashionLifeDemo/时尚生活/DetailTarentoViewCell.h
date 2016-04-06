//
//  DetailTarentoViewCell.h
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "detailTarentoModel.h"
@interface DetailTarentoViewCell : UICollectionViewCell

@property(nonatomic, strong)UIImageView *myImageView;
@property(nonatomic, strong)UIImageView *leftImageView;

@property(nonatomic, strong)detailTarentoModel *model;

@end
