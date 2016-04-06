//
//  DownloadMovieTableViewCell.h
//  时尚生活
//
//  Created by zhangxu on 15/11/28.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadMovieTableViewCell : UITableViewCell

@property(nonatomic, strong)UIImageView *myImageView;
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UILabel *detailLabel;
@property(nonatomic, strong)UILabel *cacheLabel;
@property(nonatomic, strong)UIView *blackView;
@property(nonatomic, strong)UIView *backView;

@property(nonatomic, strong)UIButton *button;
@property(nonatomic, strong)UIButton *deleteButton;


@end
