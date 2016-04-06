//
//  CategoryModel.m
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel
+ (NSMutableArray *)modelWithDic:(NSMutableDictionary *)dic{
    NSDictionary *dataDic = dic[@"data"];
    NSDictionary *itemsArray = dataDic[@"items"];
    NSMutableArray *categoryArray = [NSMutableArray array];
    for (NSDictionary *childrenDic in itemsArray) {
        NSMutableArray *childrenArray = childrenDic[@"children"];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *Dic in childrenArray) {
            CategoryModel *categoryModel = [[CategoryModel alloc] init];
            [categoryModel setValuesForKeysWithDictionary:Dic];
            [array addObject:categoryModel];
        }
        [categoryArray addObject:array];
    }
    return categoryArray;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
