//
//  MagazineWebController.h
//  时尚生活
//
//  Created by zhangxu on 15/11/26.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MagazineWebController : UIViewController

// 判断是从哪个页面跳转进来的
@property (nonatomic, strong) NSString *topic_url;
@property (nonatomic, strong) NSString *topic_name;
@property (nonatomic, strong) NSString *cover_img_new;

@end
