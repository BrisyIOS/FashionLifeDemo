//
//  ShowTarentoModel.h
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowTarentoModel : NSObject

@property(nonatomic, strong)NSString *content;
@property(nonatomic, strong)NSString *goods_name;
@property(nonatomic, strong)NSString *owner_name;
@property(nonatomic, strong)NSString *rec_reason;
@property(nonatomic, strong)NSMutableArray *images_item;
@property(nonatomic, strong)NSString *brand_name;
@property(nonatomic, strong)NSString *brand_desc;
@property(nonatomic, strong)NSString *goods_desc;
@property(nonatomic, strong)NSString *goods_url;
@property(nonatomic, strong)NSString *owner_image;



@end
