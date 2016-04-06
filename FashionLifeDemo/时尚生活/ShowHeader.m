//
//  ShowHeader.m
//  时尚生活
//
//  Created by zhangxu on 15/11/27.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "ShowHeader.h"
#import "Header.h"
#import "UIImageView+WebCache.h"
#import "DBSaveSqlite.h"
@implementation ShowHeader


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.page = [[UIPageControl alloc]initWithFrame:CGRectMake(0, kScreenWidth - 30, 100, 30)];
        self.page.currentPage = 0;
        [self addSubview:_page];
        
        self.goodLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, kScreenWidth + 20 , kScreenWidth - 40, 30)];
        self.goodLabel.textColor = [UIColor whiteColor];
        self.goodLabel.font = [UIFont boldSystemFontOfSize:17];
        [self.contentView addSubview:_goodLabel];
        
        self.likeButton = [DIYLikeButton buttonWithType:UIButtonTypeCustom];
        self.likeButton.frame = CGRectMake(kScreenWidth - 100, kScreenWidth + 20 + 30, 100, 40);
        self.likeButton.iconImageView.image = [UIImage imageNamed:@"collect"];
        self.likeButton.selectIconImageView.image = [UIImage imageNamed:@"bookmarked"];
        self.likeButton.textLabel.text = @"收藏";
        
        [self.likeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_likeButton];
        
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, kScreenWidth + 20 + 40, 40, 20)];
        label.backgroundColor = [UIColor lightGrayColor];
        label.textColor = [UIColor whiteColor];
        label.text = @"Link";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:15];
        [self.contentView addSubview:label];
        
        self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, kScreenWidth + 20 + 40 + 40, 40, 40)];
        
        self.myImageView.layer.cornerRadius = 20;
        self.myImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_myImageView];
        
        self.lostLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, kScreenWidth + 20 + 40 + 40, kScreenWidth - 70, 40)];
        self.lostLabel.textColor = [UIColor whiteColor];
        self.lostLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.contentView addSubview:_lostLabel];
        
        self.describeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, kScreenWidth + 20 + 40 + 40 + 40 + 10, kScreenWidth - 40, 40)];
        self.describeLabel.textColor = [UIColor whiteColor];
        self.describeLabel.numberOfLines = 0;
        self.describeLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.contentView addSubview:_describeLabel];
   
    }
    return self;
}

+ (CGFloat)heightForCell:(ShowTarentoModel *)model
{

    CGRect bounds = [model.goods_desc boundingRectWithSize:CGSizeMake(kScreenWidth - 40, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName] context:nil];
    
    
    return kScreenWidth + 30 + 40 + 40 + 30 + 10 + bounds.size.height + 10;
    
}


- (void)buttonAction:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected) {
        
        self.likeButton.textLabel.text = @"已收藏";
        [DBSaveSqlite addShareModelSaveWithSave:_detailModel];
   
        
    }else
    {
        self.likeButton.textLabel.text = @"收藏";
        [DBSaveSqlite deleteModelSaveWithID:_detailModel.goods_id];
    }
}
- (void)setDetailModel:(detailTarentoModel *)detailModel
{
    _detailModel = detailModel;
    if ([DBSaveSqlite findShareModelSaveWithID:_detailModel.goods_id]) {
        self.likeButton.textLabel.text = @"已收藏";
        self.likeButton.selected = YES;
        
    }else
    {
        self.likeButton.textLabel.text = @"收藏";
        self.likeButton.selected = NO;
    }

}

- (void)setNumber:(NSInteger)number
{
    _number = number;
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * _number, kScreenWidth);
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    [self.contentView addSubview:_scrollView];
    
    for (int i = 1; i <= _number; i++) {
        self.smallScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake((i - 1) * kScreenWidth, 0, kScreenWidth, kScreenWidth)];
        self.smallScrollView.delegate = self;
        self.smallScrollView.pagingEnabled = YES;
        self.smallScrollView.showsVerticalScrollIndicator = NO;
        self.smallScrollView.showsHorizontalScrollIndicator = NO;
        [self.scrollView addSubview:_smallScrollView];
        self.iocnImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];

        
        [self.smallScrollView addSubview:_iocnImageView];
        
    }
}

- (void)setShowModel:(ShowTarentoModel *)showModel
{
    _showModel = showModel;
    int i = 0;
   
    for (UIScrollView *smallScrollView in self.scrollView.subviews) {
        UIImageView *myImageView = smallScrollView.subviews[0];
        [myImageView sd_setImageWithURL:[NSURL URLWithString:_showModel.images_item[i]]];
        NSLog(@"images_item ==========%@",showModel.images_item);
        i++;
    }
    self.describeLabel.text = _showModel.goods_desc;
    self.lostLabel.text = [NSString stringWithFormat:@"%@  推荐",_showModel.owner_name];
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:_showModel.owner_image]];
    self.goodLabel.text = _showModel.goods_name;
    self.page.numberOfPages = _showModel.images_item.count;
    self.page.frame = CGRectMake((kScreenWidth - _showModel.images_item.count * 25) / 2 , kScreenWidth - 30, _showModel.images_item.count * 25, 30);
    
    
    CGRect bounds = [_showModel.goods_desc boundingRectWithSize:CGSizeMake(kScreenWidth - 40, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName] context:nil];
    
    self.describeLabel.frame = CGRectMake(20, kScreenWidth + 20 + 40 + 40 + 40 + 10, kScreenWidth - 40, bounds.size.height);
    
}
@end
