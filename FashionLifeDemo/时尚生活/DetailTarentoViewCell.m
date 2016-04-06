//
//  DetailTarentoViewCell.m
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "DetailTarentoViewCell.h"
#import "UIImageView+WebCache.h"
@implementation DetailTarentoViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
        
        [self.contentView addSubview:_myImageView];
        
        self.leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 73 / 4, 76 / 4)];
        [self.myImageView addSubview:_leftImageView];

    }
    return self;
}

- (void)setModel:(detailTarentoModel *)model
{
    _model = model;
    
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:_model.goods_image] placeholderImage:[UIImage imageNamed:@"image_loading_128px_1068020_easyicon.net"]];

    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:_model.promotion_imgurl]];
}



@end
