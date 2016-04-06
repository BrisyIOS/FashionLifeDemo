//
//  MovieDetailTableViewCell.m
//  时尚生活
//
//  Created by zhangxu on 15/11/27.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "MovieDetailTableViewCell.h"
#import "Header.h"
#import "UIImageView+WebCache.h"
#import "DBSaveSqlite.h"
#import "DBDownloadSqlite.h"
#import "DownloadMovie.h"
#import "DownloadManagment.h"
#import "DBCacheSqlite.h"

@interface MovieDetailTableViewCell()
@property(nonatomic, strong)UIImageView *myImageView;

@property(nonatomic, strong)UIImageView *playImageView;

@property(nonatomic, strong)UILabel *titleLabel;

@property(nonatomic, strong)UIView *titleView;

@property(nonatomic, strong)UILabel *detailLabel;

@property(nonatomic, strong)UILabel *lookLabel;

@property(nonatomic, strong)DIYLikeButton *likeButton;

@property(nonatomic, strong)DIYLikeButton *downButton;



@property(nonatomic, strong)UIImageView *lookImageView;

@end



@implementation MovieDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        CGFloat width = kScreenWidth;
        CGFloat height = width / 750 * 421;
        
        self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
        self.myImageView.userInteractionEnabled = YES;

        [self.contentView addSubview:_myImageView];
        
        self.playImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 65, 65)];
        
        self.playImageView.image = [UIImage imageNamed:@"play"];
        self.playImageView.center = CGPointMake(width / 2, height / 2);
        
        [self.myImageView addSubview:_playImageView];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, height + 20, width - 20, 60)];
    
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [self.contentView addSubview:_titleLabel];
        
        
        self.titleView = [[UIView alloc]initWithFrame:CGRectMake(10, height + 100, width - 20, 40)];
        [self.contentView addSubview:_titleView];
        
        self.lookImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 20, 20)];
        self.lookImageView.image = [UIImage imageNamed:@"iconfont-faxian-on"];
        [self.titleView addSubview:_lookImageView];
        
 
        self.shareButton = [DIYLikeButton buttonWithType:UIButtonTypeCustom];
        self.shareButton.frame = CGRectMake(80, 5, (kScreenWidth - 20 - 80) / 3, 30);
        self.shareButton.iconImageView.image = [UIImage imageNamed:@"iconfont-fenxiang-9"];
        self.shareButton.showsTouchWhenHighlighted = YES;
       
        [self.titleView addSubview:_shareButton];
        
        
        self.lookLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 40)];
        self.lookLabel.font = [UIFont systemFontOfSize:14];
        self.lookLabel.textAlignment = NSTextAlignmentCenter;
        self.lookLabel.textColor = [UIColor whiteColor];
        [self.titleView addSubview:_lookLabel];
        
        
        
        self.likeButton = [DIYLikeButton buttonWithType:UIButtonTypeCustom];
        self.likeButton.frame = CGRectMake(80 + (kScreenWidth - 20 - 80) / 3 * 2, 5, (kScreenWidth - 20 - 80) / 3, 30);
        self.likeButton.iconImageView.image = [UIImage imageNamed:@"collect"];
        self.likeButton.selectIconImageView.image = [UIImage imageNamed:@"bookmarked"];
        self.likeButton.textLabel.text = @"收藏";
        [self.likeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleView addSubview:_likeButton];
        
        
        self.downButton = [DIYLikeButton buttonWithType:UIButtonTypeCustom];
        self.downButton.frame = CGRectMake(80 + (kScreenWidth - 20 - 80) / 3, 5, (kScreenWidth - 20 - 80) / 3, 30);
        self.downButton.showsTouchWhenHighlighted = YES;
        self.downButton.iconImageView.image = [UIImage imageNamed:@"download"];
        self.downButton.textLabel.text = @"缓存";
        [self.downButton addTarget:self action:@selector(downloadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleView addSubview:_downButton];
        
        
        self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, height + 150, width - 30, 40)];
        self.detailLabel.numberOfLines = 0;
        self.detailLabel.textColor = [UIColor lightGrayColor];
        self.detailLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_detailLabel];

        
        
        
    }
    return self;
}


- (void)setModel:(MovieModel *)model
{
    _model = model;
    
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:_model.pimg]];
    self.titleLabel.text = _model.title;
    self.detailLabel.text = _model.intro;
    self.lookLabel.text = _model.count_view;
    self.shareButton.textLabel.text = _model.count_share;
    CGRect bounds = [_model.intro boundingRectWithSize:CGSizeMake(kScreenWidth - 30, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName] context:nil];
    self.detailLabel.frame = CGRectMake(15, kScreenWidth / 750 * 421 + 150, kScreenWidth - 30, bounds.size.height);
    
    if ([DBSaveSqlite findMovieModelSaveWithID:_model.source_link]) {
        self.likeButton.textLabel.text = @"已收藏";
        self.likeButton.selected = YES;
        
    }else
    {
        self.likeButton.textLabel.text = @"收藏";
        self.likeButton.selected = NO;
    }
    
    DownloadMovie *download = [[DownloadManagment shareDownloadManagment]addDownloadWithURL:_model.video];
    
    
    if ([DBDownloadSqlite findDownloadFinishWithURL:_model.video]) {
        self.downButton.textLabel.text = @"已缓存";
        self.downButton.iconImageView.image = [UIImage imageNamed:@"downloadCompleted"];
        self.model.savePath = [DBDownloadSqlite findDownloadFinishWithURL:_model.video].savePath;
    }else if ([DBDownloadSqlite findDownloadingWithURL:_model.video])
    {
        self.downButton.textLabel.text = [NSString stringWithFormat:@"%d%%", (int)[DBDownloadSqlite findDownloadingWithURL:_model.video].progress];
        
        if ([DBDownloadSqlite findDownloadingWithURL:_model.video].isResume == 0) {
            [download resume];
            [DBDownloadSqlite updateDownloadState:NO withURL:_model.video];
        }
    }
    [download downloadFinish:^(NSString *savePath, NSString *url) {
        self.downButton.textLabel.text = @"已缓存";
        self.downButton.iconImageView.image = [UIImage imageNamed:@"downloadCompleted"];
        self.model.savePath = savePath;
    } downloading:^(float progress, float byesWritten) {
        self.downButton.textLabel.text = [NSString stringWithFormat:@"%d%%", (int)progress];
    }];

}

+ (CGFloat)heightForCell:(MovieModel *)model
{
    CGRect bounds = [model.intro boundingRectWithSize:CGSizeMake(kScreenWidth - 30, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName] context:nil];

    return kScreenWidth / 750 * 421 + 150 + bounds.size.height + 20;
    
}


- (void)buttonAction:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected) {
        [DBSaveSqlite addMovieModelSaveWithSave:_model];
        self.likeButton.textLabel.text = @"已收藏";
    }else
    {
        [DBSaveSqlite deleteMovieModelSaveWithID:_model.source_link];
        self.likeButton.textLabel.text = @"收藏";
    }
}

- (void)downloadButtonAction:(UIButton *)button
{
    
    if ([DBDownloadSqlite findDownloadFinishWithURL:_model.video]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该视频已经缓存" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alertView show];
        
        return;
    }
    
    
    
    
    DownloadMovie *download = [[DownloadManagment shareDownloadManagment]addDownloadWithURL:_model.video];
    
    if ([DBDownloadSqlite findDownloadingWithURL:_model.video]) {
        
        if ([DBDownloadSqlite findDownloadingWithURL:_model.video].isResume == 1) {
            [download resume];
            
            [DBDownloadSqlite updateDownloadState:NO withURL:_model.video];
        }else
        {
            [download suspend];
            [DBDownloadSqlite updateDownloadState:YES withURL:_model.video];
        }
        
    }else
    {
        self.downButton.textLabel.text = @"加载中...";
        [download resume];
        
        if (![DBCacheSqlite findCacheingWithURL:_model.video]) {
            [DBCacheSqlite addCacheingWithDownloading:_model];
        }
    }
    
    [download downloadFinish:^(NSString *savePath, NSString *url) {
        self.downButton.textLabel.text = @"已缓存";
        self.downButton.iconImageView.image = [UIImage imageNamed:@"downloadCompleted"];
        self.model.savePath = savePath;
    } downloading:^(float progress, float byesWritten) {
        self.downButton.textLabel.text = [NSString stringWithFormat:@"%d%%", (int)progress];
    }];
    

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
