//
//  MovieDetailTableViewCell.h
//  时尚生活
//
//  Created by zhangxu on 15/11/27.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MovieModel.h"
#import "DIYLikeButton.h"
@interface MovieDetailTableViewCell : UITableViewCell

@property(nonatomic, strong)MovieModel *model;

@property(nonatomic, strong)DIYLikeButton *shareButton;

+ (CGFloat)heightForCell:(MovieModel *)model;

@end
