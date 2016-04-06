//
//  Two_Cell.m
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "Two_Cell.h"
#import "UIImageView+WebCache.h"

@interface Two_Cell ()
@property (nonatomic,strong) UIImageView *icon;

@end

@implementation Two_Cell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.icon = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_icon];
        
    }
    return self;
}

- (void)setStoreModel:(StoreModel *)storeModel{
    _storeModel = storeModel;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:storeModel.pic_url]];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    _icon.frame = self.bounds;
}

@end
