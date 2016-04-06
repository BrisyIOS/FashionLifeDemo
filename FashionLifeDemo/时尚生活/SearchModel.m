//
//  SearchModel.m
//  时尚生活
//
//  Created by zhangxu on 15/11/28.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel


+ (NSMutableArray *)modelWithDic:(NSDictionary *)dic{
    NSMutableArray *dataArray = dic[@"data"];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *Dic in dataArray) {
        SearchModel *searchModel = [[SearchModel alloc] init];
        [searchModel setValuesForKeysWithDictionary:Dic];
        [array addObject:searchModel];
    }
    return array;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
