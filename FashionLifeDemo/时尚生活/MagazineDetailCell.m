//
//  MagazineDetailCell.m
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "MagazineDetailCell.h"
#import "Header.h"
#import "UIImageView+WebCache.h"

@interface MagazineDetailCell ()

@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *subLabel;

@end

@implementation MagazineDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat height = (kScreenHeight-64-44)/7;
        // img
        [self.contentView addSubview:self.img];
        self.img = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, height-10, height-10)];
        self.img.layer.cornerRadius = (height-10)/2;
        self.img.layer.masksToBounds = YES;
        [self.contentView addSubview:self.img];
        
        // label
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(height+5, 0, kScreenWidth-height, height/2)];
        self.label.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.label];
        
        // subLabel
        self.subLabel = [[UILabel alloc] initWithFrame:CGRectMake(height+5, height/2-10, kScreenWidth-height, height/2)];
        self.subLabel.font = [UIFont systemFontOfSize:14];
        self.subLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.subLabel];
        
        self.contentView.backgroundColor = [UIColor colorWithRed:183/255.0 green:189/255.0 blue:193/255.0 alpha:0.4];
        
    }
    return self;
}
// 重写model的set方法
- (void)setModel:(MagazineDetailModel *)model
{
    _model = model;
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
    self.label.text = model.author_name;
    self.subLabel.text = model.note;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
