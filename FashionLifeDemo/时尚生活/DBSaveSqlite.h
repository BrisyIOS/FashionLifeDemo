//
//  DBSaveSqlite.h
//  时尚生活
//
//  Created by zhangxu on 15/11/28.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "detailTarentoModel.h"
#import "TarentoModel.h"
#import "MovieModel.h"
@interface DBSaveSqlite : NSObject

+ (sqlite3 *)open;

+ (void)close;

+ (NSArray *)allShareModelSave;

+ (void)addShareModelSaveWithSave:(detailTarentoModel *)save;

+ (detailTarentoModel *)findShareModelSaveWithID:(NSString *)ID;

+ (void)deleteModelSaveWithID:(NSString *)ID;


+ (NSArray *)allTarentoModelSave;

+ (void)addTarentoModelSaveWithSave:(TarentoModel *)save;

+ (TarentoModel *)findTarentoModelSaveWithID:(NSString *)ID;

+ (void)deleteTarentoModelSaveWithID:(NSString *)ID;



+ (NSArray *)allMovieModelSave;

+ (void)addMovieModelSaveWithSave:(MovieModel *)save;

+ (MovieModel *)findMovieModelSaveWithID:(NSString *)ID;

+ (void)deleteMovieModelSaveWithID:(NSString *)ID;


@end
