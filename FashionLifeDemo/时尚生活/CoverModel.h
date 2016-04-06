//
//  CoverModel.h
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoverModel : NSObject
@property (nonatomic,copy) NSString *url;
+ (NSMutableArray *)modelWithDic:(NSMutableDictionary *)dic;
@end
