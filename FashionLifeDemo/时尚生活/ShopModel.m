//
//  ShopModel.m
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "ShopModel.h"

@implementation ShopModel

// 数据解析
+ (NSMutableArray *)modelWithDic:(NSDictionary *)dic{
    NSDictionary *dataDic = dic[@"data"];
    NSMutableArray *dataArray = dataDic[@"data"];
    NSMutableArray *shopArray = [NSMutableArray array];
    for (NSDictionary *Dic in dataArray) {
        ShopModel *model = [[ShopModel alloc] init];
        [model setValuesForKeysWithDictionary:Dic];
        [shopArray addObject:model];
    }
    return shopArray;
}


+ (NSMutableArray *)categoryModelWithDic:(NSDictionary *)dic{
    NSMutableArray *dataArray = dic[@"data"];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *Dic in dataArray) {
        ShopModel *model = [[ShopModel alloc] init];
        [model setValuesForKeysWithDictionary:Dic];
        [array addObject:model];
    }
    return array;
}




// 解析跳转到商品详情页面的数据
+ (NSMutableArray *)shopModelWithDic:(NSDictionary *)dic{
    NSDictionary *dataDic = dic[@"data"];
    NSMutableArray *goodsArray = dataDic[@"goods"];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *Dic in goodsArray) {
        ShopModel *model = [[ShopModel alloc] init];
        [model setValuesForKeysWithDictionary:Dic];
        [array addObject:model];
    }
    return array;
}



- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
