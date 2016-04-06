//
//  SearchModel.h
//  时尚生活
//
//  Created by zhangxu on 15/11/28.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModel : NSObject
@property (nonatomic,copy) NSString *goods_image;
@property (nonatomic,copy) NSString *goods_id;

+ (NSMutableArray *)modelWithDic:(NSDictionary *)dic;

@end
