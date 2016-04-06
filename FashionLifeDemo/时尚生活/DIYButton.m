//
//  DIYButton.m
//  Eyes
//
//  Created by zhangxu on 15/11/5.
//  Copyright (c) 2015年 蒋修强. All rights reserved.
//

#import "DIYButton.h"

@implementation DIYButton

// 重写Button的fram方法，在里面修改视图
- (void)setFrame:(CGRect)frame
{
    // 因为这个方法会多次调用，所以先删除之前的，避免视图堆积
    [_tlLabel removeFromSuperview];
    [_iconImageView removeFromSuperview];
    
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    
    // 创建label
    _tlLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width-15, height)];
    _tlLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.tlLabel];
    
    // 创建视图
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width-15, 10, 15, 15)];
    [self addSubview:self.iconImageView];

    // 调用super setFram方法
    [super setFrame:frame];
}

@end
