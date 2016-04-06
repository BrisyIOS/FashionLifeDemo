//
//  DBSaveSqlite.m
//  时尚生活
//
//  Created by zhangxu on 15/11/28.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "DBSaveSqlite.h"

@implementation DBSaveSqlite

+ (sqlite3 *)open
{
    static sqlite3 *db = nil;
    if (db) {
        return db;
    }
    
    NSString *sqlPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]stringByAppendingPathComponent:@"ShareAndTarento.sqlite"];
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:sqlPath] == NO) {
        
        NSString *bubdlePath = [[NSBundle mainBundle]pathForResource:@"ShareAndTarento" ofType:@"sqlite"];
        [manager copyItemAtPath:bubdlePath toPath:sqlPath error:nil];
        
    }
    NSLog(@"%@", sqlPath);
    sqlite3_open([sqlPath UTF8String], &db);
    return db;
    
    
}

+ (void)close
{
    sqlite3 *db = [DBSaveSqlite open];
    sqlite3_close(db);
    db = nil;
}

+ (NSArray *)allShareModelSave
{
    sqlite3 *db = [DBSaveSqlite open];
    sqlite3_stmt *stmt = nil;
    
    NSMutableArray *array = nil;
    
    int result = sqlite3_prepare_v2(db, "select * from saveShare", -1, &stmt, nil);
    if (result == SQLITE_OK) {
        array = [NSMutableArray array];
        
        while (SQLITE_ROW == sqlite3_step(stmt)) {
            detailTarentoModel *model = [[detailTarentoModel alloc]init];
            
            const unsigned char *goods_image = sqlite3_column_text(stmt, 0);
            const unsigned char *goods_id = sqlite3_column_text(stmt, 1);
            
            const unsigned char *goods_name = sqlite3_column_text(stmt, 2);
            
            model.goods_name = [NSString stringWithUTF8String:(const char *)goods_name];
            model.goods_id = [NSString stringWithUTF8String:(const char *)goods_id];
            model.goods_image = [NSString stringWithUTF8String:(const char *)goods_image];
            
            [array addObject:model];
            
        }
    }
    
    sqlite3_finalize(stmt);
    return array;
    
}

+ (void)addShareModelSaveWithSave:(detailTarentoModel *)save
{
    sqlite3 *db = [DBSaveSqlite open];
    
    NSString *sql = [NSString stringWithFormat:@"insert into saveShare values('%@','%@','%@')", save.goods_image, save.goods_id, save.goods_name];
    sqlite3_exec(db, [sql UTF8String], nil, nil, nil);
}

+ (detailTarentoModel *)findShareModelSaveWithID:(NSString *)ID
{
    sqlite3 *db = [DBSaveSqlite open];
    sqlite3_stmt *stmt = nil;
    detailTarentoModel *model = nil;
    NSString *sql = [NSString stringWithFormat:@"select * from saveShare where goods_id = '%@'", ID];
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil);
    
    if (result == SQLITE_OK) {
        while (SQLITE_ROW == sqlite3_step(stmt)) {
            model = [[detailTarentoModel alloc]init];
            const unsigned char *goods_image = sqlite3_column_text(stmt, 0);
            const unsigned char *goods_id = sqlite3_column_text(stmt, 1);
            
            const unsigned char *goods_name = sqlite3_column_text(stmt, 2);
            
            model.goods_name = [NSString stringWithUTF8String:(const char *)goods_name];
            model.goods_id = [NSString stringWithUTF8String:(const char *)goods_id];
            model.goods_image = [NSString stringWithUTF8String:(const char *)goods_image];
            
        }
    }
    sqlite3_finalize(stmt);
    return model;
    
}

+ (void)deleteModelSaveWithID:(NSString *)ID
{
    sqlite3 *db = [DBSaveSqlite open];
    NSString *sql = [NSString stringWithFormat:@"delete from saveShare where goods_id = '%@'", ID];
    sqlite3_exec(db, [sql UTF8String], nil, nil, nil);
}

+ (NSArray *)allTarentoModelSave
{
    sqlite3 *db = [DBSaveSqlite open];
    sqlite3_stmt *stmt = nil;
    
    NSMutableArray *array = nil;
    
    int result = sqlite3_prepare_v2(db, "select * from saveTarento", -1, &stmt, nil);
    if (result == SQLITE_OK) {
        array = [NSMutableArray array];
        
        while (SQLITE_ROW == sqlite3_step(stmt)) {
            TarentoModel *model = [[TarentoModel alloc]init];
            
            const unsigned char *user_desc = sqlite3_column_text(stmt, 0);
            const unsigned char *user_id = sqlite3_column_text(stmt, 1);
            
            const unsigned char *user_image = sqlite3_column_text(stmt, 2);
            const unsigned char *user_name = sqlite3_column_text(stmt, 3);
            
            model.user_desc = [NSString stringWithUTF8String:(const char *)user_desc];
            model.user_id = [NSString stringWithUTF8String:(const char *)user_id];
            model.user_image = [NSString stringWithUTF8String:(const char *)user_image];
            model.user_name = [NSString stringWithUTF8String:(const char *)user_name];
            
            [array addObject:model];
            
        }
    }
    
    sqlite3_finalize(stmt);
    return array;

}

+ (void)addTarentoModelSaveWithSave:(TarentoModel *)save
{
    sqlite3 *db = [DBSaveSqlite open];
    
    NSString *sql = [NSString stringWithFormat:@"insert into saveTarento values('%@','%@','%@', '%@')", save.user_desc, save.user_id, save.user_image, save.user_name];
    sqlite3_exec(db, [sql UTF8String], nil, nil, nil);

}

+ (TarentoModel *)findTarentoModelSaveWithID:(NSString *)ID
{
    sqlite3 *db = [DBSaveSqlite open];
    sqlite3_stmt *stmt = nil;
    TarentoModel *model = nil;
    NSString *sql = [NSString stringWithFormat:@"select * from saveTarento where user_id = '%@'", ID];
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil);
    
    if (result == SQLITE_OK) {
        while (SQLITE_ROW == sqlite3_step(stmt)) {
            model = [[TarentoModel alloc]init];
            const unsigned char *user_desc = sqlite3_column_text(stmt, 0);
            const unsigned char *user_id = sqlite3_column_text(stmt, 1);
            
            const unsigned char *user_image = sqlite3_column_text(stmt, 2);
            const unsigned char *user_name = sqlite3_column_text(stmt, 3);
            
            model.user_desc = [NSString stringWithUTF8String:(const char *)user_desc];
            model.user_id = [NSString stringWithUTF8String:(const char *)user_id];
            model.user_image = [NSString stringWithUTF8String:(const char *)user_image];
            model.user_name = [NSString stringWithUTF8String:(const char *)user_name];
            
        }
    }
    sqlite3_finalize(stmt);
    return model;

}

+ (void)deleteTarentoModelSaveWithID:(NSString *)ID
{
    sqlite3 *db = [DBSaveSqlite open];
    NSString *sql = [NSString stringWithFormat:@"delete from saveTarento where user_id = '%@'", ID];
    sqlite3_exec(db, [sql UTF8String], nil, nil, nil);
}

+ (NSArray *)allMovieModelSave
{
    sqlite3 *db = [DBSaveSqlite open];
    sqlite3_stmt *stmt = nil;
    
    NSMutableArray *array = nil;
    
    int result = sqlite3_prepare_v2(db, "select * from saveMovie", -1, &stmt, nil);
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
            
            model.count_share = [NSString stringWithUTF8String:(const char *)count_share];
            model.title = [NSString stringWithUTF8String:(const char *)title];
            model.pviewtime = [NSString stringWithUTF8String:(const char *)pviewtime];
            model.pimg = [NSString stringWithUTF8String:(const char *)pimg];
            model.pviewtimeint = [NSString stringWithUTF8String:(const char *)pviewtimeint];
            model.intro = [NSString stringWithUTF8String:(const char *)intro];
            model.count_view = [NSString stringWithUTF8String:(const char *)count_view];
            model.source_link = [NSString stringWithUTF8String:(const char *)source_link];
            model.video = [NSString stringWithUTF8String:(const char *)video];
            
            [array addObject:model];
            
        }
    }
    
    sqlite3_finalize(stmt);
    return array;

}

+ (void)addMovieModelSaveWithSave:(MovieModel *)save
{
    sqlite3 *db = [DBSaveSqlite open];
    
    NSString *sql = [NSString stringWithFormat:@"insert into saveMovie values('%@','%@','%@', '%@','%@','%@','%@', '%@', '%@')", save.count_share, save.title, save.pviewtime, save.pimg, save.pviewtimeint, save.intro, save.count_view, save.source_link, save.video];
    sqlite3_exec(db, [sql UTF8String], nil, nil, nil);
}

+ (MovieModel *)findMovieModelSaveWithID:(NSString *)ID
{
    sqlite3 *db = [DBSaveSqlite open];
    sqlite3_stmt *stmt = nil;
    MovieModel *model = nil;
    NSString *sql = [NSString stringWithFormat:@"select * from saveMovie where source_link = '%@'", ID];
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
            
            model.count_share = [NSString stringWithUTF8String:(const char *)count_share];
            model.title = [NSString stringWithUTF8String:(const char *)title];
            model.pviewtime = [NSString stringWithUTF8String:(const char *)pviewtime];
            model.pimg = [NSString stringWithUTF8String:(const char *)pimg];
            model.pviewtimeint = [NSString stringWithUTF8String:(const char *)pviewtimeint];
            model.intro = [NSString stringWithUTF8String:(const char *)intro];
            model.count_view = [NSString stringWithUTF8String:(const char *)count_view];
            model.source_link = [NSString stringWithUTF8String:(const char *)source_link];
            model.video = [NSString stringWithUTF8String:(const char *)video];
            
        }
    }
    sqlite3_finalize(stmt);
    return model;

}

+ (void)deleteMovieModelSaveWithID:(NSString *)ID
{
    sqlite3 *db = [DBSaveSqlite open];
    NSString *sql = [NSString stringWithFormat:@"delete from saveMovie where source_link = '%@'", ID];
    sqlite3_exec(db, [sql UTF8String], nil, nil, nil);
}


@end
