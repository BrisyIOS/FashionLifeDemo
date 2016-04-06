//
//  DownloadManagmenting.h
//  时尚生活
//
//  Created by zhangxu on 15/11/28.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadManagmenting : NSObject

@property(nonatomic, copy)NSString *resumeDataStr;

@property(nonatomic, copy)NSString *fileSize;

@property(nonatomic, copy)NSString *filePath;

@property(nonatomic, assign)float progress;

@property(nonatomic, copy)NSString *url;

@property(nonatomic, assign)double time;

@property(nonatomic, assign)BOOL isResume;


@end
