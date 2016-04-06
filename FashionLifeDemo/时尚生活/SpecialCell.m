//
//  SpecialCell.m
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "SpecialCell.h"
#import "Header.h"
#import "UIImageView+WebCache.h"

@interface SpecialCell ()
@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) UILabel *topic_nameLabel;
@property (nonatomic,strong) UILabel *cat_nameLabel;

@end

@implementation SpecialCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        int height = kScreenWidth/750*460;
        self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
        [self.contentView addSubview:_icon];
        
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0.2;
        [self.contentView addSubview:bgView];
        
        
        self.topic_nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
        self.topic_nameLabel.font = [UIFont boldSystemFontOfSize:18];
        self.topic_nameLabel.textColor = [UIColor whiteColor];
        self.topic_nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_topic_nameLabel];
        
        
        self.cat_nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, height)];
        self.cat_nameLabel.font = [UIFont boldSystemFontOfSize:16];
        self.cat_nameLabel.textColor = [UIColor whiteColor];
        self.cat_nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_cat_nameLabel];
    }
    return self;
}


- (void)setSpecialModel:(SpecialModel *)specialModel{
    _specialModel = specialModel;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:specialModel.cover_img]];
    self.topic_nameLabel.text = specialModel.topic_name;
    self.cat_nameLabel.text = [NSString stringWithFormat:@"#%@",specialModel.cat_name];
}

@end
