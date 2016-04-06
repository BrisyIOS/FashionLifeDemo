//
//  DIYTarentoButton.m
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "DIYTarentoButton.h"

@implementation DIYTarentoButton

- (void)setFrame:(CGRect)frame
{
    [_myLabel removeFromSuperview];
    [_countLabel removeFromSuperview];
    
    
    _myLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, frame.size.width, frame.size.height / 2 - 5)];
    _myLabel.textAlignment = NSTextAlignmentCenter;
    _myLabel.font = [UIFont boldSystemFontOfSize:14];
    _myLabel.textColor = [UIColor whiteColor];
    [self addSubview:_myLabel];
    
    _countLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height / 2, frame.size.width, frame.size.height / 2)];
    _countLabel.textColor = [UIColor whiteColor];
    _countLabel.font = [UIFont boldSystemFontOfSize:12];
    _countLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_countLabel];
    
    [super setFrame:frame];
}

@end
