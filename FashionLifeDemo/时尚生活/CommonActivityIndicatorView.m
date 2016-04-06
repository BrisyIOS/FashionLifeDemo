
//  CommonActivityIndicatorView.m
//  DouBan
//
//  Created by zhangxu on 15/10/26.
//  Copyright (c) 2015年 zhangxu. All rights reserved.
//

#import "CommonActivityIndicatorView.h"
#import "Header.h"
#import "NetWorkState.h"

@implementation CommonActivityIndicatorView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
        self.bounds = CGRectMake(0, 0, 100, 100);
       
        self.layer.cornerRadius = 10;
        self.backgroundColor = [UIColor darkGrayColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 100, 40)];
        self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        label.text = @"Loading...";
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:13 weight:0.001];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        [self startAnimating];
    }
    return self;
}


- (void)endCommonActivity{
    [self stopAnimating];
    [self removeFromSuperview];
}



@end
