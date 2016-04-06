//
//  DownloadManagment.m
//  时尚生活
//
//  Created by zhangxu on 15/11/28.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "DownloadManagment.h"

@implementation DownloadManagment


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dic = [NSMutableDictionary dictionary];
    }
    return self;
}


+ (instancetype)shareDownloadManagment
{
    static DownloadManagment *downloadManagment = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downloadManagment = [[DownloadManagment alloc]init];
    });
    return downloadManagment;
}

- (DownloadMovie *)addDownloadWithURL:(NSString *)url
{
  
    DownloadMovie *download = self.dic[url];
    if (download == nil) {
        download = [[DownloadMovie alloc]initWithURL:url];
        [self.dic setObject:download forKey:url];
    }
    
    [download downloadComplted:^(NSString *url) {
        [self.dic removeObjectForKey:url];
    }];
    
    return download;
}

- (DownloadMovie *)findDownloadWithURL:(NSString *)url
{
    return self.dic[url];
}

- (NSArray *)allDownload
{
    return [self.dic allValues];
}



@end
