//
//  DetailTarentoReusableView.m
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "DetailTarentoReusableView.h"
#import "UIImageView+WebCache.h"
#import "DBSaveSqlite.h"
@interface DetailTarentoReusableView()


@property(nonatomic, assign)CGRect frame;

@end


@implementation DetailTarentoReusableView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _frame = frame;
        
        self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 90, 90)];
        [self addSubview:_myImageView];
        
        self.myLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, frame.size.width - 120, 25)];
        self.myLabel.textColor = [UIColor whiteColor];
        self.myLabel.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:_myLabel];
        
        self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 35, frame.size.width - 120, 15)];
        self.detailLabel.textColor = [UIColor whiteColor];
        self.detailLabel.font = [UIFont boldSystemFontOfSize:12];

        [self addSubview:_detailLabel];
        
        
        self.likeButton = [DIYLikeButton buttonWithType:UIButtonTypeCustom];
        self.likeButton.frame = CGRectMake(120, 60, 100, 40);
        self.likeButton.iconImageView.image = [UIImage imageNamed:@"collect"];
        self.likeButton.selectIconImageView.image = [UIImage imageNamed:@"bookmarked"];
        self.likeButton.textLabel.text = @"收藏";
        [self.likeButton addTarget:self action:@selector(likeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_likeButton];
                                 
        
        
        self.buttonOne = [DIYTarentoButton buttonWithType:UIButtonTypeCustom];
        self.buttonOne.frame = CGRectMake(0, 110, frame.size.width / 4, 40);
        self.buttonOne.myLabel.text = @"喜欢";
        self.buttonOne.tag = 100;
        self.buttonOne.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_buttonOne];
        
        self.buttonTwo = [DIYTarentoButton buttonWithType:UIButtonTypeCustom];
        self.buttonTwo.frame = CGRectMake(frame.size.width / 4, 110, frame.size.width / 4, 40);
        self.buttonTwo.tag = 200;
        self.buttonTwo.myLabel.text = @"推荐";
        self.buttonTwo.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_buttonTwo];
        
        self.buttonThree = [DIYTarentoButton buttonWithType:UIButtonTypeCustom];
        self.buttonThree.frame = CGRectMake(frame.size.width / 2, 110, frame.size.width / 4, 40);
        self.buttonThree.tag = 300;
        self.buttonThree.myLabel.text = @"关注";
        self.buttonThree.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_buttonThree];
        
        self.buttonFour = [DIYTarentoButton buttonWithType:UIButtonTypeCustom];
        self.buttonFour.frame = CGRectMake(frame.size.width / 2 + frame.size.width / 4, 110, frame.size.width / 4, 40);
        self.buttonFour.tag = 400;
        self.buttonFour.myLabel.text = @"粉丝";
        self.buttonFour.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_buttonFour];
        
    }
    return self;
}

- (void)likeButtonAction:(UIButton *)button
{
    button.selected = !button.selected;
    
    if (button.selected) {
        [DBSaveSqlite addTarentoModelSaveWithSave:_model];
        
        self.likeButton.textLabel.text = @"已收藏";
    }else
    {
        [DBSaveSqlite deleteTarentoModelSaveWithID:_model.user_id];
        self.likeButton.textLabel.text = @"收藏";
    }
    
}


- (void)setModel:(TarentoModel *)model
{
    _model = model;
    self.myLabel.text = _model.user_name;
    self.detailLabel.text = _model.user_desc;
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:model.user_image]];
    
    if ([DBSaveSqlite findTarentoModelSaveWithID:_model.user_id]) {
        self.likeButton.textLabel.text = @"已收藏";
        self.likeButton.selected = YES;
        
    }else
    {
        self.likeButton.textLabel.text = @"收藏";
        self.likeButton.selected = NO;
    }
    
}
- (void)setDetailModel:(DetailCountModel *)detailModel
{
    _detailModel = detailModel;
    
    self.buttonOne.countLabel.text = _detailModel.like_count;
    self.buttonTwo.countLabel.text = _detailModel.recommendation_count;
    self.buttonThree.countLabel.text = _detailModel.following_count;
    self.buttonFour.countLabel.text = _detailModel.followed_count;
}

@end
