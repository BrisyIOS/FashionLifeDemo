//
//  CategoryModel.h
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *code;

+ (NSMutableArray *)modelWithDic:(NSDictionary *)dic;


@end
