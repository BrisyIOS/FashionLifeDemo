//
//  DBDownloadSqlite.h
//  时尚生活
//
//  Created by zhangxu on 15/11/28.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadManagmenting.h"
#import "DownloadManagentFinish.h"
#import <sqlite3.h>
@interface DBDownloadSqlite : NSObject
+ (sqlite3 *)open;

+ (void)close;

+ (NSArray *)allDownloadFinish;

+ (NSArray *)allDownloading;

+ (void)addDownloadFinishWithFinish:(DownloadManagentFinish *)downloadFinish;

+ (void)addDownloadingWithDownloading:(DownloadManagmenting *)downloading;

+ (DownloadManagentFinish *)findDownloadFinishWithURL:(NSString *)url;

+ (DownloadManagmenting *)findDownloadingWithURL:(NSString *)url;

+ (void)deleteDownloadFinishWithURL:(NSString *)url;

+ (void)deleteDownloadingWithURL:(NSString *)url;

+ (void)updateDownloadProgress:(int)progress withURL:(NSString *)url;

+ (void)updateDownloadState:(BOOL)state withURL:(NSString *)url;
@end
