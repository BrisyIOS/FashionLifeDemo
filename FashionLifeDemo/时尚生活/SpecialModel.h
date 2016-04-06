//
//  SpecialModel.h
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecialModel : NSObject
@property (nonatomic,copy) NSString *cover_img;
@property (nonatomic,copy) NSString *topic_name;
@property (nonatomic,copy) NSString *cat_name;
@property (nonatomic,copy) NSString *access_url;
+ (NSMutableArray *)modelWithDic:(NSMutableDictionary *)dic;
@end
