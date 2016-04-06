//
//  Four_Cell.m
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "Four_Cell.h"
#import "Header.h"
#import "UIImageView+WebCache.h"

@interface Four_Cell ()
@property (nonatomic,strong) UIImageView *icon;

@end

@implementation Four_Cell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        int width = kScreenWidth/2;
        int height = width;
        self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [self.contentView addSubview:_icon];
    }
    return self;
}

- (void)setStoreModel:(StoreModel *)storeModel{
    _storeModel = storeModel;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:storeModel.pic_url]];
}


@end
