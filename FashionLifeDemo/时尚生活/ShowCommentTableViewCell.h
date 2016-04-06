//
//  ShowCommentTableViewCell.h
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ShowCommentModel.h"
@interface ShowCommentTableViewCell : UITableViewCell<UIScrollViewDelegate, UIAlertViewDelegate>

@property(nonatomic, strong)UIImageView *iocnImageView;

@property(nonatomic, strong)ShowCommentModel *commentModel;



@property(nonatomic, strong)UILabel *timeLabel;;

@property(nonatomic, strong)UILabel *detailLabel;

@property(nonatomic, strong)UILabel *userLabel;

+ (CGFloat)setHeightCell:(ShowCommentModel *)model;

@end
