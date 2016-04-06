//
//  Progress.m
//  progress
//
//  Created by zhangxu on 15/11/9.
//  Copyright (c) 2015年 zhangxu. All rights reserved.
//

#import "Progress.h"


@interface Progress()

@property(nonatomic, strong)UIView *cacheView;

@end


@implementation Progress
{
    CGFloat centerX;//用于保存centerX的位置
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc
{
//    代理置空
    _delegate = nil;
//    移除KVO
    [self.thumb removeObserver:self forKeyPath:@"frame"];
    [self.slider removeObserver:self forKeyPath:@"value"];
    NSLog(@"thumb slider 已被销毁");
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //        缓冲条在我们slider的上面 滑块的下面
        self.cacheView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 2)];
        self.cacheView.userInteractionEnabled = NO;
        [self addSubview:self.cacheView];
        
//        我们继承于UIView而不继承与UISlider的原因UISlider内部添加的任何view 都处于progress线的下面 所以我们继承与UIView 把创建的view添加到整个slider的上面
//     记得一定要是self.bounds self.frame 的话可能会造成视图偏差
    
        
        _slider = [[UISlider alloc]initWithFrame:self.bounds];
//        设置我们的slider的图片 给一个空的图片
        [self.slider setThumbImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];
//        self.slider.minimumValue = 0;
//        self.slider.maximumValue = frame.size.width;
        
        self.slider.maximumTrackTintColor = [UIColor clearColor];
        
//        添加一个方法 获取value改变的属性 从而对thumb的位置进行修改
        [self.slider addTarget:self action:@selector(valueChange:other:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.slider];
        
        
//        添加tap 手势 让滑块跳转到指定位置
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
        //centerX 初始值
        centerX = 0;
        

        
        
        
        //        添加KVO 用户改变了frame的大小 我对center做一个修改
        [self.thumb addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];

//        创建我们的滑块视图
        self.thumb = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        self.thumb.backgroundColor = [UIColor whiteColor];
        self.thumb.center = CGPointMake(0, frame.size.height / 2);
//        我们把用户交互关闭 防止响应者链断开 造成slider不可以滑动
        self.thumb.userInteractionEnabled = NO;
        self.thumb.layer.cornerRadius = 10;
        [self addSubview:self.thumb];
        
        
        
        
//     添加一个KVO 观察我们的slider的value值 然后 对滑块的位置进行修改
        [self.slider addObserver:self forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:nil];
        
        self.label = [[UILabel alloc]init];
        self.label.frame = CGRectMake(0, 0, self.frame.size.height + 20, self.frame.size.height / 2);
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.textColor = [UIColor blackColor];
        self.label.hidden = YES;
        [self.thumb addSubview:_label];
        

//        [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(work) userInfo:nil repeats:YES];
        
    }
    return self;
}

#pragma mark --KVO执行的方法--
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"frame"]) {
        self.thumb.center = CGPointMake(centerX, self.frame.size.height / 2);
    }else
    {
//        修改滑块位置
        CGFloat progress = self.slider.value / (self.slider.maximumValue - self.slider.minimumValue);
        self.thumb.center = CGPointMake(self.frame.size.width * progress, self.frame.size.height / 2);
      
    }
}


#pragma mark --tap手势执行的方法--
- (void)tapAction:(UITapGestureRecognizer *)tap
{
//    我们要获取tap手势上边的一个点
    CGPoint point = [tap locationInView:tap.view];
        NSLog(@"%f", point.x);
//    范围判断
    if (point.x < 0) {
        point.x = 0;
    }else if (point.x > self.frame.size.width)
    {
        point.x = self.frame.size.width;
    }
    
    
//    求出这个点所在的百分比

    CGFloat progress = point.x / self.frame.size.width;
//    根据百分比 计算出value的值
    CGFloat value = (self.slider.maximumValue - self.slider.minimumValue) * progress;
    self.slider.value = value;
    self.thumb.center = CGPointMake(point.x, self.frame.size.height / 2);
    
    //    保存centerX 的值
    centerX = self.thumb.center.x;
    
    //    传递参数
    if ([_delegate respondsToSelector:@selector(touchView:)]) {
        [_delegate touchView:value];
    }
}



#pragma mark --滑动滑块执行的方法--
- (void)valueChange:(UISlider *)slider other:(UIEvent *)event
{
    
    
    //    求出value所在的百分比
    CGFloat progress = slider.value / (slider.maximumValue - slider.minimumValue);
    //    求出thumb的x轴的位置
    CGFloat thumbX = self.frame.size.width * progress;
//    self.thumb.frame = CGRectMake(thumbX, 0, self.frame.size.height + 20, self.frame.size.height / 2);
//    
//    
//    
//    self.thumb.center = CGPointMake(thumbX, self.frame.size.height / 2);
    
    //    保存centerX 的值
    centerX = self.thumb.center.x;

    
    UITouch *touch = [[event allTouches]anyObject];
    switch (touch.phase) {
        case UITouchPhaseBegan:
        {
            self.label.hidden = NO;
            self.thumb.frame = CGRectMake(thumbX, 0, self.frame.size.height + 20, self.frame.size.height / 2);
            break;
        }
        case UITouchPhaseMoved:
        {
            self.thumb.center = CGPointMake(thumbX, self.frame.size.height / 2);
            break;
        }
        case UITouchPhaseEnded:
        {
            self.label.hidden = YES;
            self.thumb.frame = CGRectMake(thumbX, 0, 20, 20);
    
            break;
        }
        default:
            break;
    }
}


//- (void)setLabel:(UILabel *)label
//{
//    _label = label;
//    self.label.text = @"00:00";
//}

#pragma mark --更换视图执行的方法--
- (void)setThumb:(UIView *)thumb
{
//    先移除观察者
    [_thumb removeObserver:self forKeyPath:@"frame"];
//    移除之前的视图
    [_thumb removeFromSuperview];
//    添加新的视图
    [self addSubview:thumb];
//    指针赋值
    _thumb = thumb;
//    添加新的观察者
    [_thumb addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    
//    让它走一次KVO的方法 
    _thumb.frame = thumb.frame;
    
}

#pragma mark --外部更改frame 内部子视图也坐相应的修改--
- (void)setFrame:(CGRect)frame
{

    [super setFrame:frame];
    
    self.slider.frame = self.bounds;
    
}

#pragma mark --根据cacheValue进行赋值--
- (void)setCache:(CGFloat)cache
{
//    进行判断
    if (cache < self.slider.minimumValue) {
        cache = self.slider.minimumValue;
    }else if (cache > self.slider.maximumValue){
        cache = self.slider.maximumValue;
    }
    
//    求出百分比
    CGFloat progress = cache / (self.slider.maximumValue - self.slider.minimumValue);
//    对cacheView的frame进行赋值
    self.cacheView.frame = CGRectMake(0, (self.frame.size.height - 2) / 2, progress * self.frame.size.width, 2);
    
}

#pragma mark --更改我们缓冲条的背景颜色--
- (void)setCacheColor:(UIColor *)cacheColor
{
    self.cacheView.backgroundColor = cacheColor;
}


//- (void)s
//{
//    self.thumb.center = CGPointMake(self.slider.value, self.frame.size.height / 2);
//}





@end
