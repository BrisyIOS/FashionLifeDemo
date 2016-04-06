//
//  ShopModel.h
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopModel : NSObject
@property (nonatomic,strong) NSDictionary *brand_info;//商品品牌
@property (nonatomic,copy) NSString *goods_name;//商品名称
@property (nonatomic,copy) NSString *goods_image;//商品图片
@property (nonatomic,copy) NSString *promotion_imgurl;
@property (nonatomic,copy) NSString *goods_id;
@property (nonatomic,strong) NSArray *images;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *ID;

+ (NSMutableArray *)modelWithDic:(NSDictionary *)dic;
+ (NSMutableArray *)categoryModelWithDic:(NSDictionary *)dic;

// 解析跳转到商品详情页面的数据
+ (NSMutableArray *)shopModelWithDic:(NSDictionary *)dic;
@end
