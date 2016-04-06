//
//  StoreModel.m
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "StoreModel.h"

@implementation StoreModel


// 首页---滑条
+ (NSMutableArray *)modelObjectWithDictionary:(NSDictionary *)dict{
    NSDictionary *dataDic = dict[@"data"];
    NSDictionary *slideDic = dataDic[@"slide"];
    NSMutableArray *dataArray = slideDic[@"data"];
    NSMutableArray *slideArray = [NSMutableArray array];
    for (NSDictionary *Dic in dataArray) {
        StoreModel *storeModel = [[StoreModel alloc] init];
        [storeModel setValuesForKeysWithDictionary:Dic];
            [slideArray addObject:storeModel];
    }
    
    return slideArray;
}

// 首页---list
+ (NSMutableArray *)modelWithDic:(NSDictionary *)dic{
    NSDictionary *dataDic = dic[@"data"];
    NSDictionary *listDic = dataDic[@"list"];
    NSMutableArray *dataArray = listDic[@"data"];
    NSMutableArray *listArray = [NSMutableArray array];
    for (int i = 0; i < dataArray.count; i++) {
        if (i == 0) {
            NSMutableArray *array1 = [NSMutableArray array];
            // one
            NSDictionary *oneDic = dataArray[0][@"one"];
            StoreModel *model1 = [[StoreModel alloc] init];
            [model1 setValuesForKeysWithDictionary:oneDic];
            [array1 addObject:model1];
            
            // two
            NSDictionary *twoDic = dataArray[0][@"two"];
            StoreModel *model2 = [[StoreModel alloc] init];
            [model2 setValuesForKeysWithDictionary:twoDic];
            [array1 addObject:model2];
            
            
            // three
            NSDictionary *threeDic = dataArray[0][@"three"];
            StoreModel *model3 = [[StoreModel alloc] init];
            [model3 setValuesForKeysWithDictionary:threeDic];
            [array1 addObject:model3];
            
            
            // four
            NSDictionary *fourDic = dataArray[0][@"four"];
            StoreModel *model4 = [[StoreModel alloc] init];
            [model4 setValuesForKeysWithDictionary:fourDic];
            [array1 addObject:model4];
            
            [listArray addObject:array1];
            
        }else if (i == 1){
            NSMutableArray *array2 = [NSMutableArray array];
            NSDictionary *twoDic = dataArray[1][@"one"];
            StoreModel *storeModel = [[StoreModel alloc] init];
            [storeModel setValuesForKeysWithDictionary:twoDic];
            [array2 addObject:storeModel];
            [listArray addObject:array2];
        }else{
            
            // one
            NSMutableArray *array3 = [NSMutableArray array];
            NSDictionary *oneDic = dataArray[2][@"one"];
            StoreModel *model1 = [[StoreModel alloc] init];
            [model1 setValuesForKeysWithDictionary:oneDic];
            [array3 addObject:model1];
            
            
            // two
            NSDictionary *twoDic = dataArray[2][@"two"];
            StoreModel *model2 = [[StoreModel alloc] init];
            [model2 setValuesForKeysWithDictionary:twoDic];
            [array3 addObject:model2];
            
            [listArray addObject:array3];
        }
    }
    
    return listArray;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
