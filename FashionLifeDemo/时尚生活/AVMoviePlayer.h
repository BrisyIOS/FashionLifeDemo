//
//  AVMoviePlayer.h
//  时尚生活
//
//  Created by zhangxu on 15/11/30.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIYLikeButton.h"
#import <AVFoundation/AVFoundation.h>
typedef NS_ENUM(NSInteger, nPanDirection){
    
    nPanDirectionHorizontalMoved,
    nPanDirectionVerticalMoved
    
};
@interface AVMoviePlayer : UIView

@property (nonatomic,assign)BOOL isPlaying;

- (instancetype)initWithFrame:(CGRect)frame URL:(NSURL *)URL;

@property(nonatomic, strong)AVPlayerLayer *playerLayer;

@property(nonatomic, strong)AVPlayer *player;

@property(nonatomic, strong)AVPlayerItem *playerItem;

@property(nonatomic, strong)NSString *string;

@property(nonatomic, assign)NSTimer *timer;

@property(nonatomic, strong)DIYLikeButton *backButton;

@end
