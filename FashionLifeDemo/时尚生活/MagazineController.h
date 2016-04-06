//
//  MagazineController.h
//  时尚生活
//
//  Created by zhangxu on 15/11/25.
//  Copyright (c) 2015年 FashionLife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MagazineController : UITableViewController

// 判断是从哪个页面跳转进来的
@property (nonatomic, assign) BOOL isClassify; // 分类页面
@property (nonatomic, assign) BOOL isAuthor;   // 作者页面
@property (nonatomic, strong) NSString *author_name;
@property (nonatomic, strong) NSString *cat_name;

// 接收传过来的url
@property (nonatomic, copy) NSString *url;

@end
