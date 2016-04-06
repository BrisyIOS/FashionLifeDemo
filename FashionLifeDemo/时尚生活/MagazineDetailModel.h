//
//  MagazineDetailModel.h
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MagazineDetailModel : NSObject

@property (nonatomic, strong) NSString *author_name;// 作者名字
@property (nonatomic, strong) NSString *note;// 子标题
@property (nonatomic, strong) NSString *thumb;//图片
@property (nonatomic, strong) NSString *cat_name;// 类型
@property (nonatomic, strong) NSString *author_id;// 作者id
@property (nonatomic, strong) NSString *cat_id;// 分类的id

@end
