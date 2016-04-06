//
//  ShowHeader.h
//  时尚生活
//
//  Created by zhangxu on 15/11/27.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowTarentoModel.h"
#import "DIYLikeButton.h"
#import "detailTarentoModel.h"
@interface ShowHeader : UITableViewHeaderFooterView<UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *scrollView;

@property(nonatomic, strong)UIScrollView *smallScrollView;

@property(nonatomic, strong)UIImageView *iocnImageView;

@property(nonatomic, strong)UIPageControl *page;

@property(nonatomic, strong)ShowTarentoModel *showModel;

@property(nonatomic, assign)NSInteger number;

@property(nonatomic, strong)UILabel *lostLabel;

@property(nonatomic, strong)UIImageView *myImageView;

@property(nonatomic, strong)UILabel *goodLabel;

@property(nonatomic, strong)UILabel *describeLabel;

@property(nonatomic, strong)DIYLikeButton *likeButton;

@property(nonatomic, strong)detailTarentoModel *detailModel;

+ (CGFloat)heightForCell:(ShowTarentoModel *)model;

@end
