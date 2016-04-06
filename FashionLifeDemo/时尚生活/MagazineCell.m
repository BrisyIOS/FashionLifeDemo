//
//  MagazineCell.m
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "MagazineCell.h"
#import "Header.h"
#import "UIImageView+WebCache.h"

@interface MagazineCell ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *catLabel;
@property (nonatomic, strong) UIView *bgView;

@end

@implementation MagazineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = NO;
        
        CGFloat width = kScreenWidth;
        CGFloat height = kScreenHeight/3;
        // 创建封面图
        self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [self.contentView addSubview:self.icon];
        // 模糊的View
        self.bgView = [[UIView alloc] initWithFrame:self.icon.frame];
        self.bgView.backgroundColor = [UIColor blackColor];
        self.bgView.alpha = 0.4;
        [self.contentView addSubview:self.bgView];
        
        // 创建标题
        CGFloat y = (height - 60) / 2;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, y, width, 30)];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
        
        // 创建类型
        self.catLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, y+30, width, 30)];
        self.catLabel.textColor = [UIColor whiteColor];
        self.catLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.catLabel];
    }
    return self;
}
#pragma mark -- 重写Model的set方法 --
- (void)setModel:(MagazineModel *)model
{
    _model = model;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.cover_img_new]];
    self.titleLabel.text = model.topic_name;
    self.catLabel.text = [NSString stringWithFormat:@"# %@", model.cat_name];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
