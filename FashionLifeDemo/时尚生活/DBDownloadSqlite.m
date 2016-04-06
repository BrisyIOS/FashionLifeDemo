//
//  DBDownloadSqlite.m
//  时尚生活
//
//  Created by zhangxu on 15/11/28.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "DBDownloadSqlite.h"

@implementation DBDownloadSqlite

+ (sqlite3 *)open
{
    static sqlite3 *db = nil;
    if (db) {
        return db;
    }
    
    NSString *sqlPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject]stringByAppendingPathComponent:@"Download.sqlite"];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:sqlPath] == NO) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Download" ofType:@"sqlite"];
        
        [manager copyItemAtPath:bundlePath toPath:sqlPath error:nil];
        
    }
    NSLog(@"%@", sqlPath);
    sqlite3_open([sqlPath UTF8String], &db);
    return db;
    
}

+ (void)close
{
    sqlite3 *db = [DBDownloadSqlite open];
    sqlite3_close(db);
    db = nil;
}

+ (NSArray *)allDownloadFinish
{
    sqlite3 *db = [DBDownloadSqlite open];
    
    sqlite3_stmt *stmt = nil;
    
    NSMutableArray *array = nil;
    
    int result = sqlite3_prepare_v2(db, "select * from downloadFinish", -1, &stmt, nil);
    if (result == SQLITE_OK) {
        array = [NSMutableArray array];
        while (SQLITE_ROW == sqlite3_step(stmt)) {
            DownloadManagentFinish *downloadFinish = [[DownloadManagentFinish alloc]init];
            
            const unsigned char *cSavePath = sqlite3_column_text(stmt, 0);
            const unsigned char *cUrl = sqlite3_column_text(stmt, 1);
            double time = sqlite3_column_double(stmt, 2);
            
            downloadFinish.savePath = [NSString stringWithUTF8String:(const char *)cSavePath];
            downloadFinish.url = [NSString stringWithUTF8String:(const char *)cUrl];
            downloadFinish.time = time;
            [array addObject:downloadFinish];
        }
    }
    sqlite3_finalize(stmt);
    return array;
}

+ (NSArray *)allDownloading
{
    sqlite3 *db = [DBDownloadSqlite open];
    
    sqlite3_stmt *stmt = nil;
    
    int result = sqlite3_prepare_v2(db, "select * from downloading", -1, &stmt, nil);
    NSMutableArray *array = nil;
    if (result == SQLITE_OK) {
        array = [NSMutableArray array];
        while (SQLITE_ROW == sqlite3_step(stmt)) {
            const unsigned char *cResumeDataStr = sqlite3_column_text(stmt, 0);
            const unsigned char *cFilePath = sqlite3_column_text(stmt, 1);
            const unsigned char *cFileSize = sqlite3_column_text(stmt, 2);
            int progress = sqlite3_column_double(stmt, 3);
            const unsigned char *cUrl = sqlite3_column_text(stmt, 4);
            double time = sqlite3_column_double(stmt, 5);
            
            NSString *resumeDataStr = [NSString stringWithUTF8String:(const char *)cResumeDataStr];
            NSString *filePath = [NSString stringWithUTF8String:(const char *)cFilePath];
            NSString *fileSize = [NSString stringWithUTF8String:(const char *)cFileSize];
            NSString *url = [NSString stringWithUTF8String:(const char *)cUrl];
            DownloadManagmenting *downloading = [[DownloadManagmenting alloc]init];
            
            NSDictionary *dic = @{@"resumeDataStr":resumeDataStr, @"filePath":filePath, @"fileSize":fileSize, @"progress":@(progress), @"url":url,@"time":@(time)};
            
            [downloading setValuesForKeysWithDictionary:dic];
            [array addObject:downloading];
        }
    }
    sqlite3_finalize(stmt);
    return array;
}

+ (void)addDownloadFinishWithFinish:(DownloadManagentFinish *)downloadFinish
{
    sqlite3 *db = [DBDownloadSqlite open];
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    
    NSString *sql = [NSString stringWithFormat:@"insert into downloadFinish values('%@','%@',%f)", downloadFinish.savePath, downloadFinish.url, time];
    sqlite3_exec(db, [sql UTF8String], nil, nil, nil);
    [DBDownloadSqlite deleteDownloadingWithURL:downloadFinish.url];
}

+ (void)addDownloadingWithDownloading:(DownloadManagmenting *)downloading
{
    sqlite3 *db = [DBDownloadSqlite open];
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    
    NSString *sql = [NSString stringWithFormat:@"insert into downloading values('%@', '%@', '%@', %d, '%@', %f, %d)", downloading.resumeDataStr, downloading.filePath, downloading.fileSize, (int)downloading.progress, downloading.url ,time, downloading.isResume];
    sqlite3_exec(db, [sql UTF8String], nil, nil, nil);
}

+ (DownloadManagentFinish *)findDownloadFinishWithURL:(NSString *)url
{
    sqlite3 *db = [DBDownloadSqlite open];
    sqlite3_stmt *stmt = nil;
    
    DownloadManagentFinish *downloadFinish = nil;
    NSString *sql = [NSString stringWithFormat:@"select * from downloadFinish where url = '%@'",url];
    int result = sqlite3_prepare(db, [sql UTF8String], -1 , &stmt, nil);
    if (result == SQLITE_OK) {
        
        while (SQLITE_ROW == sqlite3_step(stmt)) {
            downloadFinish = [[DownloadManagentFinish alloc]init];
            
            const unsigned char *cSavePath = sqlite3_column_text(stmt, 0);
            const unsigned char *cUrl = sqlite3_column_text(stmt, 1);
            double time = sqlite3_column_double(stmt, 2);
            
            downloadFinish.savePath = [NSString stringWithUTF8String:(const char *)cSavePath];
            downloadFinish.url = [NSString stringWithUTF8String:(const char *)cUrl];
            downloadFinish.time = time;
            
        }
    }
    sqlite3_finalize(stmt);
    return downloadFinish;
    
}

+ (DownloadManagmenting *)findDownloadingWithURL:(NSString *)url
{
    sqlite3 *db = [DBDownloadSqlite open];
    sqlite3_stmt *stmt = nil;
    
    DownloadManagmenting *downloading = nil;
    
    NSString *sql = [NSString stringWithFormat:@"select * from downloading where url = '%@'",url];
    int result = sqlite3_prepare(db, [sql UTF8String], -1 , &stmt, nil);
    if (result == SQLITE_OK) {
        
        while (SQLITE_ROW == sqlite3_step(stmt)) {
            const unsigned char *cResumeDataStr = sqlite3_column_text(stmt, 0);
            NSString *resumeDataStr = [NSString stringWithUTF8String:(const char *)cResumeDataStr];
            
            const unsigned char *cFilePath = sqlite3_column_text(stmt, 1);
            NSString *filePath = [NSString stringWithUTF8String:(const char *)cFilePath];
            
            const unsigned char *cFileSize = sqlite3_column_text(stmt, 2);
            NSString *fileSize = [NSString stringWithUTF8String:(const char *)cFileSize];
            
            int progress = sqlite3_column_double(stmt, 3);
            const unsigned char *cUrl = sqlite3_column_text(stmt, 4);
            NSString *url = [NSString stringWithUTF8String:(const char *)cUrl];
            
            double time = sqlite3_column_double(stmt, 5);
            
            BOOL isResume = sqlite3_column_int(stmt, 6);
            
            downloading = [[DownloadManagmenting alloc]init];
            NSDictionary *dic = @{@"resumeDataStr":resumeDataStr, @"filePath":filePath, @"fileSize": fileSize, @"url":url,@"progress":@(progress), @"time":@(time),@"isResume":@(isResume)};
            
            
            [downloading setValuesForKeysWithDictionary:dic];
            
            
            
        }
    }
    sqlite3_finalize(stmt);
    return downloading;
    
}

+ (void)deleteDownloadFinishWithURL:(NSString *)url
{
    sqlite3 *db = [DBDownloadSqlite open];
    NSString *sql = [NSString stringWithFormat:@"delete from downloadFinish where url = '%@'", url];
    sqlite3_exec(db, [sql UTF8String], nil, nil, nil);
}

+ (void)deleteDownloadingWithURL:(NSString *)url
{
    sqlite3 *db = [DBDownloadSqlite open];
    NSString *sql = [NSString stringWithFormat:@"delete from downloading where url = '%@'", url];
    sqlite3_exec(db, [sql UTF8String], nil, nil, nil);
}

+ (void)updateDownloadProgress:(int)progress withURL:(NSString *)url
{
    sqlite3 *db = [DBDownloadSqlite open];
    NSString *sql = [NSString stringWithFormat:@"update downloading set progress = %d where url = '%@'", progress, url];
    sqlite3_exec(db, [sql UTF8String], nil, nil, nil);
}

+ (void)updateDownloadState:(BOOL)state withURL:(NSString *)url
{
    sqlite3 *db = [DBDownloadSqlite open];
    NSString *sql = [NSString stringWithFormat:@"update downloading set isResume = %d where url = '%@'", state, url];
    sqlite3_exec(db, [sql UTF8String], nil, nil, nil);
}



@end
