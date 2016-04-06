//
//  DownloadMovie.h
//  时尚生活
//
//  Created by zhangxu on 15/11/28.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^DownloadComplted)(NSString *url);
typedef void(^DownloadFinish)(NSString *savePath, NSString *url);
typedef void(^Downloading)(float progress, float byesWritten);

@interface DownloadMovie : NSObject
@property(nonatomic, assign)float progress;

@property(nonatomic, strong)NSString *url;

@property(nonatomic, copy)DownloadFinish downloadFinish;

@property(nonatomic, copy)Downloading downloading;

@property(nonatomic, copy)DownloadComplted downloadComplted;

- (void)downloadFinish:(DownloadFinish)downloadFinish downloading:(Downloading)downloading;

- (void)downloadComplted:(DownloadComplted)downloadComplted;

- (instancetype)initWithURL:(NSString *)url;

- (void)resume;

- (void)suspend;


@end
