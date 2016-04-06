//
//  DownloadManagment.h
//  时尚生活
//
//  Created by zhangxu on 15/11/28.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadMovie.h"
@interface DownloadManagment : NSObject

@property(nonatomic, strong)NSMutableDictionary *dic;

+ (instancetype)shareDownloadManagment;

- (DownloadMovie *)addDownloadWithURL:(NSString *)url;

- (DownloadMovie *)findDownloadWithURL:(NSString *)url;

- (NSArray *)allDownload;

@end
