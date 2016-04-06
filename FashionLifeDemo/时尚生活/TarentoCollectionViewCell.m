//
//  TarentoCollectionViewCell.m
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "TarentoCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation TarentoCollectionViewCell



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
  
        self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
        [self.contentView addSubview:_myImageView];
        
        self.myLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.width, frame.size.width, 25)];
        self.myLabel.textColor = [UIColor whiteColor];
        self.myLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_myLabel];
        
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.width + 25, frame.size.width, 15)];
        self.titleLabel.textColor = [UIColor cyanColor];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_titleLabel];
        
    }
    return self;
}


- (void)setModel:(TarentoModel *)model
{
    _model = model;
    
    self.titleLabel.text = _model.user_desc;
    self.myLabel.text = _model.user_name;
//    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:_model.user_image]];
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:_model.user_image] placeholderImage:[UIImage imageNamed:@"image_loading_128px_1068020_easyicon.net"]];
    
}

@end
