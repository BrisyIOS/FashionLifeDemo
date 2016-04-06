//
//  NetWorkState.m
//  17UILessonGetRequset
//
//  Created by zhangxu on 15/10/20.
//  Copyright (c) 2015年 zhangxu. All rights reserved.
//

#import "NetWorkState.h"

@implementation NetWorkState
+ (NetWorkState *)shareInstance{
    static NetWorkState *state = nil;
    if (state == nil) {
        state = [[NetWorkState alloc] init];
    }
    return state;
}


- (BOOL)reachability{
    Reachability *r = [Reachability reachabilityWithHostName:@"http://project.zhangxu3g.com/teacher/yihuiyun/zhangxuproject/activitylist.php"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            NSLog(@"没有网络");
            return NO;
            break;
        case ReachableViaWWAN:
            NSLog(@"移动网络");
            return YES;
            break;
        case ReachableViaWiFi:
            NSLog(@"WIFI网络");
            return YES;
            break;
            
        default:
            break;
    }
}








@end
