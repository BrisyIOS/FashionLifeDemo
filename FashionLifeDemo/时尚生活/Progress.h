//
//  Progress.h
//  progress
//
//  Created by zhangxu on 15/11/9.
//  Copyright (c) 2015年 zhangxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProgressDelegate <NSObject>

//点击view后返回的value
- (void)touchView:(float)value;

@end



@interface Progress : UIView

@property(nonatomic, strong, readonly)UISlider *slider;

@property(nonatomic, strong)UIView *thumb;//滑块view

@property(nonatomic, assign)id<ProgressDelegate> delegate;

@property(nonatomic, assign)CGFloat cache;//缓冲进度条的值

@property(nonatomic, weak)UIColor *cacheColor;//缓冲进度条的颜色

@property(nonatomic, strong)UILabel *label;

@end
