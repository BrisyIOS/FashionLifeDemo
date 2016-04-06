//
//  RecommendedViewCell.m
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "RecommendedViewCell.h"

@implementation RecommendedViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        [self.contentView addSubview:_myImageView];
    }
    
    return self;
}


@end
