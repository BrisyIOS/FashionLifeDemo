//
//  SpecialModel.m
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import "SpecialModel.h"

@implementation SpecialModel
+ (NSMutableArray *)modelWithDic:(NSMutableDictionary *)dic{
    NSMutableArray *dataArray = dic[@"data"];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *Dic in dataArray) {
        SpecialModel *model = [[SpecialModel alloc] init];
        [model setValuesForKeysWithDictionary:Dic];
        [array addObject:model];
    }
    return array;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
