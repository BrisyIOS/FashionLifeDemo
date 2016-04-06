//
//  MovieSetTableViewCell.m
//  时尚生活
//
//  Created by zhangxu on 15/11/27.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "MovieSetTableViewCell.h"
#import "Header.h"
@implementation MovieSetTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, kScreenWidth - 40, 50)];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:19];
        
        self.titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
        
        
        self.firstImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 20, 20)];
//        self.firstImageView.image = [UIImage imageNamed:@"iconfont-xiaolian"];
        [self addSubview:_firstImageView];
        
        
        UIImageView *myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 50, 15, 20, 20)];
        myImageView.image = [UIImage imageNamed:@"iconfont-jiantou.png"];
        [self addSubview:myImageView];
        
        
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 49, kScreenWidth - 40, 1)];
        lineLabel.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:lineLabel];
        
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
