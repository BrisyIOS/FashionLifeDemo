//
//  ShowCommentTableViewCell.m
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "ShowCommentTableViewCell.h"
#import "Header.h"
#import "UIImageView+WebCache.h"
@implementation ShowCommentTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.iocnImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 40, 40)];
        self.iocnImageView.layer.cornerRadius = 20;
        self.iocnImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_iocnImageView];
        
        self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 30, kScreenWidth - 140, 60)];
        self.detailLabel.numberOfLines = 0;
        self.detailLabel.textColor = [UIColor whiteColor];
        self.detailLabel.font = [UIFont boldSystemFontOfSize:15];
        [self.contentView addSubview:_detailLabel];
        
        self.userLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 0, kScreenWidth - 70 - 160, 20)];
        self.userLabel.textColor = [UIColor whiteColor];
        self.userLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_userLabel];
        
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 160, 0, 160, 20)];
        self.timeLabel.textColor = [UIColor whiteColor];
        self.timeLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_timeLabel];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kScreenWidth - 65, 30, 50, 30);
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        [button setTitle:@"举报" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor lightGrayColor];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        
    }
    return self;
}

- (void)buttonAction:(UIButton *)button
{
    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"提示" message:@"举报已提交,等待审核结果" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertview show];

  
}

- (void)setCommentModel:(ShowCommentModel *)commentModel
{
    _commentModel = commentModel;
    self.detailLabel.text = _commentModel.msg;
    self.timeLabel.text = _commentModel.create_time;
    self.userLabel.text = [NSString stringWithFormat:@"%@ :",_commentModel.user_name];
//    [self.iocnImageView sd_setImageWithURL:[NSURL URLWithString:_commentModel.user_image]];
    
    [self.iocnImageView sd_setImageWithURL:[NSURL URLWithString:_commentModel.user_image] placeholderImage:[UIImage imageNamed:@"image_loading_48px_1068020_easyicon.net"]];
    
    
    CGRect bounds = [_commentModel.msg boundingRectWithSize:CGSizeMake(kScreenWidth - 140, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:15] forKey:NSFontAttributeName] context:nil];
    
    self.detailLabel.frame = CGRectMake(70, 30, kScreenWidth - 140, bounds.size.height);
    
    
    
}



+ (CGFloat)setHeightCell:(ShowCommentModel *)model
{
    CGRect bounds = [model.msg boundingRectWithSize:CGSizeMake(kScreenWidth - 140, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:15] forKey:NSFontAttributeName] context:nil];
    
    return 30 + bounds.size.height + 30;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
