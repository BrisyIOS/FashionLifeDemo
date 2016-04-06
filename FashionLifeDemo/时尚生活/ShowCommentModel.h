//
//  ShowCommentModel.h
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowCommentModel : NSObject

@property(nonatomic, assign)NSInteger num_items;
@property(nonatomic, strong)NSString *msg;
@property(nonatomic, strong)NSString *user_id;
@property(nonatomic, strong)NSString *create_time;
@property(nonatomic, strong)NSString *user_image;
@property(nonatomic, strong)NSString *user_name;

@end
