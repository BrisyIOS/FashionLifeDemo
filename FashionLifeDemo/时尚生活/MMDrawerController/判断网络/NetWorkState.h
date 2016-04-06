//
//  NetWorkState.h
//  17UILessonGetRequset
//
//  Created by zhangxu on 15/10/20.
//  Copyright (c) 2015年 zhangxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface NetWorkState : NSObject


//  此类为判断网络的类  专门判断网络状态  是无网络  移动网络  还是wifi 网络
//  判断网络状态 有可能每一个类（界面） 都会使用到  所以我们进行封装  并且成为单例类 方便每一个界面进行使用
+ (NetWorkState *)shareInstance;


//  判断网络状态的
//  我们的这个方法  是基于第三方  Reachability 返回值为一个BOOL 类型  NO 代表没有网络  YES 代表有网络
- (BOOL)reachability;
@end
