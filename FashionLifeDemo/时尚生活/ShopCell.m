//
//  ShopCell.m
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "ShopCell.h"
#import "Header.h"
#import "UIImageView+WebCache.h"

@interface ShopCell ()
@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *typeLabel;

@end

@implementation ShopCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        // 图片
        int width = (kScreenWidth - 30)/2;
        self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        [self.contentView addSubview:_icon];
        
        
        // 名称
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, width, width, 40)];
        self.nameLabel.textColor = [UIColor grayColor];
        self.nameLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_nameLabel];
        
        
        // 类型
        self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nameLabel.frame), width, 25)];
        self.typeLabel.font = [UIFont systemFontOfSize:13];
        self.typeLabel.textColor = [UIColor cyanColor];
        [self.contentView addSubview:_typeLabel];
        
        
    }
    return self;
}


- (void)setShopModel:(ShopModel *)shopModel{
    _shopModel = shopModel;
    if (self.isBrand) {
        [self.icon sd_setImageWithURL:[NSURL URLWithString:shopModel.images[0][@"url"]]];
         self.nameLabel.text = shopModel.name;
        return;
    }
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:shopModel.goods_image]];
    self.nameLabel.text = shopModel.goods_name;
    self.typeLabel.text = shopModel.brand_info[@"brand_name"];
    
}

@end
