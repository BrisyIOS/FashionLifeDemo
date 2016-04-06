//
//  AVMoviePlayer.m
//  时尚生活
//
//  Created by zhangxu on 15/11/30.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "AVMoviePlayer.h"
#import "Progress.h"
#import <MediaPlayer/MediaPlayer.h>

@interface AVMoviePlayer()<ProgressDelegate>

@property(nonatomic, strong)UIButton *button;

@property(nonatomic, strong)UILabel *beginLabel;

@property(nonatomic, strong)UILabel *endLabel;

@property(nonatomic, strong)Progress *progress;

@property(nonatomic, strong)UISlider *volume;

@property(nonatomic, strong)UIView *view;

@property(nonatomic, strong)UISlider *volumeslider;

@property(nonatomic, strong)UILabel *horizontalLabel;

@property(nonatomic, strong)NSURL *url;

@property(nonatomic, assign)BOOL isDownload;





@end


@implementation AVMoviePlayer

{
    nPanDirection panDirection;
    
    BOOL isVolume;
    
    CGFloat sumTime;
    
    float _currents;
    
    float _currentTwo;
}

- (void)dealloc{
    NSLog(@"视图已被销毁");

    [self removeObserverFromOlayerItme:self.playerItem];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [self.playerLayer removeFromSuperlayer];

    [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
    self.playerItem = nil;
    self.player = nil;

}

- (instancetype)initWithFrame:(CGRect)frame URL:(NSURL *)URL
{
    self = [super initWithFrame:frame];
    if (self) {
        _url = URL;
        _isPlaying = YES;
        
   
        _playerItem= [AVPlayerItem playerItemWithURL:_url];
        self.player = [AVPlayer playerWithPlayerItem:_playerItem];

        self.backgroundColor = [UIColor blackColor];
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
       
        
        // 让视频填充屏幕
        self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        self.playerLayer.frame = self.frame;
        [self.layer addSublayer:_playerLayer];
        
        
        // 添加观察者
        [self addObserverToPlayerItem:_playerItem];
        [self.player play];
      
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.frame = CGRectMake(0, 0, 65, 65);
        self.button.center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
        self.button.hidden = YES;
        [self.button setImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
        [self.button setImage:[UIImage imageNamed:@"play"] forState:UIControlStateSelected];
   
        [self.button addTarget:self action:@selector(playMovie:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
        
        
        
        CGFloat height = 40;
        
        self.view = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - height, frame.size.width, height)];

        
        self.beginLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, height)];
        self.beginLabel.text = @"00:00";
        self.beginLabel.textColor = [UIColor whiteColor];
        self.beginLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_beginLabel];
        
        //        创建进度条
        CGFloat progressX = self.beginLabel.frame.size.width;
        self.progress = [[Progress alloc]initWithFrame:CGRectMake(60, 0, frame.size.width - progressX * 2, height)];
        [self.progress.slider addTarget:self action:@selector(progressAction:other:) forControlEvents:UIControlEventValueChanged];
        //        设置代理
        self.progress.delegate = self;
        self.progress.cacheColor = [UIColor whiteColor];
        [self.view addSubview:self.progress];
        
        //        创建总时长的label
        self.endLabel = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width - progressX, 0, progressX, height)];
        self.endLabel.textAlignment = NSTextAlignmentCenter;
        self.endLabel.textColor = [UIColor whiteColor];
        self.endLabel.text = @"--:--";
        [self.view addSubview:_endLabel];
        self.view.hidden = YES;
        [self addSubview:_view];

        _backButton = [DIYLikeButton buttonWithType:UIButtonTypeCustom];
        self.backButton.frame = CGRectMake(0, 0, frame.size.width, 30);
        self.backButton.iconImageView.image = [UIImage imageNamed:@"back"];
        [self addSubview:self.backButton];
        
        
        MPVolumeView *volume = [[MPVolumeView alloc]initWithFrame:CGRectMake(-100, -100, 10, 10)];
        for (UIView *view in volume.subviews) {
            if ([view isKindOfClass:[UISlider class]]) {
                
                self.volumeslider = (UISlider *)view;
                
                self.volume.value = self.volumeslider.value;
                
            }
        }
        
        [self addSubview:volume];
        
        self.volume = [[UISlider alloc]initWithFrame:CGRectMake(0, 0, frame.size.height / 2.5, 30)];
        self.volume.center = CGPointMake(50, frame.size.height / 2);
        self.volume.transform = CGAffineTransformMakeRotation(M_PI_2 * 3);
        self.volume.hidden = YES;
        [self.volume setThumbImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];
        [self addSubview:_volume];
        
        
        UIButton *upButton = [UIButton buttonWithType:UIButtonTypeCustom];
        upButton.frame = CGRectMake(self.volume.frame.size.height, 0, 20, 20);
        [upButton setImage:[UIImage imageNamed:@"maxVolume"] forState:UIControlStateNormal];
        [self.volume addSubview:upButton];
        
        UIButton *downButton = [UIButton buttonWithType:UIButtonTypeCustom];
        downButton.frame = CGRectMake(-20, 0, 20, 20);
        [downButton setImage:[UIImage imageNamed:@"miniVolume"] forState:UIControlStateNormal];
        [self.volume addSubview:downButton];
        
        
        self.horizontalLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height / 1.5, frame.size.width, 40)];
        self.horizontalLabel.textColor = [UIColor whiteColor];
        self.horizontalLabel.textAlignment = NSTextAlignmentCenter;
        self.horizontalLabel.hidden = YES;
        [self addSubview:_horizontalLabel];
    }
    return self;
}

- (void)panAction:(UIPanGestureRecognizer *)pan
{
    CGPoint velocityPoint = [pan velocityInView:pan.view];
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            CGFloat x = fabs(velocityPoint.x);
            CGFloat y = fabs(velocityPoint.y);
            if (x > y) {
                panDirection = nPanDirectionHorizontalMoved;
                
                self.horizontalLabel.hidden = NO;
                
//                sumTime = self.moviePlayer.currentPlaybackTime;
                
                sumTime = self.playerItem.currentTime.value / self.playerItem.currentTime.timescale;
                
            }else if (x < y)
            {
                panDirection = nPanDirectionVerticalMoved;
                self.volume.hidden = NO;
                isVolume = YES;
            }
            
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            switch (panDirection) {
                case nPanDirectionHorizontalMoved:
                {
                    [self horizontalMoved:velocityPoint.x];
                    
                    break;
                }
                case nPanDirectionVerticalMoved:
                {
                    [self verticalMoved:velocityPoint.y];
                    
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            switch (panDirection) {
                case nPanDirectionHorizontalMoved:
                {
                    self.horizontalLabel.hidden = YES;
                    CMTime currentTime = CMTimeMake(sumTime, 1);                     [self seekToMyTime:currentTime];
                    sumTime = 0;
                    break;
                }
                case nPanDirectionVerticalMoved:
                {
                    self.volume.hidden = YES;
                    isVolume = NO;
                    break;
                }
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
    
}
- (void)seekToMyTime:(CMTime)time
{
    [_player pause];
    
    
    [_player seekToTime:time completionHandler:^(BOOL finished) {
        if (_isPlaying) {
            [_player play];
        }
    }];
}

- (void)verticalMoved:(CGFloat)value
{
    self.volume.value = self.volume.value - value / 10000;
    self.volumeslider.value = self.volume.value;
}
- (void)horizontalMoved:(CGFloat)value
{
    NSString *style = nil;
    if (value > 0) {
        style = @">>";
    }else
    {
        style = @"<<";
    }
    
    sumTime += value / 200;
    
    if (sumTime < 0) {
        sumTime = 0;
    }else if (sumTime > self.playerItem.duration.value)
    {
        sumTime = self.playerItem.duration.value;
    }
    
    NSString *nowTime = [self durationStringWithTime:sumTime];
    
    NSString *durationTime = [self durationStringWithTime:(NSTimeInterval)CMTimeGetSeconds([self.playerItem duration])];
    
    self.horizontalLabel.text = [NSString stringWithFormat:@"%@%@ : %@", style, nowTime, durationTime];
    
    
}

#pragma  mark --进度条滑动时的方法--
- (void)progressAction:(UISlider *)progress other:(UIEvent *)event
{
    //    拿到我们的手指
    UITouch *touch = [[event allTouches] anyObject];
    
    //    保证视图不消失
    [self viewNoDisMiss];
    
    switch (touch.phase) {
        case UITouchPhaseBegan:{
            
            break;
        }
        case UITouchPhaseMoved:{
            
            break;
        }
        case UITouchPhaseEnded:{
            
            CMTime dragedCMTime = CMTimeMake(self.progress.slider.value * CMTimeGetSeconds(self.playerItem.duration), 1);
           
            [self seekToMyTime:dragedCMTime];

            break;
        }
        default:
            break;
    }
}

#pragma mark --progress进度条的代理方法--
- (void)touchView:(float)value
{
    CMTime dragedCMTime = CMTimeMake(value * CMTimeGetSeconds([self.playerItem duration]), 1);
    [self seekToMyTime:dragedCMTime];
}

- (void)playBackState:(NSTimer *)timer
{
    // 获取当前播放时间
    float current = CMTimeGetSeconds(self.playerItem.currentTime);
    
    // 获取总的播放时长
    float total = CMTimeGetSeconds(self.playerItem.duration);
    NSLog(@"total ====== %f",total);
 
    _currents = total;
    _currentTwo = current;
    self.beginLabel.text = [self durationStringWithTime:(NSTimeInterval)current];
    self.endLabel.text = [self durationStringWithTime:(NSTimeInterval)total];
    
    self.progress.label.text = [self durationStringWithTime:(NSTimeInterval)current];
    if (current) {
        
        if (!self.progress.slider.highlighted) {
            self.progress.slider.value = (float)current / total;
            NSLog(@"%f",self.progress.slider.value);
            self.progress.thumb.frame = CGRectMake(self.progress.slider.value * self.progress.frame.size.width , 0, 20, 20);
            self.progress.thumb.center = CGPointMake(self.progress.slider.value  * self.progress.frame.size.width + 5, self.progress.frame.size.height / 2);
            self.progress.label.hidden = YES;
        }
    }

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    AVPlayerItem *playerItem=object;
    if ([keyPath isEqualToString:@"status"]) {
        
        self.backButton.hidden = YES;
        self.isDownload = YES;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
        self.playerItem =self.player.currentItem;
   
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
        [self addGestureRecognizer:pan];
        
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(playBackState:) userInfo:nil repeats:YES];

        AVPlayerStatus status= [[change objectForKey:@"new"] intValue];
        if(status==AVPlayerStatusReadyToPlay){
//            NSLog(@"正在播放...，视频总长度:%.2f",CMTimeGetSeconds(playerItem.duration));
        }
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSArray *array=playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
//        NSLog(@"共缓冲：%.2f",totalBuffer);
        self.progress.cache = totalBuffer / _currents;
        
        
   }
}


#pragma mark --根据时长求出字符串--
- (NSString *)durationStringWithTime:(NSTimeInterval)time
{
    //    获取分钟
    NSString *min = [NSString stringWithFormat:@"%.2d", (int)time / 60];
    //    获取秒数
    NSString *s = [NSString stringWithFormat:@"%.2d",(int)time % 60];
    return [NSString stringWithFormat:@"%@:%@", min, s];
    
}

- (void)playMovie:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected) {
        [self.player pause];
        _isPlaying = NO;
    }else
    {
        [self.player play];
        _isPlaying = YES;
    }
    [self viewNoDisMiss];
}

- (void)addObserverToPlayerItem:(AVPlayerItem *)playItme
{
    [playItme addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [playItme addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObserverFromOlayerItme:(AVPlayerItem *)playerItem
{
    [playerItem removeObserver:self forKeyPath:@"status"];
    [playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}
#pragma mark --tap手势执行方法--
- (void)tapAction:(UITapGestureRecognizer *)tap
{

    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(work) object:nil];
    
    self.button.hidden = !self.button.hidden;
    self.view.hidden = !self.view.hidden;
    self.backButton.hidden = !self.backButton.hidden;
    self.volume.hidden = self.view.hidden;
    
    [self performSelector:@selector(work) withObject:nil afterDelay:3];
    
}
#pragma mark --保证视图不消失--
- (void)viewNoDisMiss
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(work) object:nil];
    [self performSelector:@selector(work) withObject:nil afterDelay:3];
    
}
- (void)work
{
    if (!self.button.selected) {
        self.button.hidden = YES;
        self.view.hidden = YES;
        self.backButton.hidden = YES;
        
        if (!isVolume) {
            self.volume.hidden = YES;
        }
    }
}

@end
