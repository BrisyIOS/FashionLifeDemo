//
//  MagazineItem.h
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MagazineDetailModel.h"

@interface MagazineItem : UICollectionViewCell

@property (nonatomic, strong) MagazineDetailModel *model;
@property (nonatomic, strong) UIImageView *bgPicture;
@property (nonatomic, strong) UILabel *name;

@end
