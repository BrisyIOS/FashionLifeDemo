//
//  DBCacheSqlite.m
//  时尚生活
//
//  Created by zhangxu on 15/11/28.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "DBCacheSqlite.h"

@implementation DBCacheSqlite

+ (sqlite3 *)open
{
    static sqlite3 *db = nil;
    if (db) {
        return db;
    }
    
    NSString *sqlPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]stringByAppendingPathComponent:@"CacheMovie.sqlite"];
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:sqlPath] == NO) {
        
        NSString *bubdlePath = [[NSBundle mainBundle]pathForResource:@"CacheMovie" ofType:@"sqlite"];
        [manager copyItemAtPath:bubdlePath toPath:sqlPath error:nil];
        
    }
    NSLog(@"%@", sqlPath);
    sqlite3_open([sqlPath UTF8String], &db);
    return db;

}

+ (void)close
{
    sqlite3 *db = [DBCacheSqlite open];
    sqlite3_close(db);
    db = nil;
}

+ (NSArray *)allCacheFinish
{
    sqlite3 *db = [DBCacheSqlite open];
    
    sqlite3_stmt *stmt = nil;
    
    NSMutableArray *array = nil;
    
    int result = sqlite3_prepare_v2(db, "select * from cacheFinish", -1, &stmt, nil);
    if (result == SQLITE_OK) {
        array = [NSMutableArray array];
        while (SQLITE_ROW == sqlite3_step(stmt)) {
            MovieModel *model = [[MovieModel alloc]init];
            
            const unsigned char *count_share = sqlite3_column_text(stmt, 0);
            const unsigned char *title = sqlite3_column_text(stmt, 1);
            
            const unsigned char *pviewtime = sqlite3_column_text(stmt, 2);
            const unsigned char *pimg = sqlite3_column_text(stmt, 3);
            
            const unsigned char *pviewtimeint = sqlite3_column_text(stmt, 4);
            const unsigned char *intro = sqlite3_column_text(stmt, 5);
            
            const unsigned char *count_view = sqlite3_column_text(stmt, 6);
            const unsigned char *source_link = sqlite3_column_text(stmt, 7);
            const unsigned char *video = sqlite3_column_text(stmt, 8);
            
            const unsigned char *saveParh = sqlite3_column_text(stmt, 9);
            
            
            model.count_share = [NSString stringWithUTF8String:(const char *)count_share];
            model.title = [NSString stringWithUTF8String:(const char *)title];
            model.pviewtime = [NSString stringWithUTF8String:(const char *)pviewtime];
            model.pimg = [NSString stringWithUTF8String:(const char *)pimg];
            model.pviewtimeint = [NSString stringWithUTF8String:(const char *)pviewtimeint];
            model.intro = [NSString stringWithUTF8String:(const char *)intro];
            model.count_view = [NSString stringWithUTF8String:(const char *)count_view];
            model.source_link = [NSString stringWithUTF8String:(const char *)source_link];
            model.video = [NSString stringWithUTF8String:(const char *)video];
            model.savePath = [NSString stringWithUTF8String:(const char *)saveParh];
            
            [array addObject:model];
        }
    }
    sqlite3_finalize(stmt);
    return array;

}

+ (NSArray *)allCacheing
{
    sqlite3 *db = [DBCacheSqlite open];
    
    sqlite3_stmt *stmt = nil;
    
    NSMutableArray *array = nil;
    
    int result = sqlite3_prepare_v2(db, "select * from cacheing", -1, &stmt, nil);
    if (result == SQLITE_OK) {
        array = [NSMutableArray array];
        while (SQLITE_ROW == sqlite3_step(stmt)) {
            MovieModel *model = [[MovieModel alloc]init];
            
            const unsigned char *count_share = sqlite3_column_text(stmt, 0);
            const unsigned char *title = sqlite3_column_text(stmt, 1);
            
            const unsigned char *pviewtime = sqlite3_column_text(stmt, 2);
            const unsigned char *pimg = sqlite3_column_text(stmt, 3);
            
            const unsigned char *pviewtimeint = sqlite3_column_text(stmt, 4);
            const unsigned char *intro = sqlite3_column_text(stmt, 5);
            
            const unsigned char *count_view = sqlite3_column_text(stmt, 6);
            const unsigned char *source_link = sqlite3_column_text(stmt, 7);
            const unsigned char *video = sqlite3_column_text(stmt, 8);
            
            const unsigned char *saveParh = sqlite3_column_text(stmt, 9);
            
            
            model.count_share = [NSString stringWithUTF8String:(const char *)count_share];
            model.title = [NSString stringWithUTF8String:(const char *)title];
            model.pviewtime = [NSString stringWithUTF8String:(const char *)pviewtime];
            model.pimg = [NSString stringWithUTF8String:(const char *)pimg];
            model.pviewtimeint = [NSString stringWithUTF8String:(const char *)pviewtimeint];
            model.intro = [NSString stringWithUTF8String:(const char *)intro];
            model.count_view = [NSString stringWithUTF8String:(const char *)count_view];
            model.source_link = [NSString stringWithUTF8String:(const char *)source_link];
            model.video = [NSString stringWithUTF8String:(const char *)video];
            model.savePath = [NSString stringWithUTF8String:(const char *)saveParh];
            
            [array addObject:model];
        }
    }
    sqlite3_finalize(stmt);
    return array;
}

+ (void)addCacheFinishWithFinish:(MovieModel *)CacheFinish
{
    sqlite3 *db = [DBCacheSqlite open];
    
    NSString *sql = [NSString stringWithFormat:@"insert into cacheFinish values('%@','%@','%@', '%@','%@','%@','%@', '%@', '%@', '%@')", CacheFinish.count_share, CacheFinish.title, CacheFinish.pviewtime, CacheFinish.pimg, CacheFinish.pviewtimeint, CacheFinish.intro, CacheFinish.count_view, CacheFinish.source_link, CacheFinish.video, CacheFinish.savePath];
    sqlite3_exec(db, [sql UTF8String], nil, nil, nil);
    
    [DBCacheSqlite deleteCacheingWithURL:CacheFinish.video];
}

+ (void)addCacheingWithDownloading:(MovieModel *)Cacheing
{
    sqlite3 *db = [DBCacheSqlite open];
    
    NSString *sql = [NSString stringWithFormat:@"insert into cacheing values('%@','%@','%@', '%@','%@','%@','%@', '%@', '%@', '%@')", Cacheing.count_share, Cacheing.title, Cacheing.pviewtime, Cacheing.pimg, Cacheing.pviewtimeint, Cacheing.intro, Cacheing.count_view, Cacheing.source_link, Cacheing.video, Cacheing.savePath];
    
    sqlite3_exec(db, [sql UTF8String], nil, nil, nil);
}

+ (MovieModel *)findCacheFinishWithURL:(NSString *)url
{
    sqlite3 *db = [DBCacheSqlite open];
    sqlite3_stmt *stmt = nil;
    MovieModel *model = nil;
    NSString *sql = [NSString stringWithFormat:@"select * from cacheFinish where video = '%@'", url];
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil);
    
    if (result == SQLITE_OK) {
        while (SQLITE_ROW == sqlite3_step(stmt)) {
            model = [[MovieModel alloc]init];
            const unsigned char *count_share = sqlite3_column_text(stmt, 0);
            const unsigned char *title = sqlite3_column_text(stmt, 1);
            
            const unsigned char *pviewtime = sqlite3_column_text(stmt, 2);
            const unsigned char *pimg = sqlite3_column_text(stmt, 3);
            
            const unsigned char *pviewtimeint = sqlite3_column_text(stmt, 4);
            const unsigned char *intro = sqlite3_column_text(stmt, 5);
            
            const unsigned char *count_view = sqlite3_column_text(stmt, 6);
            const unsigned char *source_link = sqlite3_column_text(stmt, 7);
            const unsigned char *video = sqlite3_column_text(stmt, 8);
            
            const unsigned char *saveParh = sqlite3_column_text(stmt, 9);
            
            
            model.count_share = [NSString stringWithUTF8String:(const char *)count_share];
            model.title = [NSString stringWithUTF8String:(const char *)title];
            model.pviewtime = [NSString stringWithUTF8String:(const char *)pviewtime];
            model.pimg = [NSString stringWithUTF8String:(const char *)pimg];
            model.pviewtimeint = [NSString stringWithUTF8String:(const char *)pviewtimeint];
            model.intro = [NSString stringWithUTF8String:(const char *)intro];
            model.count_view = [NSString stringWithUTF8String:(const char *)count_view];
            model.source_link = [NSString stringWithUTF8String:(const char *)source_link];
            model.video = [NSString stringWithUTF8String:(const char *)video];
            model.savePath = [NSString stringWithUTF8String:(const char *)saveParh];
            
        }
    }
    sqlite3_finalize(stmt);
    return model;

}

+ (MovieModel *)findCacheingWithURL:(NSString *)url
{
    sqlite3 *db = [DBCacheSqlite open];
    sqlite3_stmt *stmt = nil;
    MovieModel *model = nil;
    NSString *sql = [NSString stringWithFormat:@"select * from cacheing where video = '%@'", url];
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil);
    
    if (result == SQLITE_OK) {
        while (SQLITE_ROW == sqlite3_step(stmt)) {
            model = [[MovieModel alloc]init];
            const unsigned char *count_share = sqlite3_column_text(stmt, 0);
            const unsigned char *title = sqlite3_column_text(stmt, 1);
            
            const unsigned char *pviewtime = sqlite3_column_text(stmt, 2);
            const unsigned char *pimg = sqlite3_column_text(stmt, 3);
            
            const unsigned char *pviewtimeint = sqlite3_column_text(stmt, 4);
            const unsigned char *intro = sqlite3_column_text(stmt, 5);
            
            const unsigned char *count_view = sqlite3_column_text(stmt, 6);
            const unsigned char *source_link = sqlite3_column_text(stmt, 7);
            const unsigned char *video = sqlite3_column_text(stmt, 8);
            
            const unsigned char *saveParh = sqlite3_column_text(stmt, 9);
            
            
            model.count_share = [NSString stringWithUTF8String:(const char *)count_share];
            model.title = [NSString stringWithUTF8String:(const char *)title];
            model.pviewtime = [NSString stringWithUTF8String:(const char *)pviewtime];
            model.pimg = [NSString stringWithUTF8String:(const char *)pimg];
            model.pviewtimeint = [NSString stringWithUTF8String:(const char *)pviewtimeint];
            model.intro = [NSString stringWithUTF8String:(const char *)intro];
            model.count_view = [NSString stringWithUTF8String:(const char *)count_view];
            model.source_link = [NSString stringWithUTF8String:(const char *)source_link];
            model.video = [NSString stringWithUTF8String:(const char *)video];
            model.savePath = [NSString stringWithUTF8String:(const char *)saveParh];
            
        }
    }
    sqlite3_finalize(stmt);
    return model;

}

+ (void)deleteCacheFinishWithURL:(NSString *)url
{
    sqlite3 *db = [DBCacheSqlite open];
    NSString *sql = [NSString stringWithFormat:@"delete from cacheFinish where video = '%@'", url];
    sqlite3_exec(db, [sql UTF8String], nil, nil, nil);
    
}

+ (void)deleteCacheingWithURL:(NSString *)url
{
    sqlite3 *db = [DBCacheSqlite open];
    NSString *sql = [NSString stringWithFormat:@"delete from cacheing where video = '%@'", url];
    sqlite3_exec(db, [sql UTF8String], nil, nil, nil);
}



@end
