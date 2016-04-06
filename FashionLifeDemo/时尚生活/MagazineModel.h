//
//  MagazineModel.h
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright © 2015年 FashionLife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MagazineModel : NSObject

@property (nonatomic, strong) NSString *cover_img_new;// 封面
@property (nonatomic, strong) NSString *cat_name;// 类型
@property (nonatomic, strong) NSString *topic_name;//标题
@property (nonatomic, strong) NSString *topic_url;//详情的页面

@end
