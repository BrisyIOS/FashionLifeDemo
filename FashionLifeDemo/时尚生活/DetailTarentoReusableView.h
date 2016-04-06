//
//  DetailTarentoReusableView.h
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TarentoModel.h"
#import "DIYTarentoButton.h"
#import "DetailCountModel.h"
#import "DIYLikeButton.h"
@interface DetailTarentoReusableView : UICollectionReusableView

@property(nonatomic, strong)UIImageView *myImageView;
@property(nonatomic, strong)UILabel *myLabel;
@property(nonatomic, strong)UILabel *detailLabel;
@property(nonatomic, strong)DIYTarentoButton *buttonOne;
@property(nonatomic, strong)DIYTarentoButton *buttonTwo;
@property(nonatomic, strong)DIYTarentoButton *buttonThree;
@property(nonatomic, strong)DIYTarentoButton *buttonFour;
@property(nonatomic, strong)DIYLikeButton *likeButton;

@property(nonatomic, strong)TarentoModel *model;
@property(nonatomic, strong)DetailCountModel *detailModel;

@end
