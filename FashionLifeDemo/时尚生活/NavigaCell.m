//
//  NavigaCell.m
//  时尚生活
//
//  Created by zhangxu on 15/11/27.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "NavigaCell.h"
#import "Header.h"

@interface NavigaCell ()


@end

@implementation NavigaCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/3, 46)];
        self.label.textColor = [UIColor grayColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_label];
    }
    return self;
}

@end
