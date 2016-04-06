//
//  SearchCell.m
//  时尚生活
//
//  Created by zhangxu on 15/11/28.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "SearchCell.h"
#import "Header.h"
#import "UIImageView+WebCache.h"

@interface SearchCell ()
@property (nonatomic,strong) UIImageView *icon;

@end

@implementation SearchCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        int height = (kScreenWidth - 20)/2;
        self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, height, height)];
        [self.contentView addSubview:_icon];
    }
    return self;
}


- (void)setSearchModel:(SearchModel *)searchModel{
    _searchModel = searchModel;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:searchModel.goods_image]];
}

@end
