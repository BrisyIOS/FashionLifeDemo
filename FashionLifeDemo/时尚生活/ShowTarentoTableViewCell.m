//
//  ShowTarentoTableViewCell.m
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "ShowTarentoTableViewCell.h"
#import "Header.h"
#import "UIImageView+WebCache.h"

@implementation ShowTarentoTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        self.page = [[UIPageControl alloc]initWithFrame:CGRectMake(0, kScreenWidth - 30, 100, 30)];
        self.page.currentPage = 0;
        [self addSubview:_page];
        
        self.lostLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, kScreenWidth + 20, kScreenWidth - 40, 30)];
        self.lostLabel.textColor = [UIColor whiteColor];
        self.lostLabel.font = [UIFont boldSystemFontOfSize:17];
        [self.contentView addSubview:_lostLabel];
        
        self.goodLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, kScreenWidth + 20 + 30, kScreenWidth - 40, 30)];
        self.goodLabel.textColor = [UIColor whiteColor];
        self.goodLabel.font = [UIFont boldSystemFontOfSize:17];
        [self.contentView addSubview:_goodLabel];
        
        self.describeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, kScreenWidth + 20 + 30 + 40, kScreenWidth - 40, 30)];
        self.describeLabel.textColor = [UIColor whiteColor];
        self.describeLabel.text = @"商品描述";
        self.describeLabel.font = [UIFont boldSystemFontOfSize:17];
        [self.contentView addSubview:_describeLabel];
        
        self.sizeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, kScreenWidth + 20 + 30 + 40 + 30, kScreenWidth - 40, 30)];
        self.sizeLabel.textColor = [UIColor lightGrayColor];
        self.sizeLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_sizeLabel];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, kScreenWidth + 20 + 30 + 40 + 30 + 50, kScreenWidth - 40, 30)];
        label.textColor = [UIColor whiteColor];
        label.text = @"推荐自:";
        label.font = [UIFont boldSystemFontOfSize:17];
        [self.contentView addSubview:label];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, kScreenWidth + 20 + 30 + 40 + 30 + 50 + 30, kScreenWidth - 120, 30)];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.text = @"时尚生活";
        titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.contentView addSubview:titleLabel];
        
        
        self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, kScreenWidth + 20 + 30 + 40 + 30 + 50 + 30 + 30, kScreenWidth - 40, 30)];
        self.detailLabel.numberOfLines = 0;
        self.detailLabel.textColor = [UIColor lightGrayColor];
        self.detailLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.contentView addSubview:_detailLabel];
        
        
    }
    return self;
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
        i++;
    }
    self.detailLabel.text = _showModel.rec_reason;
    self.sizeLabel.text = _showModel.goods_desc;
    self.lostLabel.text = _showModel.owner_name;
    self.goodLabel.text = _showModel.goods_name;
    self.page.numberOfPages = _showModel.images_item.count;
    self.page.frame = CGRectMake((kScreenWidth - _showModel.images_item.count * 25) / 2 , kScreenWidth - 30, _showModel.images_item.count * 25, 30);
    
   CGRect bounds = [_showModel.rec_reason boundingRectWithSize:CGSizeMake(kScreenWidth - 40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName] context:nil];
    
    self.detailLabel.frame = CGRectMake(20, kScreenWidth + 20 + 30 + 40 + 30 + 50 + 30 + 30, kScreenWidth - 40, bounds.size.height);
}

+ (CGFloat)heightForCell:(ShowTarentoModel *)model
{
 
    CGRect bounds = [model.rec_reason boundingRectWithSize:CGSizeMake(kScreenWidth - 40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName] context:nil];
    return kScreenWidth + 20 + 30 + 40 + 30 + 50 + 30 + 30 + bounds.size.height + 20 + 60;
   
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.page.currentPage = scrollView.contentOffset.x / 375;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
