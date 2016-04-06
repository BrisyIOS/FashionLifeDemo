//
//  One_Cell.m
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "One_Cell.h"
#import "UIImageView+WebCache.h"
#import "Header.h"

@interface One_Cell ()
@property (nonatomic,strong) UIImageView *icon;

@end

@implementation One_Cell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        int width = kScreenWidth;
        int height = kScreenWidth/750*446;
        self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [self.contentView addSubview:_icon];
    }
    return self;
}


#pragma mark - 重写set方法
- (void)setStoreModel:(StoreModel *)storeModel{
    _storeModel = storeModel;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:storeModel.pic_url]];
}

@end
