//
//  StoreModel.h
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreModel : NSObject
@property (nonatomic,copy) NSString *pic_url;
@property (nonatomic,copy) NSString *topic_url;
@property (nonatomic,copy) NSString *topic_name;
@property (nonatomic,strong) NSString *content_id;
@property (nonatomic,assign) NSInteger pic_urlHeight;


// 首页---滑条
+ (NSMutableArray *)modelObjectWithDictionary:(NSDictionary *)dict;


// 首页---list
+ (NSMutableArray *)modelWithDic:(NSDictionary *)dic;

@end
