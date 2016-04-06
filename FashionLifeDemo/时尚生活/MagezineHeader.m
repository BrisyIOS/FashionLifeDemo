//
//  MagezineHeader.m
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "MagezineHeader.h"
#import "Header.h"

@interface MagezineHeader ()

@property (nonatomic, strong) UILabel *title;
@end

@implementation MagezineHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.backgroundColor = [UIColor blackColor];
        self.title.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.title];
    }
    return self;
}
- (void)setTitleStr:(NSString *)titleStr
{
    _titleStr = titleStr;
    self.title.text = titleStr;
}

@end
