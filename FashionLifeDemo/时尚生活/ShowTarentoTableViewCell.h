//
//  ShowTarentoTableViewCell.h
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowTarentoModel.h"
@interface ShowTarentoTableViewCell : UITableViewCell<UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *scrollView;

@property(nonatomic, strong)UIScrollView *smallScrollView;

@property(nonatomic, strong)UIImageView *iocnImageView;

@property(nonatomic, strong)UIPageControl *page;

@property(nonatomic, strong)ShowTarentoModel *showModel;

@property(nonatomic, assign)NSInteger number;

@property(nonatomic, strong)UILabel *lostLabel;

@property(nonatomic, strong)UILabel *goodLabel;

@property(nonatomic, strong)UILabel *describeLabel;

@property(nonatomic, strong)UILabel *sizeLabel;

@property(nonatomic, strong)UILabel *detailLabel;

+ (CGFloat)heightForCell:(ShowTarentoModel *)model;

@end
