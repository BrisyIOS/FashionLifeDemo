//
//  MovieTableViewCell.m
//  时尚生活
//
//  Created by zhangxu on 15/11/27.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "MovieTableViewCell.h"
#import "Header.h"
#import "UIImageView+WebCache.h"
@interface MovieTableViewCell()

@property(strong, nonatomic)UIImageView *myImageView;
@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)UILabel *timeLabel;
@property(strong, nonatomic)UILabel *shareLabel;
@property(strong, nonatomic)UIImageView *lookImageView;
@property(strong, nonatomic)UIImageView *shareImageView;


@end

@implementation MovieTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat width = kScreenWidth;
        CGFloat height = width / 750 * 421;
        
        self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
        self.myImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_myImageView];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.3;
        [self.myImageView addSubview:view];
        
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        [view addGestureRecognizer:longPress];
        
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, height / 2 + 30 , kScreenWidth, 30)];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
        
        
        
        self.lookImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, height / 2 + 30 + 30 + 2 + 5, 16, 16)];
        self.lookImageView.image = [UIImage imageNamed:@"iconfont-shijian"];
        [self.contentView addSubview:_lookImageView];
        
        
        self.shareImageView = [[UIImageView alloc]initWithFrame:CGRectMake(40 + 60, height / 2 + 30 + 30 + 2 + 5, 16, 16)];
        self.shareImageView.image = [UIImage imageNamed:@"iconfont-fenxiang-9"];
        [self.contentView addSubview:_shareImageView];

        
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, height / 2 + 30 + 30 + 5, 60, 20)];
        self.timeLabel.textColor = [UIColor whiteColor];
        self.timeLabel.font = [UIFont systemFontOfSize:15];
        
        [self.contentView addSubview:_timeLabel];
        
        
        self.shareLabel = [[UILabel alloc]initWithFrame:CGRectMake(40 + 60 + 20, height / 2 + 30 + 30 + 5, 60, 20)];
        self.shareLabel.textColor = [UIColor whiteColor];
        self.shareLabel.font = [UIFont systemFontOfSize:15];
        
        [self.contentView addSubview:_shareLabel];
        
    }
    
    return self;
}

- (void)setModel:(MovieModel *)model
{
    _model = model;
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:_model.pimg]];
    self.titleLabel.text = _model.title;
    self.timeLabel.text = [NSString stringWithFormat:@"%.2ld : %.2ld", [_model.pviewtimeint integerValue]  / 60 , [_model.pviewtimeint integerValue] % 60];
    self.shareLabel.text = _model.count_share;
    
}


- (void)longPress:(UILongPressGestureRecognizer *)longPress
{
    UIView *view = self.myImageView.subviews[0];
    if (longPress.state == UIGestureRecognizerStateBegan) {
        [UIView animateWithDuration:0.5 animations:^{
            self.timeLabel.alpha = 0;
            self.titleLabel.alpha = 0;
            self.shareLabel.alpha = 0;
            view.alpha = 0;
        }];
    }else if (longPress.state == UIGestureRecognizerStateEnded){
        [UIView animateWithDuration:0.5 animations:^{
            self.timeLabel.alpha = 1;
            self.titleLabel.alpha = 1;
            self.shareLabel.alpha = 1;
            view.alpha = 0.3;
        }];
    }
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
