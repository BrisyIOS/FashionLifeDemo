//
//  CategoryCell.m
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "CategoryHeader.h"
#import "Header.h"
#import "UIImageView+WebCache.h"

@interface CategoryHeader ()
@property (nonatomic,strong) UIImageView *icon;

@end

@implementation CategoryHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        int height = kScreenWidth/750*420;
        self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
        self.icon.userInteractionEnabled = YES;
        [self addSubview:_icon];
        
    }
    return self;
}


#pragma mark - 重写set 方法
- (void)setCoverModel:(CoverModel *)coverModel{
    _coverModel = coverModel;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:coverModel.url]];
}


@end
