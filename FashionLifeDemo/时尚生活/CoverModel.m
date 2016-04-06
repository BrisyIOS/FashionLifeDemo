//
//  CoverModel.m
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "CoverModel.h"

@implementation CoverModel
+ (NSMutableArray *)modelWithDic:(NSMutableDictionary *)dic{
    NSDictionary *dataDic = dic[@"data"];
    NSMutableArray *itemsArray = dataDic[@"items"];
    NSMutableArray *coverArray = [NSMutableArray array];
    for (NSDictionary *Dic in itemsArray) {
        NSDictionary *coverDic = Dic[@"cover"];
        CoverModel *coverModel = [[CoverModel alloc] init];
        [coverModel setValuesForKeysWithDictionary:coverDic];
        [coverArray addObject:coverModel];
    }
    return coverArray;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
