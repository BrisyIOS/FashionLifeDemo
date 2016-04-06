//
//  DownloadHeader.m
//  时尚生活
//
//  Created by zhangxu on 15/11/28.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "DownloadHeader.h"
#import "Header.h"
@implementation DownloadHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont boldSystemFontOfSize:18];
        [self.contentView addSubview:_label];
    }
    return self;
}



@end
