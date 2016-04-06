//
//  ThreeCell.m
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "ThreeCell.h"
#import "Header.h"
#import "UIImageView+WebCache.h"

@interface ThreeCell ()
@property (nonatomic,strong) UIImageView *icon;

@end

@implementation ThreeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        int height = kScreenWidth/750*446;
        self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
        self.icon.backgroundColor  = [UIColor yellowColor];
        [self.contentView addSubview:_icon];
    }
    return self;
}


- (void)setStoreModel:(StoreModel *)storeModel{
    _storeModel = storeModel;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:storeModel.pic_url]];
}

@end
