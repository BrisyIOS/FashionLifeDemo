//
//  DownloadMovieTableViewCell.m
//  时尚生活
//
//  Created by zhangxu on 15/11/28.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "DownloadMovieTableViewCell.h"
#import "Header.h"
@implementation DownloadMovieTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = NO;
        
        CGFloat width = kScreenWidth;
        CGFloat height = kScreenWidth / 750 * 421;
        
        self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
        self.myImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_myImageView];
        
        self.blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, height)];
        self.blackView.alpha = 0.3;
        self.blackView.backgroundColor = [UIColor blackColor];
        [self.myImageView addSubview:_blackView];
        
        
        self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
        self.backView.alpha = 0.3;
        self.backView.backgroundColor = [UIColor blackColor];
        [self.myImageView addSubview:self.backView];
        
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
        [self.myImageView addSubview:view];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        [view addGestureRecognizer:longPress];
        
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, height / 2 - 40, width, 40)];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
        
        self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, height / 2, width, 40)];
        self.detailLabel.textColor = [UIColor whiteColor];
        self.detailLabel.font = [UIFont systemFontOfSize:16];
        self.detailLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_detailLabel];
        
        self.cacheLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, height / 2, width, 40)];
        self.cacheLabel.textColor = [UIColor whiteColor];
        self.cacheLabel.font = [UIFont systemFontOfSize:16];
        self.cacheLabel.hidden = YES;
        self.cacheLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_cacheLabel];
        
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.frame = CGRectMake(width / 2 - 15, height / 2 + 50, 30, 30);
        [self.button setImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
        [self.button setImage:[UIImage imageNamed:@"play"] forState:UIControlStateSelected];
        [self.contentView addSubview:_button];
        
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.deleteButton.frame = CGRectMake(width / 2 - 15, height / 2 + 50, 30, 30);
        [self.deleteButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        self.deleteButton.hidden = YES;
        [self.contentView addSubview:_deleteButton];
        
    }
    return self;
}


- (void)longPress:(UILongPressGestureRecognizer *)longPress
{
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
        {
            [UIView animateWithDuration:0.5 animations:^{
                self.titleLabel.alpha = 0;
                self.detailLabel.alpha = 0;
                self.blackView.alpha = 0;
                self.cacheLabel.alpha = 0;
                self.backView.alpha = 0;
                self.button.alpha = 0;
            }];
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            [UIView animateWithDuration:0.5 animations:^{
                self.titleLabel.alpha = 1;
                self.detailLabel.alpha = 1;
                self.blackView.alpha = 0.3;
                self.cacheLabel.alpha = 1;
                self.backView.alpha = 0.3;
                self.button.alpha = 1;
            }];
            break;
        }
        default:
            break;
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
