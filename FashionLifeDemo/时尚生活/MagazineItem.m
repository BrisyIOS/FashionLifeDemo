//
//  MagazineItem.m
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "MagazineItem.h"
#import "Header.h"
#import "UIImageView+WebCache.h"

@interface MagazineItem ()

@end

@implementation MagazineItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 分类图片
        CGFloat width = (kScreenWidth-60)/2;
        CGFloat height = (kScreenHeight-64-44)/5;
        
        self.bgPicture = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [self.contentView addSubview:self.bgPicture];
        // 加一个黑色的View
        UIView *bgView = [[UIView alloc] initWithFrame:self.bgPicture.frame];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0.4;
        [self.contentView addSubview:bgView];
        // 分类名称
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(0, (height-30)/2, width, 30)];
        //self.name.backgroundColor = [UIColor blueColor];
        self.name.textColor = [UIColor whiteColor];
        self.name.font = [UIFont boldSystemFontOfSize:16];
        self.name.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.name];
    }
    return self;
}
- (void)setModel:(MagazineDetailModel *)model
{
    _model = model;
    [self.bgPicture sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
    self.name.text = model.cat_name;
}


@end
