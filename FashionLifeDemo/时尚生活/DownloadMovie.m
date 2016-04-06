//
//  DownloadMovie.m
//  时尚生活
//
//  Created by zhangxu on 15/11/28.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import "DownloadMovie.h"
#import "DownloadManagmenting.h"
#import "DBDownloadSqlite.h"
#import "DownloadManagentFinish.h"
#import "DBCacheSqlite.h"
#import "DBCacheSqlite.h"
#import "MovieModel.h"
@interface DownloadMovie()<NSURLSessionDownloadDelegate>

@property(nonatomic, strong)NSURLSessionDownloadTask *task;

@property(nonatomic, strong)NSURLSession *session;

@end



@implementation DownloadMovie
{
    BOOL _isFirst;
}

- (instancetype)initWithURL:(NSString *)url
{
    self = [super init];
    if (self) {
        _url = url;
        
        NSURLSessionConfiguration *cgf = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        self.session = [NSURLSession sessionWithConfiguration:cgf delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        
        _isFirst = [DBDownloadSqlite findDownloadingWithURL:url];
        
        if (_isFirst) {
            NSData *data = [self resumeDataWithURL:url];
            
            self.task = [self.session downloadTaskWithResumeData:data];
            
            
        }else
        {
            self.task = [self.session downloadTaskWithURL:[NSURL URLWithString:url]];
        }
    }
    return self;
}

- (NSData *)resumeDataWithURL:(NSString *)url
{
    DownloadManagmenting *downloading = [DBDownloadSqlite findDownloadingWithURL:url];
    
    
    _progress = downloading.progress;
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSString *nowFileSize = [NSString stringWithFormat:@"%llu", [manager attributesOfItemAtPath:downloading.filePath error:nil].fileSize];
    
    downloading.resumeDataStr = [downloading.resumeDataStr stringByReplacingOccurrencesOfString:downloading.fileSize withString:nowFileSize];
    
    return  [downloading.resumeDataStr dataUsingEncoding:NSUTF8StringEncoding];
}

- (void)resume
{
    
    if (self.task.state == NSURLSessionTaskStateCompleted && [DBDownloadSqlite findDownloadFinishWithURL:_url] == nil) {
        NSData *data = [self resumeDataWithURL:_url];
        self.task = [self.session downloadTaskWithResumeData:data];
    }else if (self.task.state == NSURLSessionTaskStateRunning)
    {
        return;
    }
    _isFirst = NO;
    [self.task resume];
}

- (void)suspend
{
    [self.task suspend];
}
- (void)downloadFinish:(DownloadFinish)downloadFinish downloading:(Downloading)downloading
{
    self.downloadFinish = downloadFinish;
    self.downloading = downloading;
}
- (void)downloadComplted:(DownloadComplted)downloadComplted
{
    self.downloadComplted = downloadComplted;
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    
    NSString *savePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject]stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    [manager moveItemAtPath:location.path toPath:savePath error:nil];
    
    DownloadManagentFinish *downloadFinish = [[DownloadManagentFinish alloc]init];
    
    downloadFinish.url = _url;
    downloadFinish.savePath = savePath;
    [DBDownloadSqlite addDownloadFinishWithFinish:downloadFinish];
    
    if (self.downloadFinish) {
        self.downloadFinish(savePath, _url);
    }
    
    if (self.downloadComplted) {
        self.downloadComplted(_url);
    }
    
    [self.session invalidateAndCancel];
}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    if (_isFirst == NO) {
        [self cancleDownloadTask];
        _isFirst = YES;
    }
    
    
    float progress = (float)totalBytesWritten / totalBytesExpectedToWrite;
    
    [DBDownloadSqlite updateDownloadProgress: (float)progress * 100 withURL:_url];
    
    if (self.downloading) {
        self.downloading(progress * 100, bytesWritten);
    }
    
}

- (void)cancleDownloadTask
{
    __weak typeof (self)vc = self;
    [self.task cancelByProducingResumeData:^(NSData *resumeData) {
        [self parsingResumeData:resumeData];
        vc.task = [self.session downloadTaskWithResumeData:resumeData];
        [vc.task resume];
    }];
}

- (void)parsingResumeData:(NSData *)resumeData
{
    NSString *resumeDataStr = [[NSString alloc]initWithData:resumeData encoding:NSUTF8StringEncoding];
    
    NSString *fileSize = [resumeDataStr componentsSeparatedByString:@"<key>NSURLSessionResumeBytesReceived</key>\n\t<integer>"].lastObject;
    fileSize = [fileSize componentsSeparatedByString:@"</integer>"].firstObject;
    
    NSString *filePath = [resumeDataStr componentsSeparatedByString:@"<key>NSURLSessionResumeInfoLocalPath</key>\n\t<string>"].lastObject;
    filePath = [filePath componentsSeparatedByString:@"</string>"].firstObject;

    DownloadManagmenting *downloading = [[DownloadManagmenting alloc]init];
    downloading.resumeDataStr = resumeDataStr;
    downloading.filePath = filePath;
    downloading.fileSize = fileSize;
    downloading.url = _url;
    
//    if (![DBDownloadSqlite findDownloadingWithURL:_url]) {
        [DBDownloadSqlite addDownloadingWithDownloading:downloading];
//    }
}


@end
