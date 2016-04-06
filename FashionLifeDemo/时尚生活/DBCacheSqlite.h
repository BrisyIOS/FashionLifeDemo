//
//  DBCacheSqlite.h
//  时尚生活
//
//  Created by zhangxu on 15/11/28.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieModel.h"
#import <sqlite3.h>
@interface DBCacheSqlite : NSObject


+ (sqlite3 *)open;

+ (void)close;

+ (NSArray *)allCacheFinish;

+ (NSArray *)allCacheing;

+ (void)addCacheFinishWithFinish:(MovieModel *)CacheFinish;

+ (void)addCacheingWithDownloading:(MovieModel *)Cacheing;

+ (MovieModel *)findCacheFinishWithURL:(NSString *)url;

+ (MovieModel *)findCacheingWithURL:(NSString *)url;

+ (void)deleteCacheFinishWithURL:(NSString *)url;

+ (void)deleteCacheingWithURL:(NSString *)url;


@end
