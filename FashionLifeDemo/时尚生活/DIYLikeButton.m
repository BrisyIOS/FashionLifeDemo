//
//  DIYLikeButton.m
//  时尚生活
//
//  Created by zhangxu on 15/11/27.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "DIYLikeButton.h"

@implementation DIYLikeButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setFrame:(CGRect)frame
{
    [_textLabel removeFromSuperview];
    [_iconImageView removeFromSuperview];
    [_selectIconImageView removeFromSuperview];
    
    
    _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(7, 7, frame.size.height - 14, frame.size.height - 14)];
    [self addSubview:_iconImageView];
    
    _selectIconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(7, 7, frame.size.height - 14, frame.size.height - 14)];
    _selectIconImageView.hidden = YES;
    [self addSubview:_selectIconImageView];
    
    _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.height, 0,frame.size.width - frame.size.height , frame.size.height)];
    _textLabel.textColor = [UIColor whiteColor];
    _textLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_textLabel];
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected
{
    if (selected) {
        _iconImageView.hidden = YES;
        _selectIconImageView.hidden = NO;
    }else
    {
        _iconImageView.hidden = NO;
        _selectIconImageView.hidden = YES;
    }
    
    [super setSelected:selected];
}



@end
